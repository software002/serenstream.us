import 'dart:convert';
import 'dart:math';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:serenestream/Constants/AppSizer.dart';
import 'package:serenestream/Constants/colors.dart';
import 'package:serenestream/home/dashboard_screen.dart';
import 'package:serenestream/meditation/timer_screen.dart';
import 'package:serenestream/utils/storage_service.dart';
import 'package:serenestream/utils/util_klass.dart';
import '../utils/AppCommonFeatures.dart';
import '../utils/WaveClip.dart';
import '../utils/commonWidget.dart';
import 'package:bubble_chart/bubble_chart.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final CommonWidget commonWidget = CommonWidget();
  String msg_response = "";
  var isTyping = false;

  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'message': _controller.text,
          'isMe': true,
        });
        chatUi();
        // Simulate a response from another user
        /*   if(msg_response!=""){
          _messages.add({
            'message': '${msg_response}',
            'isMe': false,
          });
        }*/
      });
      _controller.clear();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  init() async {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buttonColor,
      appBar: AppBar(
        toolbarHeight: 70.h,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: SizedBox(
                width: 36.w,
                height: 36.h,
                child: Image.asset(
                    AppCommonFeatures.instance.imagesFactory.back_blue)),
          ),
        ),
        centerTitle: true,
        title: Text(
          "AI Chat Bot",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp),
        ),
        elevation: 0,
        backgroundColor: AppColors.buttonColor,
      ),
      body: Container(
        height: ScreenUtil().screenHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Text(
                    "Today",
                    style: TextStyle(
                        color: AppColors.blackshade,
                        fontWeight: FontWeight.w400,
                        fontSize: AppSizer.sixteen),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[_messages.length - 1 - index];
                    return ChatBubble(
                      clipper: ChatBubbleClipper1(
                        type: message['isMe']
                            ? BubbleType.sendBubble
                            : BubbleType.receiverBubble,
                      ),
                      alignment: message['isMe']
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      margin: EdgeInsets.only(top: 20),
                      backGroundColor:
                          message['isMe'] ? AppColors.pinkColor : Colors.white,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyLarge,
                              children: [
                                TextSpan(
                                  text: message['message'],
                                  style: TextStyle(
                                    fontSize: AppSizer.sixteen,
                                    fontWeight: FontWeight.w500,
                                    color: message['isMe']
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: "         ${getCurrentTime()}",
                                  style: TextStyle(
                                    fontSize: AppSizer.tweleve,
                                    fontWeight: FontWeight.w400,
                                    color: message['isMe']
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: isTyping
                    ? Align(
                        child: Row(
                          children: [
                            Text(style: TextStyle(fontWeight: FontWeight.bold),"Serenestream"),
                            Text(" is typing..."),
                          ],
                        ),
                        alignment: Alignment.topLeft,
                      )
                    : Text(""),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: commonWidget.textfield(
                          "write a message..", _controller, false),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    InkWell(
                      onTap: _sendMessage,
                      child: SizedBox(
                          width: 50.w,
                          height: 50.h,
                          child: Image.asset(AppCommonFeatures
                              .instance.imagesFactory.send_im)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> chatUi() async {
    setState(() {
      isTyping = true;
    });

    OpenAI.apiKey = "sk-proj-CTx2fy54OWI1t9rkspQRT3BlbkFJNYhdkJrTmc3H4Mx1D72G";
    // the system message that will be sent to the request.
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(
          "You are a helpful assistant. Respond to user messages appropriately in JSON format."
          /*"Please respond to user inputs."*/
      )],
      role: OpenAIChatMessageRole.system,
    );


    // the user message that will be sent to the request.
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          _controller.text,
        ),

        //! image url contents are allowed only for models with image support such gpt-4.
        /* OpenAIChatCompletionChoiceMessageContentItemModel.imageUrl(
        "https://placehold.co/600x400",
      ),*/
      ],
      role: OpenAIChatMessageRole.user,
    );

// all messages to be sent.
    final requestMessages = [
      systemMessage,
      userMessage,
    ];

// the actual request.
    OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat
        .create(
            model: "gpt-3.5-turbo",
            responseFormat: {"type": "json_object"},
            seed: 6,
            messages: requestMessages,
            temperature: 1,
            maxTokens: 250,
            presencePenalty: 0,
            frequencyPenalty: 0,
            topP: 1,
            n: 1);
    debugPrint(
        "***************************${chatCompletion.choices[0].message.content.toString()}"); // ...

    var msg_response_str = chatCompletion.choices[0].message.content.toString();
    msg_response_str = msg_response_str
        .replaceAll(RegExp(r'\[|\]'), '') // Remove square brackets
        .replaceAll(
            RegExp(
                r'OpenAIChatCompletionChoiceMessageContentItemModel\(type: text, text: '),
            '') // Remove unnecessary text
        .replaceAll(')', '');
    print(msg_response_str); // ...
    // Parse the JSON string
    Map<String, dynamic> jsonMap = json.decode(msg_response_str);

    // Fetch the value of "message"
    msg_response = jsonMap['message'] ?? "notMsg";
    if (msg_response == "notMsg") {
      msg_response = jsonMap['response'] ?? "notResponse";
    }
    if (msg_response == "notResponse") {
      msg_response = msg_response_str;
    }

    // Print the value
    print(msg_response); // Output: flutter

    setState(() {
      // Simulate a response from another user
      if (msg_response != "") {
        setState(() {
          isTyping = false;
        });
        _messages.add({
          'message': '${msg_response}',
          'isMe': false,
        });
        msg_response = "";
      } else {
        _messages.add({
          'message': '${msg_response}',
          'isMe': false,
        });
        msg_response = "";
      }
      _controller.clear();
    });
  }

  static String getCurrentTime() {
    DateTime nowWithTime = DateTime.now();
    return "${nowWithTime.hour}:${nowWithTime.minute}";
  }
}
