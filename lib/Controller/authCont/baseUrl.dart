
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';


class Url{
  static String BASE_URL = "https://www.najarastays.com/api/";
  static String Image_URL = "https://www.najarastays.com/";
  static String Image_medium_URL = "https://www.najarastays.com/uploads/medium/";
  static String Image_medium_suffix = "_390.webp";
}

CommonToast({required context ,required title ,required bool alignCenter}){
  showToast(title,
    backgroundColor: const Color(0xff171D1D),
    textStyle: const TextStyle(color: Colors.white , fontWeight: FontWeight.w500 , fontSize: 12),
    context: context,
    alignment: alignCenter ? Alignment.center:Alignment.topCenter,
    animation: StyledToastAnimation.scale,
    reverseAnimation: StyledToastAnimation.fade,
    borderRadius:const BorderRadius.all(Radius.circular(8)),
    textPadding: const EdgeInsets.symmetric(horizontal: 8 , vertical: 7),
    position:alignCenter? StyledToastPosition.center : StyledToastPosition.top,
    animDuration:const Duration(seconds: 1),
    duration:const Duration(seconds: 4),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
  );
}


