import 'package:flutter/material.dart';
import 'package:flutter_clock/data.dart';
import 'package:flutter_clock/enums.dart';
import 'package:flutter_clock/menu_info.dart';
import 'package:flutter_clock/stopwatch.dart';
import 'package:flutter_clock/theme_data.dart';
import 'package:flutter_clock/alarm_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_clock/clock_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                .toList(),
          ),
          VerticalDivider(
            color: Colors.white,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget child) {
                if (value.menuType == MenuType.clock)
                  return ClockPage();
                else if (value.menuType == MenuType.alarm)
                  return AlarmPage();
                else if (value.menuType == MenuType.stopwatch)
                  return Stopwatch();
                else if (value.menuType == MenuType.timer) return Timer();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return FlatButton(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
          color: currentMenuInfo.menuType == value.menuType
              ? CustomColors.menuBackgroundColor
              : Colors.transparent,
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                currentMenuInfo.imageSource,
                scale: 2.0,
              ),
              SizedBox(height: 16),
              Text(
                currentMenuInfo.title ?? '',
                style: TextStyle(
                    fontFamily: 'ProductSans',
                    color: Colors.white,
                    fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }
}
