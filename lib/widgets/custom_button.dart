import 'package:flutter/material.dart';  

class CustomButton extends StatelessWidget {  
  final String text;  
  final VoidCallback onPressed;  
  final bool isLoading;  
  final Color? backgroundColor;  
  final Color? textColor;  
  final double? width;  
  final double height;  
  final double borderRadius;  
  final EdgeInsetsGeometry? padding;  

  const CustomButton({  
    super.key,  
    required this.text,  
    required this.onPressed,  
    this.isLoading = false,  
    this.backgroundColor,  
    this.textColor,  
    this.width,  
    this.height = 50,  
    this.borderRadius = 12,  
    this.padding,  
  });  

  @override  
  Widget build(BuildContext context) {  
    return SizedBox(  
      width: width,  
      height: height,  
      child: ElevatedButton(  
        onPressed: isLoading ? null : onPressed,  
        style: ElevatedButton.styleFrom(  
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,  
          foregroundColor: textColor ?? Colors.white,  
          padding: padding,  
          shape: RoundedRectangleBorder(  
            borderRadius: BorderRadius.circular(borderRadius),  
          ),  
          elevation: 2,  
        ),  
        child: isLoading  
            ? const SizedBox(  
                height: 20,  
                width: 20,  
                child: CircularProgressIndicator(  
                  strokeWidth: 2,  
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),  
                ),  
              )  
            : Text(  
                text,  
                style: const TextStyle(  
                  fontSize: 16,  
                  fontWeight: FontWeight.bold,  
                ),  
              ),  
      ),  
    );  
  }  
}