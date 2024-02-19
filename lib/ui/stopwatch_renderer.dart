// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stopwatch/ui/clock_hand.dart';
import 'package:stopwatch/ui/elapsed_time_text.dart';
import 'package:stopwatch/ui/reset_button.dart';

import './clock_markers.dart';
import './elapsed_time_text_basic.dart';

class StopwatchRenderer extends StatelessWidget {
  const StopwatchRenderer({
    Key? key,
    required this.radius,
    required this.elapsed,
  }) : super(key: key);
  final double radius;
  final Duration elapsed;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black12.withOpacity(0.25),
                border: Border.all(width: 3, color: Colors.transparent),
                borderRadius: BorderRadius.circular(radius)),
          ),
          for (var i = 0; i < 60; i++)
            Positioned(
              left: radius,
              top: radius,
              child: ClockSecondsTickMarker(seconds: i, radius: radius),
            ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..translate(radius, radius, 0.0) // center to origin
              ..translate(-5.0, -5, 0.0),
            child: Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.pink),
            ),
          ),
          for (var i = 5; i <= 60; i += 5)
            Positioned(
              top: radius,
              left: radius,
              child: ClockTextMarker(value: i, maxValue: 60, radius: radius),
            ),

          // SizedBox(height: 30, width: 30, child: ResetButton(onPressed: (){},))
        ],
      ),
    );
  }
}
