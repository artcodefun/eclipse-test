import 'package:flutter/cupertino.dart';

import '../pages/HomePage.dart';


/// Stores app navigation paths
class NavigationInfo{
  static const home = "home";



  static makeRoutes()=>{
    home : (BuildContext c)=>const HomePage(),
  };

}