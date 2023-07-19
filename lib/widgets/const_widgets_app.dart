// ignore_for_file: non_constant_identifier_names

import 'package:contacts/model/contact_model.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget? DefoultAppBar(
        {required String title, PreferredSizeWidget? bottom , List<Widget>? action}) =>
    AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      actions: action,
      elevation: 0,
      bottom: bottom,
    );

Widget TextFormFieldApp({
  required String hint,
  required IconData prefixIcon,
  IconData? suffixIcon,
  required TextInputType type,
  required bool toggleText,
  void Function()? onPressSuffixIcon,
  void Function()? onTop,
  TextEditingController? controller,
  String? Function(String?)? validator,
  String? errorText,
  double? borderRadius = 20,
  Color? prefixIconColor = Colors.black,
}) =>
    TextFormField(
      decoration: InputDecoration(
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
        hintText: hint,
        contentPadding: EdgeInsets.zero,
        hintStyle: const TextStyle(
          fontFamily: 'poppins',
        ),
        prefixIcon: Icon(prefixIcon),
        prefixIconColor: prefixIconColor ?? Colors.black,
        suffixIcon: IconButton(
          icon: Icon(
            suffixIcon,
            color: Colors.black,
          ),
          onPressed: onPressSuffixIcon,
        ),
      ),
      style: const TextStyle(fontFamily: 'poppins', color: Colors.black),
      cursorColor: Colors.black,
      keyboardType: type,
      obscureText: toggleText,
      onTap: onTop,
      controller: controller,
      validator: validator,
    );



