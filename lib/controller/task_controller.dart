import 'package:get/get.dart';
import 'package:task_management/db/db_helper.dart';

import '../model/task_model.dart';

class TaskController extends GetxController{

  @override
  void onReady(){
    super.onReady();
  }

  var taskList = <TaskModel>[].obs;

  Future<int> addTask({TaskModel? task})async{
    return await DBHelper.insert(task);
  }

  //Get data from table
  void getTasks()async{
    List<Map<String,dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new TaskModel.fromJson(data)).toList());
  }

  void delete(TaskModel task){
     DBHelper.delete(task);

  }

  void markTaskCompleted(int id)async{
    await DBHelper.update(id);

  }


}