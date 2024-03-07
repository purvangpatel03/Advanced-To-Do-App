import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../themes_and_styles/text_style/text_style_roboto.dart';

class EmptyHomePage extends StatelessWidget {
  const EmptyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
              'assets/home/home_empty_lottie/home_lottie.json'),
          getText(),
        ],
      ),
    );
  }

  Widget getText(){
    final now = DateTime.now();
    final hour = now.hour;
    if(hour >= 0 && hour < 7 ){
      return RichText(
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.center,
        text: TextSpan(
          style: roboto20(
            fontWeight: FontWeight.w500,
          ).copyWith(
            letterSpacing: 1,
          ),
          children: [
            const TextSpan(
                text:'Good Night,\n',
                style: TextStyle(height: 2)
            ),
            TextSpan(
              text: '✨ Tonight, dream big. Tomorrow, make it happen.',
            style: roboto16(textColor: const Color.fromRGBO(185, 185, 185, 1.0)),
            ),
          ],
        ),
      );
    }
    else if(hour >=12 && hour < 18){
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
            const TextSpan(
                text:'Good Afternoon,\n',
              style: TextStyle(height: 2)
            ),
            TextSpan(
              text: 'Remember, small actions lead to big results.\nWhat small win can you achieve today?',
            style: roboto16(textColor: const Color.fromRGBO(185, 185, 185, 1.0)),
            ),
          ],
        ),
      );
    }
    else if(hour >=18 && hour <= 23){
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
            const TextSpan(
                text:'Good Evening,\n',
                style: TextStyle(height: 2)
            ),
            TextSpan(
              text: "Let's sprinkle some magic on your day!\nWhat sparks joy right now?",
            style: roboto16(textColor: const Color.fromRGBO(185, 185, 185, 1.0)).copyWith(height: 2),
            ),
          ],
        ),
      );
    }
    else {
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
            const TextSpan(
                text:'Good Morning,\n',
                style: TextStyle(height: 2)
            ),
            TextSpan(
              text: 'Invest in yourself!\nWhat will nourish your growth today?',
            style: roboto16(textColor: const Color.fromRGBO(185, 185, 185, 1.0)),
            ),
          ],
        ),
      );
    }
  }
}
