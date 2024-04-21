import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:najara_stays/Auth/login.dart';
import 'package:najara_stays/Auth/otp.dart';
import 'package:najara_stays/Auth/signup.dart';
import 'package:najara_stays/Controller/authCont/resetpassApi.dart';

import '../Controller/authCont/baseUrl.dart';
import '../common/textstyle.dart';




class Reset extends StatefulWidget {
  String id;
   Reset({Key? key,required this.id}) : super(key: key);

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  TextEditingController confirm =TextEditingController();
  TextEditingController password =TextEditingController();
  final _resetCont = Get.put(ResetCont());
  final _formkey = GlobalKey<FormState>();
  bool visibile=true;
  bool confvisibile=true;
  bool select=false;

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
          _resetCont.isLoading.value = false;
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
            child: Form(
              key: _formkey,
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
                            padding: EdgeInsets.only(bottom: 40
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(22.0),
                              child: Column(
                                children: [
                                  Text('Reset Your Password',style:TextStyles.font25Blue),
                                  SizedBox(height: 40,),
                                  Container(
                                    height: 40,
                                    child: TextFormField(
                                        controller: password,
                                        validator: (value) {
                                          String pattern =
                                              r'(?=.*?[#?!@$%^&*-])';
                                          RegExp regExp = RegExp(pattern);
                                          if (value!.isEmpty) {
                                            return "Please enter your valid password";
                                          } else if (!(regExp.hasMatch(value))) {
                                            return "passwords must have at least one special character";
                                          } else {
                                            return null;
                                          }},
                                            obscureText: visibile,
                                            decoration:InputDecoration(
                                                suffixIcon: InkWell(
                                                    onTap: (){
                                                      setState((){
                                                        visibile=!visibile;
                                                      });
                                                    },
                                                    child: Icon(visibile==false?Icons.visibility_outlined:Icons.visibility_off_outlined,size: 18,)),
                                            hintText: 'New Password',
                                            hintStyle: TextStyles.hint_text,
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(width: 1.5,color: Colors.black.withOpacity(0.2))
                                            )
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 40,),
                                  Container(
                                    height: 40,
                                    child: TextFormField(
                                        controller: confirm,
                                        validator: (value) {
                                          String pattern =
                                              r'(?=.*?[#?!@$%^&*-])';
                                          RegExp regExp = RegExp(pattern);
                                          if (value!.isEmpty) {
                                            return "Please enter your valid password";
                                          } else if (!(regExp.hasMatch(value))) {
                                            return "passwords must have at least one special character";
                                          } else {
                                            return null;
                                          }},
                                        obscureText: confvisibile,
                                        decoration:InputDecoration(
                                            suffixIcon: InkWell(
                                                onTap: (){
                                                  setState((){
                                                    confvisibile=!confvisibile;
                                                  });
                                                },
                                                child: Icon(confvisibile==false?Icons.visibility_outlined:Icons.visibility_off_outlined,size: 18,)),
                                            hintText: 'Verify Password',
                                            hintStyle: TextStyles.hint_text,
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(width: 1.5,color: Colors.black.withOpacity(0.2))
                                            )
                                        )
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top:70),
                                    child:  _resetCont.isLoading.value == true?Center(child: CircularProgressIndicator()):
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          if(_formkey.currentState!.validate()){
                                            if(password.text.toString()==confirm.text.toString()){
                                            _resetCont.isLoading.value = true;
                                            _resetCont.resetApi(
                                                context: context,  password: password.text.toString(), id: widget.id).then((value) {
                                                  setState(() {
                                                    _resetCont.isLoading.value = false;
                                                  });
                                            });
                                          }else{
                                              CommonToast(context: context, title: 'Password not match', alignCenter: false);
                                              setState(() {
                                                _resetCont.isLoading.value = false;
                                              });
                                            }
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
                                              child: Text('Reset',style:TextStyles.font25W),
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
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}



class Congrate extends StatelessWidget {
  const Congrate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFEBCB3A),
      body: SingleChildScrollView(
        child: Container(
          width: width,
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
                        padding: EdgeInsets.only(bottom: 40
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 35.0,bottom: 15),
                              child: Container(
                                width: 90,
                                  height: 90,
                                  padding:  EdgeInsets.only(bottom: 4440),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage('assests/circle.png'),scale: 4,)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0,bottom: 20),
                                    child: Icon(Icons.check,color: Color(0xFF0188E2),size: 90,),
                                  ))
                            ),
                          Text('Congratulation',style: TextStyles.font25Blue,),
                            SizedBox(height: 10,),
                            Container(
                                width: 240,
                                child: Text('You have successfully update you password now you can login',
                                  style: TextStyles.hint_text,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,)),
                            Padding(
                              padding: EdgeInsets.only(top:50,left: 20,right: 20),
                              child: InkWell(
                                onTap: (){
                                  Get.to(Login());
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
                                        child: Text('Login',style:TextStyles.font25W),
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
    );
  }
}
