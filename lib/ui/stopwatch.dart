import 'package:flutter/material.dart';
import 'package:stopwatch/ui/reset_button.dart';
import 'package:stopwatch/ui/start_stop_button.dart';
import 'package:stopwatch/ui/stopwatch_renderer.dart';
import 'package:stopwatch/ui/stopwatch_ticker_ui.dart';

class Stopwatch extends StatefulWidget {
  @override
  _StopwatchState createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch>
    with SingleTickerProviderStateMixin {
  Duration _previouslyElapsed = Duration.zero;
  Duration _currentlyElapsed = Duration.zero;
  Duration get _elapsed => _previouslyElapsed + _currentlyElapsed;
  bool _isRunning = false;
  // late final Ticker _ticker;
  final _tickerUIKey = GlobalKey<StopwatchTickerUIState>();

  void _toggleRunning() {
    setState(() {
      _isRunning = !_isRunning;
    });
    _tickerUIKey.currentState?.toggleRunning(_isRunning);
  }

  void _reset() {
    setState(() {
      _isRunning = false;
    });
    _tickerUIKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final radius = constraints.maxWidth / 2;
      return Stack(
        children: [
          StopwatchRenderer(elapsed: _elapsed, radius: radius),
          StopwatchTickerUI(key: _tickerUIKey, radius: radius),
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              width: 80,
              height: 80,
              child: ResetButton(
                onPressed: _reset,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 80,
              height: 80,
              child: StartStopButton(
                onPressed: _toggleRunning,
                isRunning: _isRunning,
              ),
            ),
          )
        ],
      );
    });
  }
}
