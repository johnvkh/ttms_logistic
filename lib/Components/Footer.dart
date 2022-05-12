import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:ttms_logistic/Utility/Constants.dart';
import 'package:ttms_logistic/Utility/WidgetUtility.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String t = "test";
    return ScreenTypeLayout(
      desktop: DesktopFooter(context),
      tablet: TabletMobileFooter(context),
      mobile: TabletMobileFooter(context),
    );
  }

  Widget DesktopFooter(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        color: primaryColor,
        //borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                TextWidget(
                  "Copyright © 2021-2022",
                  Colors.grey,
                  16,
                  FontWeight.normal,
                  TextAlign.start,
                ),
                TextButtonWidget(
                    () {}, "we4289.com", Colors.blue, 16, FontWeight.normal),
                TextWidget(
                  "All rights reserved.",
                  Colors.grey,
                  16,
                  FontWeight.normal,
                  TextAlign.start,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextWidget("Version 1.0", Colors.grey, 16, FontWeight.normal,
                TextAlign.start),
          ),
        ],
      ),
    );
  }
}

Widget TabletMobileFooter(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    decoration: BoxDecoration(
      color: primaryColor,
      //borderRadius:  BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget("Copyright © 2021-2022", Colors.grey, 14, FontWeight.normal,
            TextAlign.start),
        TextButtonWidget(
            () {}, "we4289.com", Colors.blue, 14, FontWeight.normal),
        TextWidget("All rights reserved.", Colors.grey, 14, FontWeight.normal,
            TextAlign.start),
      ],
    ),
  );
}
