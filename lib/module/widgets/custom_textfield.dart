import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final bool? enable;
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const CustomTextField({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.enable=true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        enabled: widget.enable ?? true,
        hintText: widget.hintText ?? "",
        hintStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:  BorderSide(
            color: Colors.blue.shade900,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(15.0),
      ),
      onChanged: widget.onChanged,
    );
  }
}