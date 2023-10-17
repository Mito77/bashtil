import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bashtil/utilities/CustomText.dart';
import 'package:bashtil/utilities/CustomTextStyle.dart';
import 'package:bashtil/utilities/app_colors.dart';

Widget descriptionText(text,fontSize) {
  return CustomText(
      text: text,
      textAlign: TextAlign.center,
      customTextStyle: MediumStyle(fontSize: fontSize, color: accentColor));
}
