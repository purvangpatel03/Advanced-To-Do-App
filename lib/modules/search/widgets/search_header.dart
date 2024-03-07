import 'package:flutter/material.dart';
import '../../../themes_and_styles/text_style/text_style_roboto.dart';

class HeaderSearchPage extends StatelessWidget {
  const HeaderSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Search', style: roboto28(fontWeight: FontWeight.w500).copyWith(letterSpacing: 1.2),),
        Spacer(),
        IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
      ],
    );
  }
}
