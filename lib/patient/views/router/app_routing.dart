import 'package:aarogyam/main.dart';
import 'package:flutter/material.dart';
class AppRouting{
  
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=> const MyApp());
      default:
        return null;
    }
  }
}
