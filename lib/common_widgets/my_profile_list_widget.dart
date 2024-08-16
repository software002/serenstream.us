import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/AppSizer.dart';
import '../Constants/colors.dart';
import '../Constants/font_family.dart';
import '../Constants/strings.dart';

class MyProfileListWidget extends StatelessWidget {
  const MyProfileListWidget(
      {super.key, this.imgOption, this.titleOption, this.valueOption, this.showVerified,this.verifiedVisible});

  final String? imgOption;
  final String? titleOption;
  final String? valueOption;
  final bool? showVerified;
  final bool? verifiedVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 18,
            child: Transform.scale(
              scale: 0.7,
              child: Image.asset(
                imgOption ?? '',
                height: 30,
                width: 30,
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: titleOption ?? '',
                          style:  TextStyle(
                              
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text: titleOption == Strings.appName ?' (Optional)' : '',
                          style:  TextStyle(
                              
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.grayshade),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: (verifiedVisible ?? false) ? screenWidth * 0.4 : screenWidth * 0.65,
                    child: Text(
                      valueOption ?? '',
                      style:  TextStyle(
                          
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.grayshade),
                    ),
                  ),
                ],
              )
          ),
           const Spacer(
             flex: 1,
           ),
           Visibility(
             visible: verifiedVisible ?? false,
             child: Container(
               height: 40,
               padding: const EdgeInsets.symmetric(horizontal: 5),
               child:  Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   const Icon( Icons.check , color:  Colors.green , size: 20,),
                   Text(
                     'Verified',
                     style: TextStyle(
                         
                         fontWeight: FontWeight.w400,
                         fontSize: 14,
                         color:  Colors.green),
                   ),
                 ],
               ),
             ),
           )
        ],
      ),
    );
  }
}
