import 'package:get/get.dart';
import 'package:task_management/db/db_helper.dart';

import '../model/task_model.dart';

class TaskController extends GetxController{

  @override
  void onReady(){
    super.onReady();
  }

  Future<int> addTask({TaskModel? task})async{
    return await DBHelper.insert(task);
  }

}