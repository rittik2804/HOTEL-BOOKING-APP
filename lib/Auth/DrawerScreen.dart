
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:najara_stays/screens/bottomscreen.dart';
import 'package:najara_stays/screens/profile.dart';
import '../Controller/authCont/baseUrl.dart';
import '../common/sharepre.dart';
import '../common/textstyle.dart';
import '../screens/Home.dart';
import '../screens/mybooking.dart';
import 'login.dart';


class drawerScreen{
  getDrawer(context,name,image){
    print(image);
    return SizedBox(
      width: MediaQuery.of(context).size.width/1.3,
      child: Drawer(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: const Color(0xFF004AAD),
                // color: const Color(0xFF2F1866),
                padding: const EdgeInsets.only(top: 60.0,left: 20.0,right: 15.0,bottom: 20.0),
                child: Row(
                  children: [
                    image.toString()==null.toString()?
                    Container(
                      decoration : BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.yellow,
                      ),
                      child:  const Icon(Icons.person,size: 100,color: Colors.grey,),
                    ): CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:NetworkImage(Url.Image_URL+image.toString()),
                      radius: 55,
                    ),
                    const SizedBox(width: 15.0,),
                    Flexible(
                      child: Text(name.toString(),style: TextStyles.font16W,
                      maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                flex: 2,
                child: ListView(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading:const CircleAvatar(
                        // backgroundColor: Color(0xFFFF6252),
                        backgroundColor: Colors.white,
                        radius: 18,
                        child: Icon(Icons.home,size: 28,color:  Color(0xFFFFB818),),
                      ),
                      title: Text('Home',style: TextStyles.font18B,),
                      trailing:  const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>const Bottom()));
                        // Get.to(()=>Home());
                      },
                    ),
                    // ListTile(
                    //   leading:   CircleAvatar(
                    //     backgroundColor: Color(0xFF6052FF),
                    //     child: Image.asset('assests/refer.png',scale: 3.5),
                    //     radius: 18,
                    //   ),
                    //   title: Text('Refer & Earn',style: TextStyles.font16B,),
                    //   trailing:  const Icon(
                    //     Icons.arrow_forward_ios_rounded,
                    //     size: 18,
                    //     color: Colors.grey,
                    //   ),
                    //   onTap: () {
                    //     Get.to(()=>Refer());
                    //   },
                    // ),
                    ListTile(
                      leading:  const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 18,
                        child: Icon(Icons.person,size: 28,color:  Color(0xFFFFB818),),
                      ),
                      title:  Text('My Profile',style: TextStyles.font18B,),
                      trailing:  const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>const Profile()));
                        // Get.to(()=>Profile());
                      },
                    ),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor:Colors.white,
                        radius: 18,
                        child: Icon(Icons.calendar_month,size: 28,color: Color(0xFFFFB818),),
                      ),
                      title:  Text('My Bookings',style: TextStyles.font18B,),
                      trailing:  const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>Mybooking()));
                        // Get.to(()=>Mybooking());
                      },
                    ),
                    ListTile(
                      leading: const   CircleAvatar(
                        backgroundColor:Colors.white,
                        radius: 18,
                        child: Icon(Icons.thumb_up,size: 28,color:  Color(0xFFFFB818),),
                      ),
                      title:   Text('Rate Us',style: TextStyles.font18B,),
                      trailing:  const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => grievance(),));
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: ()async{
                        thankDialog(context);
                      },
                      child: Chip(
                        label: Text("Log Out",style: TextStyles.font16B500,),
                        avatar: const Icon(Icons.power_settings_new,color: Colors.red),),
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
  Future<void> thankDialog(BuildContext context) {
    return showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor:primaryColor,
            contentPadding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: StatefulBuilder(builder: (context, StateSetter setState) {
              return Container(
                alignment: Alignment.center,
                height: 180,
                width: 150,
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 10.0),
                    Image.asset('assests/najara1.png',fit: BoxFit.fill,height: 50,),
                    const SizedBox(height: 3.0),
                    Padding(
                      padding: const EdgeInsets.only(left:23.0),
                      child: Text("Logout App?",textAlign: TextAlign.center,style: GoogleFonts.firaSans(fontSize: 20,color:Colors.black,fontWeight: FontWeight.w500,)),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final getUserId = GetUserDetail();
                            var userId = await  getUserId.remove('id');
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Login()),(route)=>false);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                            child: Text('Yes',style: TextStyles.font16W),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                            alignment: Alignment.center,
                           decoration: BoxDecoration(
                             color: Colors.blue,
                             borderRadius: BorderRadius.circular(20.0)
                           ),
                            child: Text('No',style: TextStyles.font16W),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              );
            }),
          );
        }
    );
  }
}