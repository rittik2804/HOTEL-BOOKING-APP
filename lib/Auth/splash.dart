import 'dart:async';
import 'package:flutter/material.dart';
import 'package:najara_stays/Auth/login.dart';
import 'package:najara_stays/Auth/splash2.dart';
import 'package:najara_stays/screens/PhonePePayment.dart';
import 'package:najara_stays/screens/bottomscreen.dart';
import '../common/sharepre.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
  Timer(const Duration(seconds: 2), () =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const Splash2()))
        );
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF97BCFF),
      body: Center(child: Padding(
        padding: const EdgeInsets.only(left:16.0),
        child: Image.asset("assests/logoSplash.png", width: 350, fit: BoxFit.fill,),
      )),
    );
  }
}