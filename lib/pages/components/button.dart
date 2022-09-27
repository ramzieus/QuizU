import 'package:flutter/material.dart';

class QButton extends StatelessWidget {
  const QButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 25,
                offset: const Offset(0, 5),
                color: Theme.of(context).primaryColor.withOpacity(0.5),
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).secondaryHeaderColor,
                Theme.of(context).primaryColor,
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
