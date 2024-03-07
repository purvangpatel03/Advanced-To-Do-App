import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        repeat: false,
          'assets/report/report_empty_lottie/report_lottie.json'),
    );
  }
}
