import 'package:flutter/material.dart';

void main() {
  runApp(taskApp());
}

class taskApp extends StatelessWidget {
  const taskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "todo",
      home: homeScreen(),
    );
  }
}

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final List<String> taskList = [];
  final TextEditingController taskController = TextEditingController();
  final List<bool> isChecked = [];

  void addTask() {
    setState(() {
      if (taskController.text.isNotEmpty) {
        taskList.add(taskController.text);
        isChecked.add(false);
        taskController.clear();
      }
    });
  }

  void deleteTask(int index) {
    setState(() {
      taskList.removeAt(index);
      isChecked.removeAt(index);
    });
  }

  void editTask(int index) {
    TextEditingController editController = TextEditingController(
      text: taskList[index],
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: TextField(controller: editController),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancle"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (editController.text.isNotEmpty) {
                    taskList[index] = editController.text;
                  }
                  Navigator.pop(context);
                });
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("To Do List", style: TextStyle(fontSize: 30)),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        leading: Icon(Icons.menu),
        actions: [Icon(Icons.search)],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      hintText: "Enter New Task",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(onPressed: addTask, child: Text("Add")),
              ],
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: isChecked[index],
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked[index] = value!;
                          });
                        },
                      ),
                      title: Text(taskList[index]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => deleteTask(index),
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                          IconButton(
                            onPressed: () => editTask(index),
                            icon: Icon(Icons.edit, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
        ],
      ),
    );
  }
}
