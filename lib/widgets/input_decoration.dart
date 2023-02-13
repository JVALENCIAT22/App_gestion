import 'package:flutter/material.dart';

class InputDecorations{
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  })
  {
  return InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              ),

              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
              width: 2,
              )
              
              ),
              hintText: hintText,
              labelStyle: TextStyle(color: Colors.grey,
              ),
              prefixIcon: prefixIcon != null ? Icon(
                prefixIcon,
                color: Colors.amber
              ):null ,
              );
}
}