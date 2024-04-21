

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:najara_stays/Auth/signup.dart';

import '../Controller/authCont/forgetpassApi.dart';
import '../common/textstyle.dart';
class Forget extends StatefulWidget {
  const Forget({Key? key}) : super(key: key);

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {




  TextEditingController email =TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool select=false;
  final _forgetCont = Get.put(ForgetCont());
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
          _forgetCont.isLoading.value = false;
          lastTimeBackbuttonWasClicked = DateTime.now();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
         backgroundColor: Color(0xFF97bcff),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            // decoration: const BoxDecoration(
            //   gradient: LinearGradient(
            //   //   begin: Alignment.topCenter,
            //   //   end: Alignment.bottomCenter,
            //   //   colors: [Color(0xFFFCDE67),Color(0xFFEBCB3A)],
            //   // ),
            // ),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child:Image.asset('assests/logoLogin.png', scale: 2,
                    ),
                  ),
                  Container(
                    width: width,
                    padding: EdgeInsets.only(top: 0),
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
                            padding: EdgeInsets.only(bottom: 40
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 35.0),
                                    child: Text('Forgot Password ?',style:TextStyles.font25Blue),
                                  ),
                                  Container(
                                    height: 40,
                                    child: TextFormField(
                                        controller: email,
                                        validator: (mailvalid) {
                                          String pattern =
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                          RegExp regExp = RegExp(pattern);
                                          if (mailvalid!.isEmpty) {
                                            return "Please enter your valid email address";
                                          } else if (!(regExp.hasMatch(mailvalid))) {
                                            return "Email must be end from @gmail.com";
                                          } else {
                                            return null;
                                          }
                                        },
                                        keyboardType: TextInputType.emailAddress,
                                        decoration:InputDecoration(
                                            hintText: 'Enter Email Address',
                                            hintStyle: TextStyles.hint_text,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(width: 1.5,color: Colors.black.withOpacity(0.2))),
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Don’t have an account? ',style:TextStyles.font14B),
                                        InkWell(
                                            onTap: (){
                                              Get.to(SignUp());
                                            },
                                            child: Text('Register Now',style:TextStyles.font14Blue,)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top:70),
                                    child: _forgetCont.isLoading.value == true?Center(child: CircularProgressIndicator()): InkWell(
                                      onTap: (){
                                        setState(() {
                                        if(_formkey.currentState!.validate()){

                                          _forgetCont.isLoading.value=true;
                                          _forgetCont.forgetApi(email: email.text.toString(), context: context).then((value){
                                            setState(() {
                                              _forgetCont.isLoading.value=false;
                                            });
                                          });
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
                                              child: Text('Forgot',style:TextStyles.font25W),
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child:    Column(
                      children: [
                        Text('Having Trouble ? Get Help',style:TextStyles.font16B),
                        Text('Email at info@najarastays.com',style:TextStyles.font16B),
                      ],
                    ),
                  ),
                  SizedBox(height: 1,),
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}




