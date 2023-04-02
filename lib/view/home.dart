import 'package:flutter/material.dart';
import 'package:task_management/service/notification_services.dart';
import 'package:task_management/service/theme_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/view/theme.dart';
import 'package:task_management/view/widgets/MyButton.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child:Scaffold(
          appBar: _appBar(

          ),
          body: Column(
           children: [

             Container(
               margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
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
                         Text("Today",
                         style: headingStyle,)
                       ],
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(right: 0),
                     child: MyButton(onTap: (){}, label: "+ Add Task"),
                   )
                 ],
               ),
             )
           ],
           ),
        )
    );
  }

  _appBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.dialogBackgroundColor,
      leading: GestureDetector(
        onTap: (){
            ThemeService().switchTheme();
            notifyHelper.displayNotification(
              title: "Theme Changed",
              body:Get.isDarkMode ? "Activated light Theme" : "Activated dark theme"
            );
            notifyHelper.scheduledNotification();
        },
        child: Icon(Get.isDarkMode ? Icons.wb_sunny_outlined:Icons.nightlight_outlined,
        size: 20,
        color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 16,
          backgroundImage: AssetImage("assets/personicon.png"),
          // child: Padding(
          //   padding: const EdgeInsets.all(0.0),
          //   child: Image.asset('assets/personicon.png'),
          // ),
        ),
        SizedBox(width:20 ,)
      ],
    );
  }


}
