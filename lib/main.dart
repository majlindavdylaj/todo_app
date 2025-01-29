import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lindi/lindi.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/lindi/todo_viewmodel.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/services/firestore_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  LindiInjector.register(TodoViewModel(FirestoreService()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
