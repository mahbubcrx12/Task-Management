import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/controller/task_controller.dart';
import 'package:task_management/model/task_model.dart';
import 'package:task_management/service/notification_services.dart';
import 'package:task_management/service/theme_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/view/theme.dart';
import 'package:task_management/view/widgets/MyButton.dart';
import 'package:task_management/view/add_task_bar.dart';
import 'package:task_management/view/widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  final _taskController = Get.put(TaskController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    _taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Get.isDarkMode ? darkHeaderClr : white,
      appBar: _appBar(),
      body: Column(
        children: [
          _titleBar(),
          _addDateBar(),
          SizedBox(
            height: 10,
          ),
          _showTask(),
        ],
      ),
    ));
  }

  _showTask() {
    return Expanded(child: Obx(() {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
            TaskModel task = _taskController.taskList[index];
            print(task.toJson());
            if(task.repeat == 'Daily'){
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                      child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showBottomSheet(
                                      context, task);
                                },
                                child: TaskTile(task),
                              ),
                            ],
                          ))));
            }
            if(task.date == DateFormat.yMd().format(_selectedDate)){
              AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                      child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showBottomSheet(
                                      context, task);
                                },
                                child: TaskTile(task),
                              ),
                            ],
                          ))));
            }else{
              return Container();
            }

          });
    }));
  }

  _bottomSheetButton({
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * .9,
        decoration: BoxDecoration(
          border: isClose == true?
          Border.all(
            width: 1,
            color:  Get.isDarkMode ? Colors.white70 : Colors.grey[300]!
          ):Border.all(
              width: 0,
              color:  Get.isDarkMode ? Colors.white70 : Colors.grey[300]!
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(label,
                style:Get.isDarkMode
                    ? titleStyle
                    : titleStyle.copyWith(color: Colors.black))),
      ),
    );
  }

  _showBottomSheet(BuildContext context, TaskModel task) {
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 4),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.25
          : MediaQuery.of(context).size.height * 0.35,
      color: Get.isDarkMode ? darkGreyClr : white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
          ),
          Spacer(),
          task.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  label: "Task Completed",
                  onTap: () {
                    _taskController.markTaskCompleted(task.id!);

                    _taskController.getTasks();
                    Get.back();
                  },
                  clr: primaryClr,
                  context: context),
          SizedBox(
            height: 4,
          ),
          _bottomSheetButton(
              label: "Delete Task",
              onTap: () {
                TaskController().delete(task);
                _taskController.getTasks();
                Get.back();
              },
              clr: Colors.red[200]!,
              context: context),
          SizedBox(
            height: 20,
          ),
          _bottomSheetButton(
            isClose: true,
              label: "Close",
              onTap: () {
                Get.back();
              },
              clr: Colors.transparent,
              context: context)
        ],
      ),
    ));
  }

  _titleBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            //margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMd().format(DateTime.now()),
                    style: subHeadingStyle),
                Text(
                  "Today",
                  style: headingStyle,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: MyButton(
              label: "+ Add Task",
              onTap: () async {
                await Get.to(() => AddTaskPage());
                //_taskController.getTasks();
              },
            ),
          )
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 15),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey)),
        dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.dialogBackgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activated light Theme"
                  : "Activated dark theme");
          notifyHelper.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
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
