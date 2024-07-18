import 'package:flutter/material.dart';
import 'package:testapi/dropdown.dart';

void main() {
  runApp(const MyApp());
}


double height = 0.0;
double width = 0.0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  DropDownScreen(),
    );
  }
}

