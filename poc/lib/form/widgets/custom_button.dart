// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final bool isDisabled;
  final double height;
  final double width;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.isDisabled = false,
    this.height = 48,
    this.width = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: isDisabled ? Colors.grey : Colors.orange,
        ),
        height: height,
        width: width,
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  color: isDisabled ? Colors.black87 : Colors.white,
                )
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDisabled ? Colors.black87 : Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
