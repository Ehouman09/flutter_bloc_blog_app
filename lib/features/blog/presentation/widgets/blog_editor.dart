import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {

  const BlogEditor({
    super.key,
    required this.controller,
    required this.hitText
  });

  final TextEditingController controller;
  final String hitText;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hitText
      ),
      maxLines: null,
    );
  }
}
