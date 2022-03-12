import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColumnCard extends StatelessWidget {
  final bool isElevated;
  final Color color;
  final List<Widget> children;

  const ColumnCard({
    this.color,
    this.children,
    this.isElevated = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: isElevated ? Colors.grey.withOpacity(0.3) : Colors.transparent,
          spreadRadius: 3,
          blurRadius: 6,
          offset: Offset(0, 0), // changes position of shadow
        ),
      ], color: color, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
