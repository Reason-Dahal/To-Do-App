import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "todo",
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final List<Widget> pages = [const HomeScreen(), const ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List", style: TextStyle(fontSize: 30)),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class Task {
  String name;
  bool isChecked;
  Task({required this.name, this.isChecked = false});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController addController = TextEditingController();

  List<Task> taskList = [];

  void addTask() {
    if (addController.text.isNotEmpty) {
      setState(() {
        taskList.add(Task(name: addController.text));
      });
      addController.clear();
    }
  }

  void deleteTask(int index) {
    setState(() {
      taskList.removeAt(index);
    });
  }

  void editTask(int index) {
    TextEditingController editController = TextEditingController(
      text: taskList[index].name,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: Expanded(child: TextField(controller: editController)),
          actions: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancle"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (editController.text.isNotEmpty) {
                      setState(() {
                        taskList[index].name = editController.text;
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: const Text("Update"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void checkTask(int index, bool? value) {
    setState(() {
      taskList[index].isChecked = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: addController,
                  decoration: InputDecoration(
                    hintText: "Enter a text",
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
                      value: taskList[index].isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          taskList[index].isChecked = value!;
                        });
                      },
                    ),
                    title: Text(taskList[index].name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => editTask(index),
                          icon: Icon(Icons.edit),
                          color: Colors.blue,
                        ),
                        IconButton(
                          onPressed: () => deleteTask(index),
                          icon: Icon(Icons.delete),
                          color: Colors.red,
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
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(child: Text("Profile page")),
    );
  }
}
