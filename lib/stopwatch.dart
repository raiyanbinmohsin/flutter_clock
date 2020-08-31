import 'package:flutter/material.dart';
import 'package:flutter_clock/theme_data.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Stopwatch extends StatefulWidget {
  @override
  _StopwatchState createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {
  final _isHours = true;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Stopwatch',
            style: TextStyle(
                fontFamily: 'ProductSans',
                fontWeight: FontWeight.w700,
                color: CustomColors.primaryTextColor,
                fontSize: 24),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: StreamBuilder<int>(
                    stream: _stopWatchTimer.rawTime,
                    initialData: _stopWatchTimer.rawTime.value,
                    builder: (context, snap) {
                      final value = snap.data;
                      final displayTime =
                          StopWatchTimer.getDisplayTime(value, hours: _isHours);
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              displayTime,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 38,
                                  fontFamily: 'ProductSans',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  height: 120,
                  margin: const EdgeInsets.all(8),
                  child: StreamBuilder<List<StopWatchRecord>>(
                    stream: _stopWatchTimer.records,
                    initialData: _stopWatchTimer.records.value,
                    builder: (context, snap) {
                      final value = snap.data;
                      if (value.isEmpty) {
                        return Container();
                      }
                      Future.delayed(const Duration(milliseconds: 100), () {
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut);
                      });
                      print('Listen records. $value');
                      return ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final data = value[index];
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  '${index + 1} ${data.displayTime}',
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'ProductSans',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(
                                height: 1,
                              )
                            ],
                          );
                        },
                        itemCount: value.length,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Flexible(
                                child: RaisedButton(
                                  padding: const EdgeInsets.all(4),
                                  color: Colors.green,
                                  shape: const StadiumBorder(),
                                  onPressed: () async {
                                    _stopWatchTimer.onExecute
                                        .add(StopWatchExecute.start);
                                  },
                                  child: const Text(
                                    'Start',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flexible(
                          child: RaisedButton(
                            padding: const EdgeInsets.all(4),
                            color: Colors.red,
                            shape: const StadiumBorder(),
                            onPressed: () async {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.stop);
                            },
                            child: const Text(
                              'Pause',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Flexible(
                                child: RaisedButton(
                                  padding: const EdgeInsets.all(4),
                                  color: Colors.deepPurpleAccent,
                                  shape: const StadiumBorder(),
                                  onPressed: () async {
                                    _stopWatchTimer.onExecute
                                        .add(StopWatchExecute.lap);
                                  },
                                  child: const Text(
                                    'Lap',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Flexible(
                                child: RaisedButton(
                                  padding: const EdgeInsets.all(4),
                                  color: Colors.blue,
                                  shape: const StadiumBorder(),
                                  onPressed: () async {
                                    _stopWatchTimer.onExecute
                                        .add(StopWatchExecute.reset);
                                  },
                                  child: const Text(
                                    'Reset',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
