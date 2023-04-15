import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/controller/task_controller.dart';
import 'package:task_management/model/task_model.dart';
import 'package:task_management/view/home.dart';
import 'package:task_management/view/theme.dart';
import 'package:task_management/view/widgets/MyButton.dart';
import 'package:task_management/view/widgets/text_input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = "9:00 PM";
  int _selectedRemind = 5;
  List<int> remindList=[
    5,10,15,20
  ];

  String _selectedRepeat = "None";
  List<String> repeatList =[
    'None',
    'Daily',
    'Weekly',
    'Monthly'
  ];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Get.isDarkMode?darkHeaderClr:white,
      appBar: _appBar(context),

      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),
              SizedBox(
                height: 20,
              ),
              InputTextField(hintText: "Enter title", title: "Title",controller: _titleController,),
              SizedBox(
                height: 20,
              ),
              InputTextField(hintText: "Enter note ", title: "Note",controller: _noteController,),
              SizedBox(
                height: 20,
              ),
              InputTextField(
                title: "Date",
                hintText: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                    onPressed: () {
                      _getDateFromUser();
                    },
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: InputTextField(
                    title: "Start Time",
                    hintText: _startTime,
                    widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: Icon(
                          Icons.access_time_sharp,
                          color: Colors.grey,
                        )),
                  )),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: InputTextField(
                    title: "End Time",
                    hintText: _endTime,
                    widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: Icon(
                          Icons.access_time_sharp,
                          color: Colors.grey,
                        )),
                  ))
                ],
              ),
              SizedBox(height: 20,),
              InputTextField(title: "Remind", hintText: "$_selectedRemind minutes early",
              widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.grey,),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(height: 0,),
                  style: subtitleStyle,
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem(
                        value: value.toString(),
                        child: Text(value.toString())
                    );
                  }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedRemind = int.parse(value!);
                  });
                }
                  ,
              ),
              ),
              SizedBox(height: 20,),
              InputTextField(title: "Repeat", hintText: "$_selectedRepeat",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.grey,),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(height: 0,),
                  style: subtitleStyle,
                  items: repeatList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                        value: value.toString(),
                        child: Text(value.toString())
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRepeat = value!;
                    });
                  }
                  ,
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                _colorSelection(),
                  MyButton(label: "Create Task",
                    onTap: (){
                      _validateFields();

                  },),

              ],),

            ],
          ),
        ),
      ),
    );
  }

  _validateFields(){
    if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
      //save data to database
      _addTaskToDatabase();
      Get.to(()=>HomePage());
    }else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
      Get.snackbar("Required", "Fields must be filled !",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white60,
        colorText: Colors.black,
        icon: Icon(Icons.warning_amber_outlined)
      );
    }
  }

  _addTaskToDatabase()async{
   int value = await  _taskController.addTask(
        task:TaskModel(
            title: _titleController.text,
            note: _noteController.text,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startTime,
            endTime: _endTime,
            remind: _selectedRemind,
            repeat: _selectedRepeat,
            color: _selectedColor,
            isCompleted: 0
        )
    );
   print("id issssssssssssssss :" "$value");
  }

  _colorSelection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text("Color",style: titleStyle,),
        SizedBox(height: 10,),
        Wrap(
            children: List<Widget>.generate(3, (index) {
              return GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: index==0 ? primaryClr : index == 1 ? pinkClr :yellowClr,
                    child: _selectedColor == index ? Icon(Icons.done,color: Colors.white,size: 16,) : Container(),
                  ),
                ),
              );
            })
        )

      ],);
  }

  _getDateFromUser() async {
    DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2024));
    if (_datePicker != null) {
      setState(() {
        _selectedDate = _datePicker;
      });
    } else {
      print("it's null or something is wrong");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async{
    var pickedTime =  await _showTimePicker();
    String _formattedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time Canceled.");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formattedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formattedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }

  _timeState() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Start Time",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black26, width: 2)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(DateFormat.jm().format(DateTime.now()),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black26)),
                    Icon(
                      Icons.watch_later_outlined,
                      color: Colors.black26,
                    )
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
                  Text(
                    "End Time",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black26, width: 2)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(DateFormat.jm().format(DateTime.now()),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black26)),
                          Icon(
                            Icons.watch_later_outlined,
                            color: Colors.black26,
                          )
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
      backgroundColor: Get.isDarkMode ? darkHeaderClr : Colors.white,
      leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          )),
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
