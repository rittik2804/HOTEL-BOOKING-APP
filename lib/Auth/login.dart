import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:najara_stays/Auth/forgetpassword.dart';
import 'package:najara_stays/Auth/signup.dart';
import '../Controller/authCont/LoginApi.dart';
import '../Controller/authCont/gamilLoginApi.dart';
import '../common/sharepre.dart';
import '../common/textstyle.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/bottomscreen.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _loginCont = Get.put(LoginCont());
  final _gmailloginCont = Get.put(GmailLoginCont());
  final _formkey = GlobalKey<FormState>();
  DateTime lastTimeBackbuttonWasClicked = DateTime.now();
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();

  bool visibile=true;
  bool loader=false;
  bool loading = false;
  var device_token;

  Future<void>signup(BuildContext context)async{
    try{
    print("Click-----");
    final GoogleSignIn googleSignIn=GoogleSignIn();
    print("googleSignIn-----${googleSignIn}");

    final GoogleSignInAccount? googleSignInAccount= await googleSignIn.signIn();

    print("googleSignInAccount-----${googleSignInAccount}");

    if(googleSignInAccount !=null){
      final GoogleSignInAuthentication googleSignInAuthentication= await googleSignInAccount.authentication;
      print("idToken-----${googleSignInAuthentication.idToken}");

      final AuthCredential authCredential =GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken
      );
      UserCredential result =await auth.signInWithCredential(authCredential);
      User user =result.user!;
var email=user.email;
      print("user-----${user.providerData.map((e) => e.uid)}");
      print("user-----${user.displayName}");
      print("user-----${user.phoneNumber}");
      print("result-----${user}");
      if(result !=null){
        _gmailloginCont.gmailloginApi(email:user.email!,name:user.displayName!, fcm_token: device_token, context: context,);
        // Get.off(Bottom_navigation());
      }
    }else{
      print("not worked");
    }
    }catch(exception){
      print("exception-----${exception}");

    }
  }

  void _logInWithFacebook() async {
    setState(() {
      loading = true;
    });
    try{
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData =  await FacebookAuth.instance.getUserData();

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



  // final FacebookLogin facebookLogin = FacebookLogin();


  // getToken() async {
  //   token = await FirebaseMessaging.instance.getToken();
  //   print('The generated Token is ${token}');
  //   return token;
  // }
  @override
  void initState() {
    var messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){
      print('The token is------------ $value');
      setState(() {
        device_token = value.toString();
      });
    });
    super.initState();
    // getValidation();
  }
  getValidation() async {
    final getUserId = GetUserDetail();
    var userId = await getUserId.getUserData('id');
    setState(() {
      if (userId == null.toString()) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const Login()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const Bottom()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: ()async{
      if (DateTime.now().difference(lastTimeBackbuttonWasClicked) >= const Duration(seconds: 2)) {
        setState(() {
          _loginCont.isLoading.value = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Press the back button again to go back"),
            duration: Duration(seconds: 2),
          ),
        );
        lastTimeBackbuttonWasClicked = DateTime.now();
        return false;
      } else {
        return true;
      }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF97BCFF),
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child:Image.asset('assests/logoLogin.png',scale: 2,
                  ),
                ),
                Container(
                  width: width,
                  padding: const EdgeInsets.only(top: 18 ),
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
                          padding: const EdgeInsets.only(bottom: 40),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text('Login',style:TextStyles.font25Blue),
                                ),
                                SizedBox(
                                  height:40,
                                  child: TextFormField(
                                      controller: email,
                                      style:TextStyles.font16B ,
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
                                          hintText: 'Email id',
                                          hintStyle: TextStyles.hint_text,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(width: 1.5,color: Colors.black.withOpacity(0.2))
                                          )
                                      )
                                  ),
                                ),
                                const SizedBox(height: 40,),
                                SizedBox(
                                  height:40,
                                  child: TextFormField(
                                      controller: password,
                                      style:TextStyles.font16B ,
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
                                            borderSide: BorderSide(width: 1.5,color: Colors.black.withOpacity(0.2))
                                          )
                                      )
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Get.to(const Forget());
                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 8,top: 8),
                                    child: Text('Forgot Password?',style:GoogleFonts.firaSans(
                                        fontWeight: FontWeight.w400,fontSize: 16,color: const Color(0xFF004AAD)
                                    )),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:40),
                                  child:   _loginCont.isLoading.value == true?const Center(child: CircularProgressIndicator()): InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(_formkey.currentState!.validate()) {
                                          _loginCont.isLoading.value = true;
                                          _loginCont.loginApi(
                                              context: context, email: email.text.toString(), password: password.text.toString(), fcm_token: device_token).then((value){
                                                setState(() {
                                                  _loginCont.isLoading.value = false;
                                                });
                                          });
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
                                          Text('Login',style:TextStyles.font25W),
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.blue.shade700,
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
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap:(){
                          _logInWithFacebook();
                        },
                        child:  Image.asset("assests/fb.png",scale: 3,width: 50,height: 50,fit: BoxFit.fill),
                      ),
                      const SizedBox(width: 30),
                      InkWell(
                        onTap: (){
                          signup(context);
                        },
                        child: Image.asset("assests/google.png",scale:3,width: 50,height: 50,fit: BoxFit.fill),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Don’t have an account? ',style:TextStyles.font16B),
                      InkWell(
                          onTap: (){
                            Get.to(const SignUp());
                          },
                          child: Text('Sign up ',style:TextStyles.font16Blue)),
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


