import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/view/theme.dart';
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
          child: SingleChildScrollView(
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
               SizedBox(height: 20,),
                //_timeState(),

                SizedBox(height: 20,),
                Text("Remind",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),),
                SizedBox(height: 10,),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.black26,
                          width: 2
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(".... minutes early",style: TextStyle(color: Colors.black26,fontSize: 16),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Icon(Icons.keyboard_arrow_down_sharp,size: 28,color: Colors.black26,),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Text("Repeat",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),),
                SizedBox(height: 10,),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.black26,
                          width: 2
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("None",style: TextStyle(color: Colors.black26,fontSize: 16),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Icon(Icons.keyboard_arrow_down_sharp,size: 28,color: Colors.black26,),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Expanded(child: _timeState()),

              ],
            ),
          ),
        ),
      ),
    );
  }

  _timeState(){
    return  Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Start Time",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black
            ),),
            SizedBox(height: 10,),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Colors.black26,
                      width: 2
                  )
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(DateFormat.jm().format(DateTime.now()),
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black26)),

                    Icon(Icons.watch_later_outlined,color: Colors.black26,)
                  ],
                ),
              ),
            )

          ],
        ),

        Container(
          width: MediaQuery.of(context).size.width * .4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("End Time",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),),
                  SizedBox(height: 10,),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.black26,
                            width: 2
                        )
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(DateFormat.jm().format(DateTime.now()),
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black26)),

                          Icon(Icons.watch_later_outlined,color: Colors.black26,)
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ],
          ),
        )
      ],
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
