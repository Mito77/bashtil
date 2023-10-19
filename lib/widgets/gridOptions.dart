import 'package:bashtil/utilities/CustomText.dart';
import 'package:bashtil/utilities/app_colors.dart';
import 'package:bashtil/utilities/image_paths.dart';
import 'package:bashtil/widgets/imageSlider.dart';
import 'package:bashtil/widgets/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridLayout {
  final String title;
  final IconData icon;
  final String image;

  GridLayout({required this.title, required this.icon,required this.image});
}

List<GridLayout> options = [
  GridLayout(title: 'Mall', icon: Icons.local_mall,image: mall),
  GridLayout(title: 'SuperMarket', icon: Icons.shopping_cart,image:shopping),
  GridLayout(title: 'Restaurants', icon: Icons.restaurant,image:restaurant),
  GridLayout(title: 'Parking', icon: Icons.local_parking,image:parking),
  GridLayout(title: 'Map', icon: Icons.map,image:map),
  GridLayout(title: 'Contact Us', icon: Icons.phone,image:contactUs),
  GridLayout(title: 'Services', icon: Icons.person,image:services),
  GridLayout(title: 'About Us', icon: Icons.pin_drop,image:aboutUs),
];

class GridOptions extends StatelessWidget {
  final GridLayout layout;

  GridOptions({required this.layout});


  @override
  Widget build(BuildContext context) {
  var  h = 667.h;
  var  w = 375.w;
    return Card(
      child: Stack(children: [
        imageHelper(layout.image, w, h),
        Container(
          color: loginText.withOpacity(.4),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                layout.icon,
                size: 40,
                color: whiteColor,
              ),
              CustomText(
                text: layout.title,
                customTextStyle: boldTextStyle(24.sp, whiteColor),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
