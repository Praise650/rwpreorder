import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final int lines;
  final TextInputType inputType;
  final TextEditingController controller;
  final Function(String) validator;
  final bool obscureText;

  const InputField({
    Key key,
    this.label,
    this.lines = 1,
    this.inputType,
    this.validator,
    this.obscureText = false,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator == null
            ? (val) {
                if (val.isEmpty)
                  return "This field cannot be empty!";
                else
                  return null;
              }
            : validator,
        controller: controller,
        obscureText: obscureText,
        minLines: lines,
        maxLines: lines,
        keyboardType: inputType,
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          labelText: "$label",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
