import 'package:flutter/material.dart';  
import '../../config/animations.dart';  

class AnimatedScaleButton extends StatefulWidget {  
  final Widget child;  
  final VoidCallback onPressed;  
  final double scale;  
  final Duration duration;  

  const AnimatedScaleButton({  
    super.key,  
    required this.child,  
    required this.onPressed,  
    this.scale = 0.95,  
    this.duration = AppAnimations.fast,  
  });  

  @override  
  State<AnimatedScaleButton> createState() => _AnimatedScaleButtonState();  
}  

class _AnimatedScaleButtonState extends State<AnimatedScaleButton>  
    with SingleTickerProviderStateMixin {  
  late AnimationController _controller;  
  late Animation<double> _scaleAnimation;  

  @override  
  void initState() {  
    super.initState();  
    _controller = AnimationController(  
      vsync: this,  
      duration: widget.duration,  
    );  

    _scaleAnimation = Tween<double>(  
      begin: 1.0,  
      end: widget.scale,  
    ).animate(  
      CurvedAnimation(  
        parent: _controller,  
        curve: Curves.easeInOut,  
      ),  
    );  
  }  

  @override  
  void dispose() {  
    _controller.dispose();  
    super.dispose();  
  }  

  @override  
  Widget build(BuildContext context) {  
    return GestureDetector(  
      onTapDown: (_) => _controller.forward(),  
      onTapUp: (_) {  
        _controller.reverse();  
        widget.onPressed();  
      },  
      onTapCancel: () => _controller.reverse(),  
      child: AnimatedBuilder(  
        animation: _scaleAnimation,  
        builder: (context, child) => Transform.scale(  
          scale: _scaleAnimation.value,  
          child: child,  
        ),  
        child: widget.child,  
      ),  
    );  
  }  
}