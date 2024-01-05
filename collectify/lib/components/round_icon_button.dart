import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({required this.iconWidget, this.onPressedButton});

  final IconData? iconWidget;
  final void Function()? onPressedButton;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressedButton,
      elevation: 0,
      disabledElevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // shape: CircleBorder(),
      fillColor: Colors.blue,
      constraints: const BoxConstraints.tightFor(
        width: 56,
        height: 56,
      ),
      child: Icon(iconWidget),
    );
  }
}