import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CounterCard extends StatelessWidget {
  const CounterCard({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              count.toString(),
              style: GoogleFonts.poppins(
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
