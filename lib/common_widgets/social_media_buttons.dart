import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class SocialMediaButtons extends StatelessWidget {

  final String? strTitle;
  final String? imgName;
  final VoidCallback? onPressed;

  const SocialMediaButtons({Key? key, this.strTitle, this.imgName, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            child: Image.asset(imgName ?? '', height: 60, width: 60,)),
      ),


    );
  }
}



/*@override
Widget build(BuildContext context) {
  return InkWell(
    splashColor: Colors.transparent,
    onTap: onPressed,
    child:
    Container(
        width: screenWidth,
        height: 60,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFF3F3F3)),
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 20,
            ),
            Image.asset(imgName ?? '', height: 22, width: 22,),
            SizedBox(
              width: screenWidth * 0.15,
            ),
            Text(strTitle ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF00162A),
                fontSize: 16,
                fontFamily: FontFamily.archivo,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            )
          ],
        )
    ),
  );
}*/
