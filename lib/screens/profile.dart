import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../Controller/Cont/homeApi.dart';
import '../Controller/Cont/updateprofileApi.dart';
import '../Controller/authCont/baseUrl.dart';
import '../Modals/profileM.dart';
import '../common/textstyle.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
   File? upimage;
  String? _uploadimage;
TextEditingController  name=TextEditingController();
TextEditingController  email=TextEditingController();
TextEditingController  number=TextEditingController();
  final _profileCont = Get.put(UpdateprofileCont());
  ProfileData _profile=ProfileData();
  bool loader =true;
  @override
  void initState() {
    nameloader();
    super.initState();
  }
  nameloader()async{
    HotelApi(). Myprofile().then((value){
      setState(() {
        loader =false;
        _profile=value.data!;
        name.text=_profile.name.toString();
        email.text=_profile.email.toString();
        number.text=_profile.phoneNumber.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading:const Icon(Icons.arrow_back_sharp,color: Colors.white,),
        centerTitle: true,
        title: Text('Profile',style: TextStyles.font22Blue500,
        ),
      ),
      body:loader==true?const Center(child: CircularProgressIndicator()): Form(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40,),
                Stack(
                  children:  [
                    _uploadimage==null ?_profile.profileImage.toString()==null.toString()?
                     const CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:AssetImage('assests/img.png'),
                      radius: 80,
                    )
                       :CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:NetworkImage(Url.Image_URL+_profile.profileImage.toString()),
                      radius: 80,
                    ) :CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:Image.file(upimage!).image,
                      radius: 80,
                    ),
                    Positioned(
                      right: 0,
                        child: InkWell(
                          onTap: () async {
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.image,
                            );
                            upimage=File(result!.files.single.path!);
                            setState(() {
                              _uploadimage=result.files.single.path;
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 4,top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.camera_alt_rounded,size: 18,color: Colors.black,),
                              radius: 13,
                            ),
                          ),
                        )
                    ),
                  ],
                ),
                // Text('matthardy@gmail.com',
                //   style:GoogleFonts.firaSans(fontSize: 14,color: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w400,),),
                const SizedBox(height: 15,),
                Container(
                  height:40,
                  child: TextFormField(
                      controller: name,
                      style:TextStyles.font16B,
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
                // Text('Matt Hardy',style: TextStyles.font22B,),
                const SizedBox(height: 15,),
                SizedBox(
                  height:40,
                  child: TextFormField(
                      controller: email,
                      style:TextStyles.font16B,
                      readOnly: true,
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
                          hintText: 'Email',
                          hintStyle: TextStyles.hint_text,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.black.withOpacity(0.2))
                          )
                      )
                  ),
                ),
                 const SizedBox(height: 15,),
                _profile.phoneNumber.toString()==null.toString()?Container(height: 40,):
                SizedBox(
                  height:40,
                  child: TextFormField(
                      controller: number,
                      style:TextStyles.font16B,
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
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(top:40),
                  child:
                  _profileCont.isLoading.value == true?const Center(child: CircularProgressIndicator()):
                  InkWell(
                    onTap: ()async{
                      setState(() {
                        _profileCont.isLoading.value=true;
                          _profileCont.profieApi(
                              context: context,
                            email: email.text.toString(),name: name.text.toString(),number: number.text.toString(),
                            image:_uploadimage==null?null.toString():upimage!.path,
                          ).then((value) {
                            setState(() {
                              _profileCont.isLoading.value=false;
                              nameloader();
                            });

                          });
                          loader =false;
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
                          Text('Update Profile',style:TextStyles.font22W),
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
    );
  }
}











//
// InkWell(
// onTap: (){
// Get.to(()=>Home());
// },
// child: Padding(
// padding: const EdgeInsets.only(left: 28.0,right: 28,top: 27),
// child: Row(mainAxisSize: MainAxisSize.max,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// children: [
// CircleAvatar(
// backgroundColor: Color(0xFFFF6252),
// child: Icon(Icons.home,size: 24,color: Colors.white,),
// radius: 18,
// ),
// SizedBox(width: 20,),
// Text('Home',style: TextStyles.font16B,),
// ],
// ),
// Icon(Icons.arrow_forward_ios_outlined,size: 14,color: Colors.black.withOpacity(0.6),)
// ],
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(left: 28.0,right: 28,top: 15),
// child: InkWell(
// onTap: (){
// Get.to(()=>Refer());
// },
// child: Row(mainAxisSize: MainAxisSize.max,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// child: Row(
// children: [
// CircleAvatar(
// backgroundColor: Color(0xFF6052FF),
// child: Image.asset('assests/refer.png',scale: 3.5),
// radius: 18,
// ),
// SizedBox(width: 20,),
// Text('Refer & Earn',style: TextStyles.font16B,),
// ],
// ),
// ),
// Icon(Icons.arrow_forward_ios_outlined,size: 14,color: Colors.black.withOpacity(0.6),)
// ],
// ),
// ),
// ),
//
// InkWell(
// onTap: (){
//
// },
// child: Padding(
// padding: const EdgeInsets.only(left: 28.0,right: 28,top: 15),
// child: Row(mainAxisSize: MainAxisSize.max,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// children: [
// CircleAvatar(
// backgroundColor: Color(0xFF469E00),
// child: Icon(Icons.person,size: 24,color: Colors.white,),
// radius: 18,
// ),
// SizedBox(width: 20,),
// Text('My Profile',style: TextStyles.font16B,),
// ],
// ),
// Icon(Icons.arrow_forward_ios_outlined,size: 14,color: Colors.black.withOpacity(0.6),)
// ],
// ),
// ),
// ),
// InkWell(
// onTap: (){
// Get.to(()=>Mybooking());
// },
// child: Padding(
// padding: const EdgeInsets.only(left: 28.0,right: 28,top: 15),
// child: Row(mainAxisSize: MainAxisSize.max,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// children: [
// CircleAvatar(
// backgroundColor: Color(0xFFFF52D9),
// child: Icon(Icons.calendar_month,size: 24,color: Colors.white,),
// radius: 18,
// ),
// SizedBox(width: 20,),
// Text('My Bookings',style: TextStyles.font16B,),
// ],
// ),
// Icon(Icons.arrow_forward_ios_outlined,size: 14,color: Colors.black.withOpacity(0.6),)
// ],
// ),
// ),
// ),
//
// Padding(
// padding: const EdgeInsets.only(left: 28.0,right: 28,top: 15),
// child: Row(mainAxisSize: MainAxisSize.max,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// child: Row(
// children: [
// CircleAvatar(
// backgroundColor: Color(0xFFFCDE67),
// child: Icon(Icons.thumb_up,size: 24,color: Colors.white,),
// radius: 18,
// ),
// SizedBox(width: 20,),
// Text('Rate Us',style: TextStyles.font16B,),
// ],
// ),
// ),
// Icon(Icons.arrow_forward_ios_outlined,size: 14,color: Colors.black.withOpacity(0.6),)
// ],
// ),
// ),
// Padding(
//   padding: const EdgeInsets.only(left: 28.0,right: 28,top: 15),
//   child:  InkWell(
//     onTap:() async {
//       popup();
//
//     },
//     child: Row(mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Color(0xFF8F8F8F),
//                 child: Icon(Icons.logout_outlined,size: 22,color: Colors.white,),
//                 radius: 18,
//               ),
//               SizedBox(width: 20,),
//               Text('Log Out',style: TextStyles.font16B,),
//             ],
//           ),
//         ),
//         Icon(Icons.arrow_forward_ios_outlined,size: 14,color: Colors.black.withOpacity(0.6),)
//       ],
//     ),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.only(left: 28.0,right: 28,top: 15),
//   child: Row(mainAxisSize: MainAxisSize.max,
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Container(
//         child: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: Color(0xFF5297FF),
//               child: Icon(Icons.info_outline,size: 24,color: Colors.white,),
//               radius: 18,
//             ),
//             SizedBox(width: 20,),
//             Text('About Us',style: TextStyles.font16B,),
//           ],
//         ),
//       ),
//       Icon(Icons.arrow_forward_ios_outlined,size: 14,color: Colors.black.withOpacity(0.6),)
//     ],
//   ),
// ),