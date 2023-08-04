import 'package:flutter/material.dart';

class ListDetail extends StatelessWidget {
  String title = 'title';
  String detail = 'detail';

  ListDetail({super.key, required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(detail),
    );
  }
}
