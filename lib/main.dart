import 'package:flutter/material.dart';
import 'package:newstrack/controller/home_provider.dart';
import 'package:newstrack/controller/category_provider.dart';
import 'package:newstrack/view/home_screen/home.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeControl(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    );
  }
}
