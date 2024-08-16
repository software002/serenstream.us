import 'package:flutter/material.dart';
import '../Constants/AppSizer.dart';
import '../Constants/colors.dart';
import '../Constants/font_family.dart';
import '../Constants/strings.dart';

import 'custom_button.dart';

class PopupIconButtonWidget extends StatelessWidget {
  PopupIconButtonWidget({Key? key, required this.onPressedCancel, required this.onPressedOk, required this.title, required this.topIcon, required this.okButtonText, this.okButtonColor, this.titleDescription}) : super(key: key);

  late String topIcon;
  late String title;
  String? titleDescription;
  late Color? okButtonColor;
  late String okButtonText;
  final VoidCallback onPressedCancel;
  final VoidCallback onPressedOk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: titleDescription != null ? 350 : 290,
          width: screenWidth * 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.asset(
                    topIcon,
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Text(
                    title,
                    style:  TextStyle(
                        
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                        color: Colors.black
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                Visibility(
                  visible: (titleDescription != null) ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
                    child: Text(
                      titleDescription ?? '',
                      style:  TextStyle(
                          
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: AppColors.grayshade
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                             border: Border.all(color: Colors.grey)
                          ),
                          child: TextButton(
                            onPressed: onPressedCancel,
                            child:  Text(
                              Strings.cancel,
                              style: TextStyle(
                                  
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: AppColors.grayshade
                              ),
                            ),
                          ),
                        ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        color: okButtonColor ?? AppColors.deepblue,
                        onPressed: onPressedOk,
                        label: okButtonText,
                      ),
                    )
                  ],
                ),
              ],
            ),
        ),
      ),
    );
  }
}
