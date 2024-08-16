import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:just_audio/just_audio.dart';
import 'package:serenestream/Constants/colors.dart';

import '../Constants/AppSizer.dart';
import '../services/navigator_service.dart';
import '../utils/AppCommonFeatures.dart';
import '../utils/storage_service.dart';
import '../utils/util_klass.dart';
import 'controller/PlayerPage.dart';


class SelectMusicScreen extends StatefulWidget {
  const SelectMusicScreen({super.key});

  @override
  State<SelectMusicScreen> createState() => SelectMusicScreenState();
}

class SelectMusicScreenState extends State<SelectMusicScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();

  }

  init() async {
  //  AppCommonFeatures.instance.contextInit(context);

  }

  @override
  void dispose() {

    super.dispose();
    _audioPlayer.stop();
    _audioPlayer.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        NavigationService.removeKeyboard();
      },
      child: Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizer.fifteen,vertical: 50),
              child:StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children:  [
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: GridTile( child: GestureDetector(
                      onTap:()=>  _play(context,"raining.mp3"),
                          //UtilKlass.navigateScreen(PlayMusicScreen()),
                      child: Image(
                          width: 160.w,
                          height:150.h ,
                          image: AssetImage(AppCommonFeatures.instance.imagesFactory.music_one)),
                    )),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: GridTile( child: GestureDetector(
                      onTap:()=>  _play(context,"birdschirping.mp3"),
                          //UtilKlass.navigateScreen(PlayMusicScreen()),
                      child:  Image(
                          width: 160.w,
                          height:150.h ,
                          image: AssetImage(AppCommonFeatures.instance.imagesFactory.music_two)),
                    )),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: GridTile( child: GestureDetector(
                      onTap:()=> _play(context,"ocean.mp3"),
                          //UtilKlass.navigateScreen(PlayMusicScreen()),
                      child:Image(
                          width: 160.w,
                          height:150.h ,
                          image: AssetImage(AppCommonFeatures.instance.imagesFactory.music_three)),
                    )),),

                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child:
                    GridTile( child: GestureDetector(
                        onTap:()=> _play(context,"nature.mp3"),
                        //UtilKlass.navigateScreen(PlayMusicScreen()),
              child:   Image(
                  width: 160.w,
                  height:150.h ,
                  image: AssetImage(AppCommonFeatures.instance.imagesFactory.music_four)),
            )),),

                ],
              )

            ),
          )),
    );
  }

  Future<void> _play(BuildContext context, String music) async {
    try {
      var userStats = <String, dynamic>{
        "email": StorageService.getData(StorageKeys.emailId.toString(),""),
        "session": 1,
        "createdDate":UtilKlass.getCurrentDate()
      };
      UtilKlass.addUserSessionDataInFirestore(userStats,UtilKlass.getCurrentDate(),StorageService.getData(StorageKeys.emailId.toString(),""));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlayerPage(music: music)),
      );
    } catch (e) {
      print("Error playing audio: $e");
    }
  }


 /* Future<void> _play(String music) async {
    try {
      await _audioPlayer.setAsset('assets/music/$music');
      var userStats = <String, dynamic>{
        "email": StorageService.getData(StorageKeys.emailId.toString(),""),
        "session": 1,
        "createdDate":UtilKlass.getCurrentDate()
      };
      UtilKlass.addUserSessionDataInFirestore(userStats,UtilKlass.getCurrentDate(),StorageService.getData(StorageKeys.emailId.toString(),""));
      _audioPlayer.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }*/

}
