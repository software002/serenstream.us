import 'package:flutter/material.dart';
import 'package:serenestream/Constants/colors.dart';


class Indicator extends AnimatedWidget {

  final PageController controller;
   const Indicator({super.key, required this.controller}) : super(listenable: controller);

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return _createIndicator(index);
              })],
        ),
      ),
    );
  }
  Widget _createIndicator(index) {
    double w=10;
    double h=10;
    double conW=26;
    Color color=AppColors.lightblue;


    if(controller.page==index)
    {
      color=AppColors.brownColor;
      h=6;
      w=36;
      conW=36;
    }

    return SizedBox(
      height: 26,
      width: conW,
      child: Center(
        child: AnimatedContainer(
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(5),
          width: w,
          height: h,
          duration: const Duration(milliseconds:100),
        ),
      ),
    );
  }
}
