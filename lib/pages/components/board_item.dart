import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

class BoardItem extends StatelessWidget {
  const BoardItem(
      {super.key,
      required this.index,
      required this.name,
      required this.score});
  final int index;
  final String name;
  final String score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: -8,
            offset: const Offset(0, 8),
            color: Colors.black12.withOpacity(0.15),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 24,
            child: Center(
              child: Text(
                "${index + 1}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: randomAvatar(name, width: 50, height: 50),
          ),
          Expanded(
            flex: 4,
            child: Text(
              name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              score,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromRGBO(252, 171, 33, 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
