import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayara_tech_app/app/service/ui_services.dart';

class MyBookingPage extends StatelessWidget {
  const MyBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = UIServices.getSize(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.035),
          child: Container(),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25.0),
          ),
        ),
        centerTitle: true,
        title: Text(
          "My Booking",
          style: GoogleFonts.ubuntu(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "This Screen Is Not Required",
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
