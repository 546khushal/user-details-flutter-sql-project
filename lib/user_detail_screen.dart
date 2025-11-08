import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'user_edit_screen.dart';

class UserDetailScreen extends StatelessWidget {
  final int userId;
  final DatabaseHelper dbHelper = DatabaseHelper();

  UserDetailScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: dbHelper.getUserById(userId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: Text("User Detail")),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        var user = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: Text("User Detail")),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Username: ${user["username"]}",
                    style: TextStyle(fontSize: 18)),
                Text("Email: ${user["email"]}",
                    style: TextStyle(fontSize: 18)),
                Text("Password: ${user["password"]}",
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text("Edit"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserEditScreen(user: user),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: Text("Delete"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    await dbHelper.deleteUser(userId);
                    Navigator.pop(context); // go back after delete
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
