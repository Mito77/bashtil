import 'package:bashtil/generated/l10n.dart';
import 'package:bashtil/ui/homePage/homePage.dart';
import 'package:bashtil/utilities/app_colors.dart';
import 'package:bashtil/utilities/shared_pref_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bashtil/bases/base_state.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class MainPageWidget extends BaseStatefulWidget {

  int index;
  MainPageWidget(this.index);
  @override
  _MainPageWidgetViewState createState() => _MainPageWidgetViewState();
}

class _MainPageWidgetViewState extends BaseState<MainPageWidget> {
  var h,
      w,
      data = [],
      routes = [
      ],
      onTap = [],
      index = 1;
  var oldIndex = '';

  void initState() {
    super.initState();
    index=widget.index;
    routes = [
      Container(),
      HomePageWidget(),
      Container(),
    ];
  }

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  Widget getBody(BuildContext context) {
    h = 667.h;
    w = 375.w;
    return Scaffold(
        body: WillPopScope(
            onWillPop: () async {
              if(index==1)

                SystemNavigator.pop();
              else
                setState(() {

                  index=1;
                });
              return false;
            },
            child: mainWidget),
        bottomNavigationBar: Container(
          color:blackColor,
          child: ConvexAppBar(
            style: TabStyle.reactCircle,
            items: [
              TabItem(
                  icon: Icons.credit_card,
                  title: "خدماتى",
                  fontFamily: SharedPRefHelper().getLanguage == 'ar'
                      ? 'Tajawal'
                      : 'Roboto'),
              TabItem(
                  icon: Icons.home,
                  title: S.current.home,
                  fontFamily: SharedPRefHelper().getLanguage == 'ar'
                      ? 'Tajawal'
                      : 'Roboto'),
              TabItem(
                  icon: Icons.person,
                  title: S.current.account,
                  fontFamily: SharedPRefHelper().getLanguage == 'ar'
                      ? 'Tajawal'
                      : 'Roboto'),
            ],
            initialActiveIndex: index,
            color:whiteColor,
            backgroundColor: blackColor,
            onTap: (int i) {
              setState(() {
                print(i);
                index = i;

                if((SharedPRefHelper().getBearerToken==''||
                    SharedPRefHelper().getBearerToken.toString().isEmpty)&&(i==2||i==0))
                {
              //    ViewHelper(context).openLoginWidgetScreen();
                }
              });
            },
          ),
        ));
  }

  Widget get mainWidget => Container(
        width: w,
        child: routes[index],
      );

  @override
  bool isSafeArea() => false;

  @override
  Future<bool> willPopBack() async => true;
}
