import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BasicText extends StatelessWidget {
  String? title;
  Color? color;
  double? fontSize;
  BasicText({super.key, this.color, this.title, this.fontSize});
  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: GoogleFonts.robotoSerif(
          color: color,
          letterSpacing: 0.5,
          fontSize: fontSize,
          fontWeight: FontWeight.w400),
    );
  }
}

class Textfield extends StatelessWidget {
  TextEditingController? controller;
  String? text;
  TextInputType? keyboardType;
  int? maxlines;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  Textfield(
      {super.key,
      this.text,
      this.controller,
      this.keyboardType,
      this.maxlines,
      this.validator,
      this.onChanged});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        maxLines: maxlines,
        validator: validator,
        decoration: InputDecoration(
            hintText: text,
            hintStyle: const TextStyle(fontSize: 13.9),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 22.0, horizontal: 15.0),
            fillColor: Colors.pink,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.3),
              borderRadius: BorderRadius.circular(15.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(15.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.9),
              borderRadius: BorderRadius.circular(12.0),
            ),
            border: const OutlineInputBorder()));
  }
}

class BackGroundImage extends StatelessWidget {
  Widget? child;
  BackGroundImage({super.key, this.child});
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/Images/apartment.png', // Replace with your image URL
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Container(
          color: Colors.black.withOpacity(0.2),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.05,
                child: Card(
                  elevation: 12.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
