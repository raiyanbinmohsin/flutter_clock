import 'package:flutter/material.dart';
import 'package:flutter_clock/clock_view.dart';
import 'package:intl/intl.dart';

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
            children: <Widget>[
              buildFlatButton('Clock', 'assets/clock_icon.png'),
              buildFlatButton('Alarm', 'assets/alarm_icon.png'),
              buildFlatButton('Timer', 'assets/timer_icon.png'),
              buildFlatButton('Stopwatch', 'assets/stopwatch_icon.png'),
            ],
          ),
          VerticalDivider(
            color: Colors.white,
            width: 1,
          ),
          Expanded(
            child: Container(
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
                              'UTC' + offsetSign + timezoneString,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFlatButton(String title, String image) {
    return FlatButton(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      color: title == 'Clcok' ? Colors.red : Colors.transparent,
      onPressed: () {},
      child: Column(
        children: <Widget>[
          Image.asset(
            image,
            scale: 1.5,
          ),
          SizedBox(height: 16),
          Text(
            title ?? '',
            style: TextStyle(
                fontFamily: 'ProductSans', color: Colors.white, fontSize: 14),
          )
        ],
      ),
    );
  }
}
