import 'package:flutter/material.dart';
import 'package:galaxy_planet/view/screens/detailpage.dart';
import 'package:galaxy_planet/view/screens/fevritspage.dart';
import 'package:galaxy_planet/view/screens/homepage.dart';
import 'package:galaxy_planet/view/screens/spalshscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      'Homepage': (context) => Homepage(),
      'Detailpage' : (context) => Detailpage(),
      '/' : (context) => SplashScreen(),
      'Like' : (context) => Like(),

    },
  ));
}