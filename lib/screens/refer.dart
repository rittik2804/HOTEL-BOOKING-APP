// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../common/textstyle.dart';
//
// class Refer extends StatefulWidget {
//   const Refer({Key? key}) : super(key: key);
//
//   @override
//   State<Refer> createState() => _ReferState();
// }
//
// class _ReferState extends State<Refer> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: (){
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_sharp,color: Colors.black,),
//         ),
//         centerTitle: true,
//         title: Text('Refer & Earn',style: TextStyles.font22Blue,
//         ),
//
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 28.0,right: 28,top: 15),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(3),
//                 border: Border.all(color: Color(0xFF52C1FF))
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: 300,
//                     child:  Text('Refer Friends and earn cash back while they Do all the shopping.',style:  GoogleFonts.firaSans(fontSize: 13,color: Colors.blue,fontWeight: FontWeight.w500,),
//                   )),
//                   SizedBox(height: 20,),
//                   Row(children: [
//                     ClipRRect(
//
//                       child: Image.asset('assests/add-friend.png',width: 40,),
//
//                     ),
//                     SizedBox(width: 10,),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                       Text('Your Friend successfully signs up.',style: GoogleFonts.firaSans(fontSize: 10,color: Colors.black,fontWeight: FontWeight.w500,),),
//                         SizedBox(height: 5,),
//                       Container(
//                         padding: EdgeInsets.only(left: 6,right: 6,top: 5,bottom: 5),
//                         decoration: BoxDecoration(
//                           color: Color(0xFFBCE7FF),
//                           borderRadius: BorderRadius.circular(2)
//                         ),
//                         child:Text('You both get INR 25',style: GoogleFonts.firaSans(fontSize: 10,color: Color(0xFF0188E2),fontWeight: FontWeight.w500,letterSpacing: 1),),
//                       )
//                     ],),
//                   ],),
//                   SizedBox(height: 30,),
//                   Row(children: [
//                     ClipRRect(
//                       child: Image.asset('assests/earning.png',width: 40,),
//                     ),
//                     SizedBox(width: 10,),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Your Friend completes first booking',style: GoogleFonts.firaSans(fontSize: 10,color: Colors.black,fontWeight: FontWeight.w500,),),
//                         SizedBox(height: 5,),
//                         Container(
//                           padding: EdgeInsets.only(left: 6,right: 6,top: 5,bottom: 5),
//                           decoration: BoxDecoration(
//                               color: Color(0xFFBCE7FF),
//                               borderRadius: BorderRadius.circular(2)
//                           ),
//                           child:Text('You both get INR 25',style: GoogleFonts.firaSans(fontSize: 10,color: Color(0xFF0188E2),fontWeight: FontWeight.w500,letterSpacing: 1),),
//                         )
//                       ],),
//                   ],),
//                   SizedBox(height: 30,),
//                   Row(children: [
//                     ClipRRect(
//                       child: Image.asset('assests/available.png',width: 40,),
//                     ),
//                     SizedBox(width: 10,),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Every time your friends bookings.you get',style: GoogleFonts.firaSans(fontSize: 10,color: Colors.black,fontWeight: FontWeight.w500,),),
//                         SizedBox(height: 5,),
//                         Container(
//                           padding: EdgeInsets.only(left: 6,right: 6,top: 5,bottom: 5),
//                           decoration: BoxDecoration(
//                               color: Color(0xFFBCE7FF),
//                               borderRadius: BorderRadius.circular(2)
//                           ),
//                           child:Text('You both get INR 25',style: GoogleFonts.firaSans(fontSize: 10,color: Color(0xFF0188E2),fontWeight: FontWeight.w500,letterSpacing: 1),),
//                         )
//                       ],),
//                   ],),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
