import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Nothing here",
          style: GoogleFonts.ubuntu(
            fontSize: 16,
            color: Colors.black,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
