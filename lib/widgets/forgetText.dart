import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bashtil/utilities/CustomText.dart';
import 'package:bashtil/utilities/CustomTextStyle.dart';
import 'package:bashtil/utilities/app_colors.dart';

Widget forgetText(text) {
  return CustomText(
      text: text,
      textAlign: TextAlign.left,
      customTextStyle: MediumStyle(fontSize: 13.sp, color: greyTextForm));
}