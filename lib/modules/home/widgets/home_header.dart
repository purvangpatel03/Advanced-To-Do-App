import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../themes_and_styles/text_style/text_style_roboto.dart';

class HeaderHomePage extends StatelessWidget {
  int currentDate;
  HeaderHomePage({super.key, required this.currentDate});

  int todayDate = int.parse(DateFormat('d').format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        getHeaderTitle(),
        Spacer(),
        IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
      ],
    );
  }

  Widget getHeaderTitle(){
    if(currentDate == todayDate){
      return Text('Today', style: roboto28(fontWeight: FontWeight.w600).copyWith(letterSpacing: 1.2),);
    }
    else if ( currentDate == todayDate-1){
      return Text('Yesterday', style: roboto28(fontWeight: FontWeight.w600).copyWith(letterSpacing: 1.2),);
    }
    else{
      return Text('Date: $currentDate', style: roboto28(fontWeight: FontWeight.w600).copyWith(letterSpacing: 1.2),);
    }
  }
}
