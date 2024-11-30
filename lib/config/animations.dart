import 'package:flutter/material.dart';  

class AppAnimations {  
  // Durations  
  static const Duration fast = Duration(milliseconds: 200);  
  static const Duration normal = Duration(milliseconds: 300);  
  static const Duration slow = Duration(milliseconds: 500);  

  // Curves  
  static const Curve defaultCurve = Curves.easeInOutCubic;  
  static const Curve bounceCurve = Curves.elasticOut;  
  
  // Page Transitions  
  static Widget slideTransition(  
    BuildContext context,  
    Animation<double> animation,  
    Animation<double> secondaryAnimation,  
    Widget child,  
  ) {  
    const begin = Offset(1.0, 0.0);  
    const end = Offset.zero;  
    const curve = Curves.easeInOutCubic;  

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));  
    var offsetAnimation = animation.drive(tween);  

    return SlideTransition(  
      position: offsetAnimation,  
      child: child,  
    );  
  }  
}