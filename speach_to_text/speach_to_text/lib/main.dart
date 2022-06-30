import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speach_to_text/page/home_page.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,


    home: HomePage(),
  );
}