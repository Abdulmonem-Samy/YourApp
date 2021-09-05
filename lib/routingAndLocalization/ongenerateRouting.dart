import 'package:flutter/material.dart';
import 'package:your/appScreens/create_screen.dart';
import '../appScreens/login_screen.dart';
import '../appScreens/loading_screen.dart';
import 'package:your/appScreens/main_page.dart';


MaterialPageRoute routeFunction(RouteSettings settings){
  switch(settings.name){
    case '/':
      return MaterialPageRoute(builder: (BuildContext context)=>LoadingScreen());

    case '/login':
      return MaterialPageRoute(builder: (BuildContext context)=>LoginScreen());

    case '/main':
      return MaterialPageRoute(builder: (BuildContext context)=>MainPage(page: 0,));

    case '/create':
       return MaterialPageRoute(builder: (BuildContext context)=>CreateScreen());

    default:
      return MaterialPageRoute(builder: (BuildContext context)=>LoadingScreen());
}
}