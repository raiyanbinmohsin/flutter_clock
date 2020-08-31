import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'clock_view.dart';

class ClockPage extends StatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEEE, d MMMM y').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    timezoneString = timezoneString.substring(0, timezoneString.length - 3);
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) offsetSign = '+';

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
  }
}
