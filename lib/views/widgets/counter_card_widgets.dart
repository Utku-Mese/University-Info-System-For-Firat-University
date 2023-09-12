import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_uni/views/widgets/animated_counter_widget.dart';

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
            AnimatedCounter(
              key: const Key("key"),
              digit: count,
              textStyle: GoogleFonts.poppins(
                fontSize: 25,
              ),
            )
            //? This is the old code, no animation
            /* Text(
              count.toString(),
              style: GoogleFonts.poppins(
                fontSize: 25,
              ),
            ), */
          ],
        ),
      ),
    );
  }
}
