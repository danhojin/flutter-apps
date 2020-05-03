import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider1/pages/home_page.dart';
import 'package:provider1/providers.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Words(),
        ),
        ChangeNotifierProvider(
          create: (_) => Favorites(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
