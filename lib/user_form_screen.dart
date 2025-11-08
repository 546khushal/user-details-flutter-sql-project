import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'user_list_screen.dart';

class UserFormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserFormScreenState();
}

class UserFormScreenState extends State<UserFormScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<void> saveUser() async {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      await dbHelper.insertUser({
        "username": username,
        "email": email,
        "password": password,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User Saved!")),
      );

      usernameController.clear();
      emailController.clear();
      passwordController.clear();
    }
  }

  void loadUsers() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(title: Text("SQLite User Form"));

    Column column = Column(
      children: [
        TextField(
          controller: usernameController,
          decoration: InputDecoration(labelText: "Username"),
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(labelText: "Email"),
        ),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(labelText: "Password"),
        ),
        SizedBox(height: 20),
        ElevatedButton(onPressed: saveUser, child: Text("Save")),
        ElevatedButton(onPressed: loadUsers, child: Text("View Users")),
      ],
    );

    Scaffold scaffold = Scaffold(
      appBar: appBar,
      body: Padding(padding: EdgeInsets.all(16), child: column),
    );

    return scaffold;
  }
}
