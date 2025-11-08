import 'package:flutter/material.dart';
import 'user_form_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  MaterialApp materialApp = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserFormScreen(),
  );

  runApp(materialApp);
}