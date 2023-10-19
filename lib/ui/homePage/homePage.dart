import 'package:bashtil/generated/l10n.dart';
import 'package:bashtil/utilities/CustomText.dart';
import 'package:bashtil/utilities/image_paths.dart';
import 'package:bashtil/utilities/view_helper.dart';
import 'package:bashtil/widgets/appBarCustome.dart';
import 'package:bashtil/widgets/custom_button.dart';
import 'package:bashtil/widgets/gridOptions.dart';
import 'package:bashtil/widgets/imageSlider.dart';
import 'package:bashtil/widgets/textStyles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bashtil/bases/base_state.dart';
import 'package:bashtil/utilities/CustomTextStyle.dart';
import 'package:bashtil/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class HomePageWidget extends BaseStatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends BaseState<HomePageWidget>
    with TickerProviderStateMixin {
  var h, w, boldStyle;

  @override
  void initState() {
    super.initState();

    boldStyle = BoldStyle(fontSize: 24.sp, color: blackTextColor);
  }

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  Widget getBody(BuildContext context) {
    h = 667.h;
    w = 375.w;
    return WillPopScope(
        child: screenDesign,
        onWillPop: () async {
          return false;
        });
  }

  Widget get screenDesign => Container(
        height: h,
        child: SingleChildScrollView(
          child: Column(
            children: [
              appBarCustom(w, h, context,"الصفحه الرئيسيه",(){
                ViewHelper(context).openWelcomePageWidget();
              },true),
              myStackWidget,
            ],
          ),
        ),
      );

  Widget get myStackWidget => Container(
    width: w,
    height: h ,
    child: GridView.custom(
      padding: EdgeInsets.only(
          left: w * .01, right: w * .01, top: h * .01, bottom: h * .01),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
          childCount: options.length+2,
              (BuildContext context, int index) {
        if (index >= 0 && index < options.length) {
          return GridOptions(
            layout: options[index],
          );
        }
      }),
    ),
  );
}
