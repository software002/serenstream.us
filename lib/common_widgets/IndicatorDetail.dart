import 'package:flutter/material.dart';
import 'package:serenestream/Constants/colors.dart';


class IndicatorDetail extends AnimatedWidget {

  final int currentIndx;
  final int totalIndex;
   const IndicatorDetail({ required this.totalIndex, required this.currentIndx, required super.listenable});

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
              itemCount: totalIndex,
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
    Color color=Colors.white;


    if(currentIndx == index)
    {
      color=AppColors.deepblue;
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
