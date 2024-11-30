import 'package:flutter/material.dart';
import 'package:flutter_rpg/styles.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({required this.onPressed, required this.child, super.key});

  final Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryColor, AppColors.primaryAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: child,
      ),
    );
  }
}
