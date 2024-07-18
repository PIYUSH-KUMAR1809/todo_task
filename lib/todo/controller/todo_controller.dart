import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todo_dev_task/todo/model/todo_model.dart';
import 'package:todo_dev_task/utilities/shared_preferences.dart';

import '../../utilities/logger.dart';

class ToDOController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool hasData = false.obs;
  String? imageURL;
  String? uid;
  RxList<Todo> todos = <Todo>[].obs;

  RxList<String> otherTasks = <String>[
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
  ].obs;

  late ToDoModel toDoModel;
  Future<void> getToDO() async {
    isLoading.value = true;
    imageURL = await getUserImage();
    uid = await getUserId();
    String? id = await getUserId();
    final response =
        await http.get(Uri.parse('https://dummyjson.com/todos/user/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      logger.i(data);
      isLoading.value = false;
      hasData.value = true;
      toDoModel = ToDoModel.fromMap(data);
      todos.value = toDoModel.todos;
      logger.i(toDoModel.todos.length);
    } else {
      isLoading.value = false;
      hasData.value = false;
      throw Exception('Failed to load todos');
    }
  }

  Future<void> logout() async {
    await clearUserId();
    await clearFirstName();
    await clearLastName();
    await clearUserEmail();
    await clearUserGender();
    await clearUserImage();
    await clearUserName();
    await clearUserRefreshToken();
    await clearUserToken();
  }
}

class SheetController extends GetxController {
  RxBool isToday = true.obs;

  void changeIsToday() {
    isToday.value = !isToday.value;
  }
}
