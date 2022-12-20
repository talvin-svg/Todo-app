import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({
    super.key,
    required this.name,
    required this.id,
  });

  final String name;
  final int id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: (Container(
        decoration: BoxDecoration(),
        height: 50.0,
        // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Center(
          child: (Text(name)),
        ),
      )),
      onTap: () {},
    );
  }
}
