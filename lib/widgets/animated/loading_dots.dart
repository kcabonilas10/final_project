import 'package:flutter/material.dart';  
import '../../config/animations.dart';  

class LoadingDots extends StatefulWidget {  
  final Color? color;  
  final double size;  

  const LoadingDots({  
    super.key,  
    this.color,  
    this.size = 10.0,  
  });  

  @override  
  State<LoadingDots> createState() => _LoadingDotsState();  
}  

class _LoadingDotsState extends State<LoadingDots>  
    with TickerProviderStateMixin {  
  late List<AnimationController> _controllers;  
  late List<Animation<double>> _animations;  

  @override  
  void initState() {  
    super.initState();  
    _controllers = List.generate(  
      3,  
      (index) => AnimationController(  
        vsync: this,  
        duration: AppAnimations.normal,  
      ),  
    );  

    _animations = _controllers.map((controller) {  
      return Tween<double>(begin: 0.0, end: 1.0).animate(  
        CurvedAnimation(  
          parent: controller,  
          curve: Curves.easeInOut,  
        ),  
      );  
    }).toList();  

    for (var i = 0; i < _controllers.length; i++) {  
      Future.delayed(Duration(milliseconds: i * 100), () {  
        _controllers[i].repeat(reverse: true);  
      });  
    }  
  }  

  @override  
  void dispose() {  
    for (var controller in _controllers) {  
      controller.dispose();  
    }  
    super.dispose();  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Row(  
      mainAxisSize: MainAxisSize.min,  
      children: List.generate(  
        3,  
        (index) => Padding(  
          padding: const EdgeInsets.symmetric(horizontal: 2),  
          child: AnimatedBuilder(  
            animation: _animations[index],  
            builder: (context, child) {  
              return Transform.translate(  
                offset: Offset(0, -_animations[index].value * 8),  
                child: Container(  
                  width: widget.size,  
                  height: widget.size,  
                  decoration: BoxDecoration(  
                    color: widget.color ?? Theme.of(context).colorScheme.primary,  
                    shape: BoxShape.circle,  
                  ),  
                ),  
              );  
            },  
          ),  
        ),  
      ),  
    );  
  }  
}