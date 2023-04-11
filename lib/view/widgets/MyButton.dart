import 'package:flutter/material.dart';
import 'package:task_management/view/theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const MyButton({Key? key,required this.label,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: primaryClr
        ),
        child: Center(
          child: Text(label,
          style: TextStyle(
            color: Colors.white
          ),),
        ),
      ),
    );
  }
}
