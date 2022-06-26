import 'package:flutter/material.dart';

class DefaultTextField extends StatefulWidget {
  const DefaultTextField(
      {Key? key,
      this.isClickable = true,
      this.onTap,
      required this.label,
      required this.type,
      required this.controller,
      required this.prefix,
      required this.validate})
      : super(key: key);

  final String label;
  final TextInputType type;
  final TextEditingController controller;
  final Widget? prefix;
  final bool isClickable;
  final String? Function(String?)? validate;
  final Function()? onTap;

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        enabled:  widget.isClickable,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          gapPadding: 4.0,
        ),
        labelText: widget.label,
        prefixIcon: widget.prefix,
      ),
      onTap: widget.onTap,
      keyboardType: widget.type,
      validator: widget.validate,
    );
  }
}
