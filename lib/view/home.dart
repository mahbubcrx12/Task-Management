import 'package:flutter/material.dart';
import 'package:task_management/service/theme_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child:Scaffold(
          appBar: _appBar(),
          body: Column(children: [
            Text("theme",style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),)
          ],),
        )
    );
  }

  _appBar(){
    return AppBar(
      leading: GestureDetector(
        onTap: (){
            ThemeService().switchTheme();
        },
        child: Icon(Icons.nightlight_round,
        size: 20,),
      ),
      actions: [
        Icon(Icons.person,
          size: 20,),
        SizedBox(width:20 ,)
      ],
    );
  }


}
