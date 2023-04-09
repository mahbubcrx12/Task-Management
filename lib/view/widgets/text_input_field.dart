import 'package:flutter/material.dart';
import 'package:task_management/view/theme.dart';
import 'package:get/get.dart';

class InputTextField extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController? controller;
  final Widget? widget;

  const InputTextField(
      {Key? key,
      this.widget,
        required this.title,
      required this.hintText,
      this.controller,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        readOnly: widget == null ? false : true,
                  autofocus: false,
                  cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                  controller: controller,
                  style: subtitleStyle,
                        decoration: InputDecoration(
                          hintText: hintText,
                          hintStyle: subtitleStyle,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.0
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                ),
                    )),
                widget == null ? Container() : Container(child: widget,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
