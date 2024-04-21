import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:najara_stays/Auth/resetpassword.dart';
import 'package:najara_stays/Auth/signup.dart';
import 'package:najara_stays/Controller/authCont/otpApi.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../Controller/authCont/baseUrl.dart';
import '../Controller/authCont/forgetpassApi.dart';
import '../common/textstyle.dart';
import 'forgetpassword.dart';




class Otp extends StatefulWidget {
  String otp;
  String type;
  String email;
  String id;
   Otp({required this.otp,required this.type,required this.id,required this.email});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {

  final _forgetCont = Get.put(ForgetCont());
  @override
  void initState() {
    print("---------otp_______${widget.otp}");
    print("---------otp_______${widget.type}");
    print("---------otp_____id-------${widget.id}");
    super.initState();
  }

  TextEditingController email =TextEditingController();
  final _otpCont = Get.put(OtpCont());
  var _pin;
  OtpFieldController otp=OtpFieldController();
  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: ()async{
        DateTime lastTimeBackbuttonWasClicked = DateTime.now();
        if (DateTime.now().difference(lastTimeBackbuttonWasClicked) >= Duration(seconds: 2)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Press the back button again to go back"),
              duration: Duration(seconds: 2),
            ),
          );
          _otpCont.isLoading.value = false;
          lastTimeBackbuttonWasClicked = DateTime.now();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFEBCB3A),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFCDE67),Color(0xFFEBCB3A)],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child:Image.asset('assests/najara1.png', scale: 4,
                  ),
                ),
                Container(
                  width: width,
                  padding: EdgeInsets.only(top: 20),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          height: 308,
                          width: 283,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          height: 308,
                          width: 295,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 42),
                        child: Container(
                          width: 315,
                          padding: EdgeInsets.only(bottom: 50
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0,bottom: 35),
                                child: Text('Verification',style:TextStyles.font25Blue),
                              ),

                              Text('Enter Code Here',style: TextStyles.hint_text,),

                              SizedBox(height: 15,),
                              OTPTextField(
                                controller: otp,

                                length: 4,
                                width: MediaQuery.of(context).size.width*0.8,
                                fieldWidth:45,
                                style: TextStyle(
                                    fontSize: 17
                                ),
                                textFieldAlignment: MainAxisAlignment.spaceEvenly,
                                fieldStyle: FieldStyle.underline,
                                onChanged: (pin){
                                  setState(() {
                                    _pin=pin;
                                    print("Completed: " + _pin);
                                  });

                                },
                                onCompleted: (pin) {
                                  // setState((){
                                  //   _pin=pin.toString();
                                  //   print("Completed: " + _pin);
                                  // });

                                },
                              ),
                              SizedBox(height: 15,),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('If you didn’t receive the code ? ',style:TextStyles.font14B,),
                                    _forgetCont.isLoading.value == true?Center(child: CircularProgressIndicator()):  InkWell(
                                        onTap: (){
                                          setState(() {
                                          _forgetCont.isLoading.value=true;
                                          _forgetCont.forgetApi(email: widget.email, context: context).then((value){
                                            setState(() {
                                              _forgetCont.isLoading.value=false;
                                            });
                                          }); });
                                        },
                                        child: Text('Resend',style:TextStyles.font14Blue,textScaleFactor: 1,)),
                                  ],
                                ),

                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20,right:20,top:50),
                                child: _otpCont.isLoading.value == true?Center(child: CircularProgressIndicator()):
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      if(_pin==null) {
                                        CommonToast(context: context, title: 'Enter otp', alignCenter: true);
                                      }else{

                                        // _otpCont.isLoading.value = true;
                                        widget.type=='1'?
                                        _otpCont.otpApi(otp: _pin.toString(), context: context, id: widget.id):
                                        widget.otp==_pin.toString()?Get.to(Reset(id: widget.id,)):
                                        CommonToast(context: context, title: 'Enter valide otp', alignCenter: true);
                                      }
                                    });

                                  },
                                  child: Container(
                                    height: 50,
                                    padding: EdgeInsets.only(right:6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0xFF004AAD)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(width: 50,),
                                        Container(
                                          child: Text('Verify',style:TextStyles.font25W),
                                        ),
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.blue.shade700,
                                          child: Icon(Icons.arrow_forward_outlined,color: Colors.white,),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }
}



