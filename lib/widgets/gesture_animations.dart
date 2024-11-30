import 'package:flutter/material.dart';  

class SwipeableCard extends StatefulWidget {  
  final Widget child;  
  final VoidCallback? onSwipeLeft;  
  final VoidCallback? onSwipeRight;  
  final double threshold;  

  const SwipeableCard({  
    super.key,  
    required this.child,  
    this.onSwipeLeft,  
    this.onSwipeRight,  
    this.threshold = 0.3,  
  });  

  @override  
  State<SwipeableCard> createState() => _SwipeableCardState();  
}  

class _SwipeableCardState extends State<SwipeableCard> with SingleTickerProviderStateMixin {  
  late AnimationController _controller;  
  late Animation<Offset> _slideAnimation;  
  late Animation<double> _rotationAnimation;  
  Offset _dragStart = Offset.zero;  
  bool _isDragging = false;  

  @override  
  void initState() {  
    super.initState();  
    _controller = AnimationController(  
      duration: const Duration(milliseconds: 300),  
      vsync: this,  
    );  
    _slideAnimation = Tween<Offset>(  
      begin: Offset.zero,  
      end: Offset.zero,  
    ).animate(_controller);  
    _rotationAnimation = Tween<double>(  
      begin: 0.0,  
      end: 0.0,  
    ).animate(_controller);  
  }  

  @override  
  void dispose() {  
    _controller.dispose();  
    super.dispose();  
  }  

  void _onDragStart(DragStartDetails details) {  
    _isDragging = true;  
    _dragStart = details.localPosition;  
  }  

  void _onDragUpdate(DragUpdateDetails details) {  
    if (!_isDragging) return;  

    final dragDistance = details.localPosition - _dragStart;  
    final screenWidth = MediaQuery.of(context).size.width;  
    final dragPercentage = dragDistance.dx / screenWidth;  
    
    setState(() {  
      _slideAnimation = Tween<Offset>(  
        begin: Offset.zero,  
        end: Offset(dragPercentage, 0),  
      ).animate(_controller);  
      
      _rotationAnimation = Tween<double>(  
        begin: 0.0,  
        end: dragPercentage * 0.2,  
      ).animate(_controller);  
      
      _controller.value = 1.0;  
    });  
  }  

  void _onDragEnd(DragEndDetails details) {  
    _isDragging = false;  
    final currentSlide = _slideAnimation.value.dx;  
    
    if (currentSlide.abs() > widget.threshold) {  
      final direction = currentSlide > 0;  
      if (direction && widget.onSwipeRight != null) {  
        widget.onSwipeRight!();  
      } else if (!direction && widget.onSwipeLeft != null) {  
        widget.onSwipeLeft!();  
      }  
    }  
    
    setState(() {  
      _slideAnimation = Tween<Offset>(  
        begin: _slideAnimation.value,  
        end: Offset.zero,  
      ).animate(CurvedAnimation(  
        parent: _controller,  
        curve: Curves.easeOut,  
      ));  
      _rotationAnimation = Tween<double>(  
        begin: _rotationAnimation.value,  
        end: 0.0,  
      ).animate(CurvedAnimation(  
        parent: _controller,  
        curve: Curves.easeOut,  
      ));  
    });  
    
    _controller.reset();  
    _controller.forward();  
  }  

  @override  
  Widget build(BuildContext context) {  
    return GestureDetector(  
      onHorizontalDragStart: _onDragStart,  
      onHorizontalDragUpdate: _onDragUpdate,  
      onHorizontalDragEnd: _onDragEnd,  
      child: AnimatedBuilder(  
        animation: _controller,  
        builder: (context, child) {  
          return Transform.translate(  
            offset: _slideAnimation.value * MediaQuery.of(context).size.width,  
            child: Transform.rotate(  
              angle: _rotationAnimation.value,  
              child: child,  
            ),  
          );  
        },  
        child: widget.child,  
      ),  
    );  
  }  
}  

class ZoomableImage extends StatefulWidget {  
  final Widget child;  
  final double maxScale;  

  const ZoomableImage({  
    super.key,  
    required this.child,  
    this.maxScale = 3.0,  
  });  

  @override  
  State<ZoomableImage> createState() => _ZoomableImageState();  
}  

class _ZoomableImageState extends State<ZoomableImage> with SingleTickerProviderStateMixin {  
  late TransformationController _controller;  
  late AnimationController _animationController;  
  Animation<Matrix4>? _animation;  
  final double _minScale = 1.0;  

  @override  
  void initState() {  
    super.initState();  
    _controller = TransformationController();  
    _animationController = AnimationController(  
      vsync: this,  
      duration: const Duration(milliseconds: 200),  
    )..addListener(() {  
        if (_animation != null) {  
          _controller.value = _animation!.value;  
        }  
      });  
  }  

  @override  
  void dispose() {  
    _controller.dispose();  
    _animationController.dispose();  
    super.dispose();  
  }  

  void _onDoubleTap() {  
    if (_controller.value != Matrix4.identity()) {  
      _resetAnimation();  
    } else {  
      _zoomAnimation();  
    }  
  }  

  void _resetAnimation() {  
    _animation = Matrix4Tween(  
      begin: _controller.value,  
      end: Matrix4.identity(),  
    ).animate(CurvedAnimation(  
      parent: _animationController,  
      curve: Curves.easeOut,  
    ));  
    _animationController.forward(from: 0);  
  }  

  void _zoomAnimation() {  
    _animation = Matrix4Tween(  
      begin: _controller.value,  
      end: Matrix4.diagonal3Values(2.0, 2.0, 1.0),  
    ).animate(CurvedAnimation(  
      parent: _animationController,  
      curve: Curves.easeOut,  
    ));  
    _animationController.forward(from: 0);  
  }  

  @override  
  Widget build(BuildContext context) {  
    return GestureDetector(  
      onDoubleTap: _onDoubleTap,  
      child: InteractiveViewer(  
        transformationController: _controller,  
        minScale: _minScale,  
        maxScale: widget.maxScale,  
        child: widget.child,  
      ),  
    );  
  }  
}