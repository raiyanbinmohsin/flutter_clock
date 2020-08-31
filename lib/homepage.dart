import 'package:flutter/material.dart';
import 'package:flutter_clock/clock_view.dart';
import 'package:flutter_clock/data.dart';
import 'package:flutter_clock/enums.dart';
import 'package:flutter_clock/menu_info.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEEE, d MMMM y').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    timezoneString = timezoneString.substring(0, timezoneString.length - 3);
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) offsetSign = '+';
    print(timezoneString);

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
                if (value.menuType != MenuType.clock) return Container();

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          'Clock',
                          style: TextStyle(
                              fontFamily: 'ProductSans',
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 24),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              formattedTime,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  color: Colors.white,
                                  fontSize: 64),
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: Align(
                            alignment: Alignment.center,
                            child: ClockView(
                              size: MediaQuery.of(context).size.height / 3,
                            )),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Timezone',
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 24),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.language,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 16),
                                Text(
                                  'UTC ' + offsetSign + timezoneString,
                                  style: TextStyle(
                                      fontFamily: 'ProductSans',
                                      color: Colors.white,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
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
              ? Colors.grey
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
