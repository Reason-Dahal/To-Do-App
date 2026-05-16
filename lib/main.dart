import 'package:flutter/material.dart';
import 'package:flutter_basic/home_screen.dart';
import 'package:flutter_basic/profile_screen.dart';

void main() {
  runApp(const TodoApp());
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
        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                accountName: Text("Reason"),
                accountEmail: Text("rsondahal@gmail.com"),
                currentAccountPictureSize: Size(40, 40),
                currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  const ProfileScreen() as Route<Object?>,
                );
              },
            ),
            ListTile(leading: Icon(Icons.home), title: Text("Home")),
            ListTile(leading: Icon(Icons.settings), title: Text("Setting")),
          ],
        ),
      ),
    );
  }
}
