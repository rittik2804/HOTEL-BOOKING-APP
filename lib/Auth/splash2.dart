import 'dart:async';

import 'package:flutter/material.dart';
import 'package:najara_stays/Auth/login.dart';
import 'package:najara_stays/common/sharepre.dart';
import 'package:najara_stays/common/textstyle.dart';
import 'package:najara_stays/screens/bottomscreen.dart';
import 'package:video_player/video_player.dart';

class Splash2 extends StatefulWidget {
  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {

  late VideoPlayerController controller;
  
    @override
  void initState() {
   
   loadVideoPlayer();
    getValidation();
    super.initState();
  }
  

    @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }




  getValidation() async {
    final getUserId = GetUserDetail();
    var userId = await getUserId.getUserData('id');
    setState(() {
      if (userId == null.toString()) {
        Timer(const Duration(seconds: 3), () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const Login()))
        );
      } else {
        Timer(const Duration(seconds: 3), () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const Bottom())));
      }
    });
  }


    loadVideoPlayer(){
     controller = VideoPlayerController.asset('assests/BetterPrices.mp4');
     controller.addListener(() {
        setState(() {});
     });
    controller.initialize().then((value){
        setState(() {
          controller.play();
          controller.setLooping(true);
         
        });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8eb3ff),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
          child: AspectRatio(
            aspectRatio:0.5,
            
            child: VideoPlayer(controller),
            
            ),
         // child: VideoPlayer(controller,),

        ),
      ),
    );
  }
}