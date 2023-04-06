import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/view/widgets/text_input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController titleController =TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: _appBar(context),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Task",style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),),
              SizedBox(height: 20,),
              Text("Title",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),),
              SizedBox(height: 10,),
              InputTextField(
                  hintText: "Enter title here.",
                  controller: titleController
              ),
              SizedBox(height: 15,),
              Text("Note",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),),
              SizedBox(height: 10,),
              InputTextField(
                  hintText: "Enter note here.",
                  controller: noteController
              ),
              SizedBox(height: 10,),
              Text("Note",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),),
              SizedBox(height: 10,),
              InputTextField(
                  hintText: "Enter date here.",
                  controller: dateController
              ),
              // Row(
              //   children: [
              //  Column(
              //    children: [
              //    Text("Start Time",style: TextStyle(
              //        fontSize: 20,
              //        fontWeight: FontWeight.w600,
              //        color: Colors.black
              //    ),),
              //    SizedBox(height: 10,),
              //    InputTextField(
              //        hintText: "Enter date here.",
              //        controller: timeController
              //    ),
              //  ],),
              //
              //   Column(
              //     children: [
              //       Text("End Time",style: TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.w600,
              //           color: Colors.black
              //       ),),
              //       SizedBox(height: 10,),
              //       InputTextField(
              //           hintText: "Enter date here.",
              //           controller: timeController
              //       ),
              //     ],),
              //
              // ],)
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 16,
          backgroundImage: AssetImage("assets/personicon.png"),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

}
