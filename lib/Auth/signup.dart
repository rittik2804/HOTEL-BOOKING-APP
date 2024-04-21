import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:najara_stays/Auth/login.dart';
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../Controller/Cont/homeApi.dart';
import '../Controller/authCont/gamilLoginApi.dart';
import '../Controller/authCont/signupApi.dart';
import '../common/textstyle.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  TextEditingController name =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
  TextEditingController number =TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _gmailloginCont = Get.put(GmailLoginCont());
  final _formkey = GlobalKey<FormState>();
  final _signupCont = Get.put(SignupCont());
  bool visibile=true;
  bool check = false;
  bool loading=false;
  var value;
  var terms;
  var device_token;

  void initState() {
    load();
    var messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){
      print('The token is------------ $value');
      setState(() {
        device_token = value.toString();
      });
    });
    super.initState();
  }
  load(){
    HotelApi().Term$CondApi().then((value){
      setState((){terms=value;
      });
    });
  }


  Future<void>signup(BuildContext context)async{
    final GoogleSignIn googleSignIn=GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount= await googleSignIn.signIn();
    if(googleSignInAccount !=null){
      final GoogleSignInAuthentication googleSignInAuthentication= await googleSignInAccount.authentication;
      final AuthCredential authCredential =GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken
      );
      UserCredential result =await auth.signInWithCredential(authCredential);
      User user =result.user!;
      var email=user.email;
      print("user-----${user.providerData.map((e) => e.uid)}");
      print("user-----${user.displayName}");
      print("result-----${user}");
      if(result !=null){
        _gmailloginCont.gmailloginApi(email:user.email!,name:user.displayName!, fcm_token: device_token, context: context,);
        // Get.off(Bottom_navigation());
      }
    }
  }
    void _logInWithFacebook() async {
    setState(() {
      loading = true;
    });
    try{
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      // final facebookAuthCredential = FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);
      //
      // await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      if(userData !=null){
        print("asasasasas----------------------${json.encode(userData)}");

        _gmailloginCont.gmailloginApi(email:userData?["email"] ?? "" ,name:userData?["name"] ?? "", fcm_token: device_token, context: context,);
        // Get.off(Bottom_navigation());
      }

    } on FirebaseAuthException catch (e) {
      var title = "" ;
      print("asasasasas----------------------$e");
      switch (e.code){

      }
    }finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: const Color(0xFF97BCFF),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child:Image.asset('assests/logoLogin.png',scale: 2,
                ),
              ),
              Container(
                width: width,
                padding: const EdgeInsets.only(top: 18),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
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
                      padding: const EdgeInsets.only(top: 28),
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
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        width: 315,
                        padding: const EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Text('Sign Up',style:TextStyles.font25Blue),
                              ),
                              SizedBox(
                                height:40,
                                child: TextFormField(
                                    controller: name,
                                    validator: (mailvalid) {
                                      if (mailvalid!.isEmpty) {
                                        return "Please enter name";
                                      }  else {
                                        return null;
                                      }
                                    },
                                    decoration:InputDecoration(
                                      hintText: 'Name',
                                      hintStyle: TextStyles.hint_text,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(width: 1.5,color: Colors.black.withOpacity(0.2))),
                                    )
                                ),
                              ),
                              const SizedBox(height: 10,),
                              SizedBox(
                                height:40,
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
                                    decoration:InputDecoration(
                                      hintText: 'Email id',
                                      hintStyle: TextStyles.hint_text,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(width: 1.5,color: Colors.black.withOpacity(0.2))),
                                    )
                                ),
                              ),
                              const SizedBox(height: 10,),
                              SizedBox(
                                height:40,
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
                                      hintText: 'Password',
                                      hintStyle: TextStyles.hint_text,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(width: 1.5,color: Colors.black.withOpacity(0.2))),
                                    )
                                ),
                              ),
                              const SizedBox(height: 10,),
                              SizedBox(
                                height:40,
                                child: TextFormField(
                                    controller: number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter your number';
                                      } else if (value.length < 10 || value.length > 10) {
                                        return "enter 10 digit number";
                                      } else
                                        null;
                                    },
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10)],
                                    keyboardType: TextInputType.number,
                                    decoration:InputDecoration(
                                      hintText: 'Phone Number',
                                      hintStyle: TextStyles.hint_text,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(width: 1.5,color: Colors.black.withOpacity(0.2))),
                                    )
                                ),
                              ),
                              SizedBox(
                                height: 35,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:20,
                                      child: Checkbox(
                                        activeColor:  const Color(0xFF004AAD),
                                        checkColor: Colors.white,
                                        side: const BorderSide(
                                          color: Color(0xFF004AAD),
                                        ),
                                        value: this.check,
                                        onChanged: (value) {
                                          setState(() {
                                            this.check = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Text('I agree the ',style:GoogleFonts.firaSans(
                                        fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black
                                    )),
                                    InkWell(
                                      onTap: (){
                                        showdatails(context);
                                      },
                                      child: Text('Terms & Conditions ',style:GoogleFonts.firaSans(
                                          fontWeight: FontWeight.w400,fontSize: 14,color:const Color(0xFF004AAD)
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:20),
                                child:  _signupCont.isLoading.value == true?const Center(child: CircularProgressIndicator()):
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      if(_formkey.currentState!.validate()){
                                        if(check==true) {
                                          _signupCont.isLoading.value = true;
                                          _signupCont.signupApi(
                                              email: email.text.toString(),
                                              name: name.text.toString(),
                                              pass: password.text.toString(),
                                              phone_number: number.text.toString(),
                                              context: context).then((value){
                                                setState(() {
                                                  _signupCont.isLoading.value = false;
                                                });
                                          });
                                        }else{
                                          CommonToast(context: context, title: 'Please agree term and condition', alignCenter: false);
                                        }
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(right:6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: const Color(0xFF004AAD)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(width: 50,),
                                        Container(
                                          child: Text('Sign Up',style:TextStyles.font25W),
                                        ),
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.blue.shade700,
                                          // backgroundColor: Colors.blue.shade200,
                                          child: const Icon(Icons.arrow_forward_outlined,color: Colors.white,),
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
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: (){
                        _logInWithFacebook(); 
                      },
                      child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                              // border: Border.all(color: Colors.white,width: 1),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Image.asset("assests/fb.png",scale:2.5)
                      ),
                    ),
                    const SizedBox(width: 35,),
                    InkWell(
                      onTap: (){
                        signup(context);
                      },
                      child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              // border: Border.all(color: Colors.white,width: 1),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Image.asset("assests/google.png",scale:3,)
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 30,bottom: 10),
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? ',style:TextStyles.font16B),
                    InkWell(
                        onTap: (){
                          Get.to(const Login());
                        },
                        child: Text('Login ',style:TextStyles.font16Blue)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future showdatails(context){
    return   showDialog(
        barrierColor: Colors.black.withOpacity(0.8),
        useSafeArea:true ,
        context: context,
        builder: (BuildContext context) {
          return Container(
            // color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 130),
            child:Padding(
              padding: const EdgeInsets.only(top:30.0,left: 20,right: 20),
              child: Card(
                color: Colors.white,
                elevation: 4,
                child:ListView(
                  children: [
                    const SizedBox(height: 25,),
                    Text('Term & Conditions',
                        textAlign: TextAlign.center,
                        style:TextStyles.font22Blue500
                    ),
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: HtmlWidget(terms,),
                    ),
               ] ),
              ),
            ),

          );});
  }
}



