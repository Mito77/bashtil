import 'package:bashtil/generated/l10n.dart';
import 'package:bashtil/utilities/CustomText.dart';
import 'package:bashtil/utilities/image_paths.dart';
import 'package:bashtil/utilities/view_helper.dart';
import 'package:bashtil/widgets/custom_button.dart';
import 'package:bashtil/widgets/imageSlider.dart';
import 'package:bashtil/widgets/textStyles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bashtil/bases/base_state.dart';
import 'package:bashtil/utilities/CustomTextStyle.dart';
import 'package:bashtil/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class WelcomePageWidget extends BaseStatefulWidget {
  WelcomePageWidget();

  @override
  _WelcomePageViewState createState() => _WelcomePageViewState();
}

class _WelcomePageViewState extends BaseState<WelcomePageWidget>
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

  Widget get screenDesign => Container(height: h, child: myStackWidget);

  Widget get myStackWidget => Stack(
        children: [
          imageHelper(map, w, h),
          Container(
            color: greyColor.withOpacity(.3),
          ),
          // titleContainer,
          Button
        ],
      );

  Widget get titleContainer {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: h * .15,
        width: w,
        color: whiteColor.withOpacity(.6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < 2; i++)
              CustomText(
                text: i == 0 ? "بشتيل" : "محطة قطارات صعيد مصر",
                customTextStyle:
                    boldTextStyle(28.sp, blackColor.withOpacity(.6)),
              ),
          ],
        ),
      ),
    );
  }

  Widget get Button => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        // Optional: You can adjust the left and right values for horizontal positioning.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < 2; i++)
              Column(
                children: [
                  Container(
                    height: 50.h,
                    width: 150.w,
                    child: CustomButton(
                      idleText: i == 0 ? "Join Now" : "Join Later",
                      buttonColor: i == 0 ? blackColor : whiteColor,
                      onTap: i == 0
                          ? () {
                              ViewHelper(context).openSignUpWidget();
                            }
                          : () {
                              ViewHelper(context).openMainPageWidget(1);
                            },
                      textSize: 20.sp,
                      textColor: i == 0 ? whiteColor : blackColor,
                    ),
                  ),
                  SizedBox(height: 10.0, width: double.infinity),
                  // Add space between containers.
                ],
              ),
          ],
        ),
      );
}
