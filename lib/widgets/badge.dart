import 'package:flutter/material.dart';

class BadgeIcon extends StatelessWidget {
  final Widget? child;
  final int? value;
  final Color? color;

  const BadgeIcon({
    Key? key,
    required Widget? this.child,
    required int? this.value,
    Color? this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child!,
        if (value! > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color != null
                    ? color
                    : Theme.of(context).colorScheme.secondary,
              ),
              constraints: BoxConstraints(minHeight: 16, minWidth: 16),
              child: Text(
                value.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
      ],
    );
  }
}
