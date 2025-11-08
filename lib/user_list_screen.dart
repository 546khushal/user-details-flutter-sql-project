import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(title: Text("User List"));

    FutureBuilder futureBuilder = FutureBuilder<List<Map<String, dynamic>>>(
      future: dbHelper.getUsers(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        List<Map<String, dynamic>> users = snapshot.data!;

        if (users.isEmpty) {
          return Center(child: Text("No users found."));
        }

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            var user = users[index];
            return ListTile(
              title: Text(user["username"]),
              subtitle: Text(user["email"]),
              trailing: Text(user["password"]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailScreen(userId: user["id"]),
                  ),
                );
              },

            );
          },
        );
      },
    );

    Scaffold scaffold = Scaffold(appBar: appBar, body: futureBuilder);
    return scaffold;
  }
}
