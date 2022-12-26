import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  const TextCard(
      {Key? key,
      required this.name,
      required this.icon,
      required this.ontapIcon})
      : super(key: key);

  final String name;

  final IconData icon;
  final VoidCallback ontapIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: ontapIcon,
                    child: Icon(icon),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
