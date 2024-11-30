import 'package:flutter/material.dart';  
import '../config/animations.dart';  

class FadePageRoute<T> extends PageRoute<T> {  
  final Widget child;  

  FadePageRoute({required this.child});  

  @override  
  Color? get barrierColor => null;  

  @override  
  String? get barrierLabel => null;  

  @override  
  bool get maintainState => true;  

  @override  
  Duration get transitionDuration => AppAnimations.normal;  

  @override  
  Widget buildPage(context, animation, secondaryAnimation) {  
    return FadeTransition(  
      opacity: animation,  
      child: child,  
    );  
  }  
}  

class SlidePageRoute<T> extends PageRoute<T> {  
  final Widget child;  

  SlidePageRoute({required this.child});  

  @override  
  Color? get barrierColor => null;  

  @override  
  String? get barrierLabel => null;  

  @override  
  bool get maintainState => true;  

  @override  
  Duration get transitionDuration => AppAnimations.normal;  

  @override  
  Widget buildPage(context, animation, secondaryAnimation) {  
    return AppAnimations.slideTransition(  
      context,  
      animation,  
      secondaryAnimation,  
      child,  
    );  
  }  
}