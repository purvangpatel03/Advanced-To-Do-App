import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../themes_and_styles/text_style/text_style_roboto.dart';

class EmptyInboxPage extends StatelessWidget {
  const EmptyInboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
            height: 300,
            repeat: false,
            'assets/inbox/inbox_empty_lottie/inbox_lottie.json'),
        getText(),
      ],
    );
  }

  Widget getText() {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      textAlign: TextAlign.center,
      text: TextSpan(
        style: roboto20(
          fontWeight: FontWeight.w500,
        ).copyWith(
          letterSpacing: 1,
        ),
        children: [
          const TextSpan(text: 'Empty inbox,\n', style: TextStyle(height: 2)),
          TextSpan(
            text:
                'limitless potential. Create a new list and unleash your productivity superpower!',
            style:
                roboto16(textColor: const Color.fromRGBO(185, 185, 185, 1.0)),
          ),
        ],
      ),
    );
  }
}
