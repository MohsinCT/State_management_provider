import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import hive_flutter package
import 'package:provider/provider.dart';
import 'package:student_management_provider/controller/student_provider.dart';
import 'package:student_management_provider/model/student_model.dart';
import 'package:student_management_provider/screens/student_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widgets are initialized before Hive
  await Hive.initFlutter(); // Use Hive.initFlutter() from hive_flutter
  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox<Student>('Student');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue[800],
          scaffoldBackgroundColor: Colors.blue[50],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue[800],
            foregroundColor: Colors.white,
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue[800],
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: StudentList(),
      ),
    );
  }
}
