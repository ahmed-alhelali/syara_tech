import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SnackBarWidgets {
  static Icon errorIconSnackBar() {
    return const Icon(
      Icons.error,
      color: Colors.red,
      size: 22,
    );
  }


  static Icon successIconSnackBar() {
    return const Icon(
      Icons.check_circle,
      color: Color(0xff02CDBA),
      size: 22,
    );
  }

  static Text successTextSnackBar({required String content}) {
    return Text(
      content,
      textScaleFactor: 1.0,
      style: GoogleFonts.ubuntu(
        fontSize: 12,
        color: const Color(0xff02CDBA),
      ),
    );
  }
  static Text errorTextSnackBar({required String content}) {
    return Text(
      content,
      textScaleFactor: 1.0,
      style: GoogleFonts.ubuntu(
        fontSize: 12,
        color: Colors.red,
      ),
    );
  }
}
