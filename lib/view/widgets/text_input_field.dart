import 'package:flutter/material.dart';
import 'package:task_management/view/theme.dart';

class InputTextField extends StatelessWidget {
  String? hintText;
  TextEditingController controller;
  InputTextField({Key? key,required this.hintText,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black38
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.black26,
            width: 2
          )
        ),
       focusedBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(12),
         borderSide: BorderSide(
           color: Colors.black26,
           width: 2
         )
       )

      ),
    );
  }
}
