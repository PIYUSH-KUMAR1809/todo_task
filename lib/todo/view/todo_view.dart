import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_dev_task/auth/view/login_view.dart';
import 'package:todo_dev_task/todo/controller/todo_controller.dart';

import '../../utilities/logger.dart';
import '../model/todo_model.dart';

ToDOController toDOController = Get.put(ToDOController());

class ToDOScreen extends StatefulWidget {
  String imageURL;
  ToDOScreen({required this.imageURL, super.key});

  @override
  State<ToDOScreen> createState() => _ToDOScreenState();
}

class _ToDOScreenState extends State<ToDOScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toDOController.getToDO();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              logger.i('exit logic here');
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Get.back(); // Dismiss the dialog
                          },
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            toDOController.logout();
                            Get.offAll(() =>
                                const LoginScreen()); // Dismiss the dialog
                            // Add your logout logic here
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    );
                  });
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                foregroundImage: NetworkImage(widget.imageURL),
              ),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              children: [
                Obx(() {
                  if (toDOController.isLoading.value) {
                    return const Column(
                      children: [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  } else if (toDOController.hasData.value == false) {
                    return const Column(
                      children: [
                        Center(
                          child: Text('No ToDos for this user'),
                        ),
                      ],
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Today',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => ListView.builder(
                                    physics: ScrollPhysics(
                                      parent: NeverScrollableScrollPhysics(),
                                    ),
                                    shrinkWrap: true,
                                    itemCount: toDOController.todos.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: Checkbox(
                                          value: toDOController
                                              .todos[index].completed,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              toDOController
                                                      .todos[index].completed =
                                                  !toDOController
                                                      .todos[index].completed;
                                            });
                                          },
                                        ),
                                        title: Text(
                                          toDOController.todos[index].todo,
                                          style: TextStyle(
                                            decoration: toDOController
                                                    .todos[index].completed
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                          ),
                                        ),
                                        subtitle: const Text('12:42 PM'),
                                      );
                                    }),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Tomorrow',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Obx(
                                () => ListView.builder(
                                    physics: ScrollPhysics(
                                      parent: NeverScrollableScrollPhysics(),
                                    ),
                                    shrinkWrap: true,
                                    itemCount: toDOController.otherTasks.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading:
                                            const Icon(Icons.circle, size: 12),
                                        title: Text(
                                          toDOController.otherTasks[index],
                                          style: const TextStyle(
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                        subtitle: const Text('12:42 PM'),
                                      );
                                    }),
                              ),
                              // const SizedBox(height: 24),
                              // const Text(
                              //   'Tomorrow',
                              //   style: TextStyle(
                              //       fontSize: 24, fontWeight: FontWeight.bold),
                              // ),
                              // const SizedBox(height: 8),
                              // _buildTaskList(false),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return const AddTaskSheet();
              },
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Widget _buildTaskList(bool isToday) {
  //   return Column(
  //     children: List.generate(4, (index) {
  //       return ListTile(
  //         leading: isToday
  //             ? Checkbox(
  //                 value: index == 2,
  //                 onChanged: (bool? value) {},
  //               )
  //             : const Icon(Icons.circle, size: 12),
  //         title: Text(
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
  //           style: TextStyle(
  //             decoration: (isToday && index == 2)
  //                 ? TextDecoration.lineThrough
  //                 : TextDecoration.none,
  //           ),
  //         ),
  //         subtitle: const Text('12:42 PM'),
  //       );
  //     }),
  //   );
  // }
}

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  _AddTaskSheetState createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  bool isToday = true;
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController _nameController = TextEditingController();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 41);

  SheetController sheetController = Get.put(SheetController());

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Close'),
                ),
                const Text(
                  'Task',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 48), // Space for alignment
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Add a task',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Text(
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Lorem ipsum dolor',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    const Text(
                      'Hour',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () => _selectTime(context),
                      child: Row(
                        children: <Widget>[
                          Text(
                            _selectedTime.format(context),
                            style: const TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Obx(
                  () => Switch(
                    value: sheetController.isToday.value,
                    onChanged: (value) {
                      sheetController.changeIsToday();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                if (_nameController.text.isEmpty) {
                  Get.back();
                } else {
                  if (sheetController.isToday.value == true) {
                    Todo todo = Todo(
                        id: 1,
                        todo: _nameController.text,
                        completed: false,
                        userId: int.parse(toDOController.uid!));
                    toDOController.todos.add(todo);
                    Get.back();
                  } else {
                    toDOController.otherTasks.add(_nameController.text);
                    Get.back();
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: double.infinity,
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'If you disable today, the task will be considered as tomorrow',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
