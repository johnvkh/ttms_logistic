import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      child: ListView(
        children: [
          DrawerHeader(
            child: Lottie.asset("assets/lottie/truck.json",
                width: 100, height: 100),
          ),
          Column(
            children: [
              DrawerListTile(
                title: "ໜ້າຫຼັກ",
                svgSrc: "assets/icons/menu_dashbord.svg",
                press: () {},
              ),
              if (1 == 1)
                ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  title: const Text("ຈັດການຂໍມູນລົດບັນທຸກ", style: TextStyle(),),
                  leading: Icon(
                    FontAwesomeIcons.truck,
                    size: 17,
                  ),
                  children: <Widget>[
                    ListTile(
                      title: DrawerListTile(
                        title: "ປະເພດລົດບັນທຸກ",
                        svgSrc: "assets/icons/menu_dashbord.svg",
                        press: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/truckType', (route) => false);
                        },
                      ),
                    )
                  ],
                ),
              DrawerListTile(
                title: "Transaction",
                svgSrc: "assets/icons/menu_tran.svg",
                press: () {},
              ),
              DrawerListTile(
                title: "Task",
                svgSrc: "assets/icons/menu_task.svg",
                press: () {},
              ),
              DrawerListTile(
                title: "Documents",
                svgSrc: "assets/icons/menu_doc.svg",
                press: () {},
              ),
              DrawerListTile(
                title: "Store",
                svgSrc: "assets/icons/menu_store.svg",
                press: () {},
              ),
              DrawerListTile(
                title: "Notification",
                svgSrc: "assets/icons/menu_notification.svg",
                press: () {},
              ),
              DrawerListTile(
                title: "Profile",
                svgSrc: "assets/icons/menu_profile.svg",
                press: () {},
              ),
              DrawerListTile(
                title: "Settings",
                svgSrc: "assets/icons/menu_setting.svg",
                press: () {},
              ),
              ListTile(
                horizontalTitleGap: 0,
                title: Text("ຈັດການຂໍ້ມູນທົ່ວໄປ"),
                leading: Icon(
                  FontAwesomeIcons.user,
                  size: 17,
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.black87,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black87),
      ),
    );
  }
}
