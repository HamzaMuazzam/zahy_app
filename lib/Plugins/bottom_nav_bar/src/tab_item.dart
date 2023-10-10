// @dart = 2.19

import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final Widget? iconData;
  final double? iconSize;
  final bool isActive;
  final Color? activeColor;
  final Color? inactiveColor;
  final Widget? child;
  final String? label;

  const TabItem({
    Key? key,
    required this.isActive,
    this.iconData,
    this.iconSize = 24,
    this.activeColor = Colors.deepPurpleAccent,
    this.inactiveColor = Colors.black,
    this.child,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => child ?? _buildDefaultTab();

  Widget _buildDefaultTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),


          iconData??SizedBox(),

        const SizedBox(height: 10),
        Text(
          label ?? "",
          style: TextStyle(
            color: isActive ? activeColor : inactiveColor,
            fontSize: isActive ? 15 : 10,
            fontWeight: isActive ? FontWeight.w700 : null,
          ),
        )
      ],
    );
  }
}
