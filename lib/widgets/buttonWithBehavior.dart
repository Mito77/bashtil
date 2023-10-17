import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bashtil/widgets/custom_button.dart';

Widget buttonWithBehavior(String text, action, bloc, context, validate, onTap,
    buttonColorGet, textColor,
    {double? textSize}) {
  return CustomButton(
    idleText: text,
    buttonColor: buttonColorGet,

    textSize: 18.sp,
    textColor: textColor,
    buttonBehaviour: bloc.buttonBehavior,
    failedBehaviour: bloc.failedBehaviour,
    validateStream: text == 'register' ? null : validate,
    onTap: () {
      switch (action) {
        case 'login':
          {
            onTap();
          }
          break;
        case 'homeSearch':
          {
            onTap();
          }
          break;
        case 'sendForget':
          {
            onTap();
          }
          break;  case 'sendCodeForget':
          {
            onTap();
          }
          break; case 'changePassword':
          {
            onTap();
          }
          break;
      }
    },
  );
}
