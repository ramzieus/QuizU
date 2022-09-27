import 'package:flutter/material.dart';

class QButton extends StatelessWidget {
  const QButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.enabled});

  final String text;
  final VoidCallback? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                enabled ? Theme.of(context).secondaryHeaderColor : Colors.grey,
                enabled ? Theme.of(context).primaryColor : Colors.grey,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
