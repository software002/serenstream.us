import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:serenestream/auth/screens/login_screen.dart';
import 'package:serenestream/chat/chat_screen.dart';
import 'package:serenestream/home/home_screen.dart';
import 'package:serenestream/home/select_music_screen.dart';
import 'package:serenestream/meditation/set_duration_screen.dart';
import 'package:serenestream/questions/test_mood_screen.dart';
import 'package:serenestream/utils/logx.dart';
import 'package:serenestream/utils/util_klass.dart';

import '../Constants/colors.dart';
import '../utils/AppCommonFeatures.dart';
import '../utils/storage_service.dart';
import '../widgets/common_widget_methods.dart';


class DashboardScreen extends StatefulWidget {

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  var isNotification=false;
  PersistentTabController _controller_p= PersistentTabController(initialIndex: 0);
  bool isMeditate=false;
  final controller = CarouselController();
  int _selectedIndex = 0;
  List<Widget> _pages = [];
  var currentSelectTab = 0;



  @override
  void initState() {
    // TODO: implement initState
    _pages = [
      HomeScreen(),
      SelectMusicScreen(),
      SetDurationScreen(),
      ChatScreen()
    ];
    init();
    super.initState();

  }



  @override
  void dispose() {
    super.dispose();
  }

  init() async {

    //
    if(UtilKlass.getCurrentPhase()=="Good Morning" && StorageService.getData(StorageKeys.isMorningQuizDone.toString(), false)==false){
      StorageService.saveData(StorageKeys.isNotification.toString(), true);
      isNotification=true;
    }else if(UtilKlass.getCurrentPhase()=="Good Night" && StorageService.getData(StorageKeys.isNoonQuizDone.toString(), false)==false){
      isNotification=true;
      StorageService.saveData(StorageKeys.isNotification.toString(), true);

    }else if(UtilKlass.getCurrentPhase()=="Good afternoon" && StorageService.getData(StorageKeys.isNoonQuizDone.toString(), false)==false){
      isNotification=true;
      StorageService.saveData(StorageKeys.isNotification.toString(), true);

    }else if(StorageService.getData(StorageKeys.isNoonQuizDone.toString(), false)==false && StorageService.getData(StorageKeys.isMorningQuizDone.toString(), false)==false && StorageService.getData(StorageKeys.isNightQuizDone.toString(), false)==false && StorageService.getData(StorageKeys.isNotification.toString(), false)==true){
      isNotification=true;
      StorageService.saveData(StorageKeys.isNotification.toString(), true);

    }else {
      isNotification=false;
      StorageService.saveData(StorageKeys.isNotification.toString(), false);

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body:PersistentTabView(
        context,
        controller: _controller_p,
        screens: _pages,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: AppColors.buttonColor, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: false, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.

        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,

        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),

        ),
        navBarStyle: NavBarStyle.style1,

        // Choose the nav bar style with this property.

    ),
    );
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage(AppCommonFeatures.instance.imagesFactory.home_icon)),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: AppColors.greyColor,
        onPressed: (p) {
          _controller_p.index = 0;
          currentSelectTab = 0;

        },
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage(AppCommonFeatures.instance.imagesFactory.music_icon)),
        title: ("Music"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: AppColors.greyColor,
        onPressed: (r) {
          _controller_p.index = 1;
          currentSelectTab = 1;

        },
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage(AppCommonFeatures.instance.imagesFactory.meditation_icon)),
        title: ("Meditation"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: AppColors.greyColor,
    onPressed: (r) {
      _controller_p.index = currentSelectTab;
      UtilKlass.navigateScreenTop( SetDurationScreen());

    },


      ),
      PersistentBottomNavBarItem(

        icon: ImageIcon(AssetImage(AppCommonFeatures.instance.imagesFactory.chat_icon)),
        title: ("Chat"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: AppColors.greyColor,
    onPressed: (r) {
      _controller_p.index = currentSelectTab;
      UtilKlass.navigateScreenTop(ChatScreen());


    },
      ),
    ];
  }
  callDeleteFromFirestore() async {
    final _db = FirebaseFirestore.instance;
    await _db.collection("users").doc(StorageService.getData(StorageKeys.emailId.toString(),"")).delete().then((value) => {
    UtilKlass.hideProgressAppLoading(),
        StorageService.clearData(),
    UtilKlass.navigateScreenOffAll(LoginScreen())

    });


  }
  getAppBar() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.yMMMMd('en_US').format(now);
    return AppBar(
      leading: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 20.w,),
          SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(AppCommonFeatures.instance.imagesFactory.calendar_img)),
          SizedBox(width: 6.w,),
          Text('$formattedDate',style: TextStyle(color: Colors.white),),
        ],
      ),
      actions: [
        InkWell(
          focusColor: AppColors.lightblue,
          splashColor: AppColors.lightblue,
          onTap: () {
            setState(() {
              StorageService.saveData(StorageKeys.isNotification.toString(), false);
            });


            UtilKlass.navigateScreen(TestMoodScreen());
          },
          child: Row(
            children: [
              Image.asset(
                StorageService.getData(StorageKeys.isNotification.toString(), false) ? AppCommonFeatures.instance.imagesFactory.notification_on :AppCommonFeatures.instance.imagesFactory.notification_bell,
                height: 22,
                width: 22,
              ),
              SizedBox(width: 5.w,),
               InkWell(
                 onTap: (){
                   CommonWidgetMethods.showPopupDialog(
                       "Are you sure want to delete your account?",
                       "Confirmation","Yes","No",
                       context,
                           () => {
                         Navigator.of(context).pop(true),
                             deleteUserAccount() ,
                       },
                           () => Navigator.of(context).pop(true));
                 },
                   child: Icon(Icons.delete_outline,size: 22,color: AppColors.white,)),

              SizedBox(width: 20.w,),

            ],
          ),),

      ],

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 20.w,),

                topProfileWidget(""),
                SizedBox(width: 20,),
                FutureBuilder<void>(
                  future: UtilKlass.saveUserData(),
                    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } /*else if (!snapshot.hasData) {
                        return Center(
                          child: Text("${UtilKlass.getCurrentPhase()}, User",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white)),
                        );
                      } */else {
                        return Center(
                          child: Text("${UtilKlass.getCurrentPhase()}, ${StorageService.getData(StorageKeys.userName.toString(),"")}",
                              style: TextStyle(

                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white)),
                        );
                      }
                },

                ),


              ],
            ),
            SizedBox(height: 15,),
           // searchBarWidget(),

            /**/
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      flexibleSpace: Image.asset(
          AppCommonFeatures.instance.imagesFactory.home_header,
          fit: BoxFit.fill),
      automaticallyImplyLeading: false,
      elevation: 0.0,
      titleSpacing: 10.0,
      centerTitle: true,

    );
  }



  Widget topProfileWidget(String? avatar) {
    return GestureDetector(
      onTap: () {

      },
      child: SizedBox(
        height: 46,
        width: 46,
        child: Stack(
          children: [
            Positioned.fill(
              top: 8,
              left: 8,
              child: Align(
                alignment: Alignment.center,
                child: Stack(alignment: Alignment.center, children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(color: Colors.red, width: 20)),
                      height: 36,
                      width: 36),
                  /* ClipRRect(
                    borderRadius: BorderRadius.circular(65),
                    child:*/
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image(
                      width: 36.w,
                      height: 36.h,
                      image: AssetImage(AppCommonFeatures.instance.imagesFactory.male_icon),
                    ),
                  ),
                  //  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> deleteUserAccount() async {
    try {
      UtilKlass.showProgressAppLoading(context);
      await FirebaseAuth.instance.currentUser!.delete();
      callDeleteFromFirestore();

    } on FirebaseAuthException catch (e) {
      UtilKlass.hideProgressAppLoading();
     print(e);

      if (e.code == "requires-recent-login") {
        await _reauthenticateAndDelete();
        UtilKlass.hideProgressAppLoading();

      } else {
        // Handle other Firebase exceptions
        UtilKlass.hideProgressAppLoading();
      }
    } catch (e) {
      print(e);

      // Handle general exception
    }
  }
  Future<void> _reauthenticateAndDelete() async {
    try {
      UtilKlass.showProgressAppLoading(context);

      final providerData = FirebaseAuth.instance.currentUser?.providerData.first;

      if (AppleAuthProvider().providerId == providerData!.providerId) {
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithProvider(AppleAuthProvider());
      } else if (GoogleAuthProvider().providerId == providerData.providerId) {
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithProvider(GoogleAuthProvider());
      }

      await FirebaseAuth.instance.currentUser?.delete();
      callDeleteFromFirestore();
    } catch (e) {
      UtilKlass.hideProgressAppLoading();
      // Handle exceptions
    }
  }

}
