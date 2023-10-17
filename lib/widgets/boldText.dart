
import 'package:bashtil/utilities/CustomText.dart';
import 'package:bashtil/utilities/CustomTextStyle.dart';
import 'package:flutter/material.dart';

Widget boldText({text,textAlign,color,fontSize}){
  return  CustomText(
    text: text,
    textAlign:textAlign,
    customTextStyle: BoldStyle(color: color, fontSize: fontSize),
  );
}