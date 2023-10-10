// @dart = 2.19

import 'package:flutter/material.dart';

class GapItem extends StatelessWidget {
  final double width;

  const GapItem({super.key, required this.width});

  @override
  Widget build(BuildContext context) => Container(width: width);
}
