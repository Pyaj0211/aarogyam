import 'package:aarogyam/doctor/views/screens/login_screen.dart';
import 'package:flutter/material.dart';
class AppRouting{
  
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=> LoginScreen());
      default:
        return null;
    }
  }
}
