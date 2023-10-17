
import 'package:bashtil/ui/home/homePage.dart';
import 'package:bashtil/ui/home/home_bloc.dart';
import 'package:bashtil/ui/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:bashtil/utilities/CustomText.dart';
import 'package:bashtil/utilities/CustomTextStyle.dart';
import 'package:bashtil/utilities/app_colors.dart';
import 'package:bashtil/widgets/custom_bottom_sheet_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewHelper {
  final BuildContext context;
  final bool fullScreen;

  ViewHelper(this.context, {this.fullScreen = false});

  Future<dynamic> pushScreen(dynamic widget, {bool hasBackStack = false}) {
    if (!hasBackStack)
      return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget,
          ));
    else
      return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => widget,
          ));
  }

  Route _createRoute(widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeIn;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  showSnakeBar(String text,
      {SnackBarAction? action,
      Color snakeColorBackGround = accentColor,
      Color textColor = Colors.white,
      double elevation = 0.0,
      int durationInMilliSeconds = 2000}) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        alignment: Alignment.center,
        height: 20.h,
        child: CustomText(
          text: text,
          customTextStyle: SemiBoldStyle(fontSize: 14.sp, color: Colors.white),
        ),
      ),
      backgroundColor: snakeColorBackGround,
      elevation: elevation,
      behavior: SnackBarBehavior.floating,
      action: action,
      padding:
          EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 12.h, bottom: 12.h),
      duration: Duration(milliseconds: durationInMilliSeconds),
    ));
  }

  showDoneDialog(text, done) {
    print('test');
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Icon(
                    done ? Icons.check : Icons.error,
                    color: done ? blackColor : buttonColor,
                    size: 25.sp,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  CustomText(
                    text: text,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    customTextStyle: BoldStyle(
                      fontSize: 17.sp,
                      color: done ? blackColor : buttonColor,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          );
        });
  }
  void showCustomBottomSheetFullScreen(Widget child,
      {Function(dynamic result)? onUpdate}) {
    showAnimatedDialog(
            context: context,
            builder: (context) => CustomBottomSheetDialog(
                  child: child,
                  fullScreen: fullScreen,
                ),
            curve: Curves.fastOutSlowIn,
            alignment: Alignment.center,
            axis: Axis.vertical,
            animationType: DialogTransitionType.slideFromBottomFade,
            duration: Duration(milliseconds: 500),
            barrierDismissible: false,
            barrierColor: Colors.transparent)
        .then((value) {
      if (onUpdate != null) onUpdate(value);
    });
  }

  callPhone({String? phoneNum}) async {
    final Uri params = Uri(
      scheme: 'tel',
      path: phoneNum,
    );

    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  openEmail({@required String? mailTo, String? subject}) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: mailTo,
      query: 'subject=ABELA App Feedback', //add subject and body here
    );

    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  openMap({double? latitude, double? longitude}) async {
    var googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }


  void openHomePageWidget() {
    pushScreen(homePageWidget());
  }
  void openSignUpWidget() {
    pushScreen(SignUpWidget());
  }


}
