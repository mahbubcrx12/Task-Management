import 'package:flutter/material.dart';
import 'package:task_management/service/notification_services.dart';
import 'package:task_management/service/theme_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                Text(DateFormat.yMMMd().format(DateTime.now()))
          ],),
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
