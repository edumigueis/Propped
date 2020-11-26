import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ShadowText extends StatelessWidget {
  ShadowText(this.data, { this.style, this.opacity, this.color }) : assert(data != null), assert(opacity <= 1 && opacity >= 0 && opacity != null), assert(color != null);

  final String data;
  final TextStyle style;
  final double opacity;
  final Color color;

  Widget build(BuildContext context) {
    return new ClipRect(
      child: new Stack(
        children: [
          new Positioned(
            top: 2.0,
            left: 2.0,
            child: new Text(
              data,
              style: style.copyWith(color: color.withOpacity(opacity)),
            ),
          ),
          new BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: new Text(data, style: style),
          ),
        ],
      ),
    );
  }
}