


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:najara_stays/Controller/Cont/fliterApi.dart';
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import 'package:najara_stays/screens/booking.dart';
import 'package:najara_stays/screens/filter.dart';
import 'package:najara_stays/screens/hotel_detail.dart';
import '../Controller/Cont/get_hotel_Api.dart';
import '../Modals/homeTophotelM.dart';
import '../common/textstyle.dart';

class Hotel extends StatefulWidget {

  String type;
  String hoteltype;
  Hotel({Key? key,required this.type,required this.hoteltype,}) : super(key: key);
  @override
  State<Hotel> createState() => _HotelState();
}

class _HotelState extends State<Hotel> {
  final fliter=Get.put(FiterController());
  final _get_hotelCont=Get.put(Get_hotelCont());
  List<HomeTophotelData> hoteldata = [];
  bool loader=true;
  int price = 0;
  double rating = 3;
  var value;
  bool selected=false;

  @override
  void initState() {
    load();
    super.initState();
  }

  load(){
    _get_hotelCont.get_hotelapi(type: widget.type,hotelType: widget.hoteltype).then((value)=> setState(() {
      loader=false;
    }));
  }


  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_sharp,color: Colors.black,),
          ),
          centerTitle: true,
          title: titlText(widget.hoteltype),
          
          // Text(widget.hoteltype=='3'?'All Homestays':widget.hoteltype=='2'?'All Villas':'All Hotels',
          
          
          // style: TextStyles.font22Blue500,
          // ),
          actions: [
            IconButton(onPressed: (){
              Get.to(()=>Filter(hoteltype: widget.hoteltype, type: widget.type,));
            }, icon:Image.asset('assests/setting.png',scale: 4),
              color: Colors.black,)
          ],
        ),
        body:
        loader==true?const Center(child: CircularProgressIndicator()):
        SizedBox(
          width: double.infinity,
          child: Obx(()=>
          _get_hotelCont.getHotel_list.isEmpty?
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(child: Text('No Data Found',style: TextStyles.font16B)),
              ):
              ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 15,right: 15,top: 0),
              itemCount: _get_hotelCont.getHotel_list.length,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              itemBuilder: (context ,i){
                var data= _get_hotelCont.getHotel_list[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        Get.to(()=>HotelDetails(id: data.id.toString()));
                        //Get.to(()=>Booking(hotelId: 70.toString(), roomtype: 1.toString(), mealtype: 1.toString(), roomId: 1.toString(), dueAmount: 100.toString()));
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(3)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width*0.39,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(3),bottomLeft: Radius.circular(3)),
                              child: Image(image: CachedNetworkImageProvider( Url.Image_URL+data.mainImage.toString(),),
                                fit: BoxFit.cover,height: 120,),
                            ),
                          ),
                          const SizedBox(width: 8,),
                          Container(
                            width: width*0.47,
                            padding: const EdgeInsets.only(top: 5,bottom: 2),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(data.hotelName.toString(),style: TextStyles.font14B,),
                                Row(
                                  children: [
                                      const Text("★",style: TextStyle(color: Colors.green),textScaleFactor: 1,),
                                       Text(data.rating.toString(),style: TextStyles.Ofont14B,),
                                  ],
                                ),
                                //Text(data.offerPrice == null ? "" : "₹ ${data.offerPrice}",style:GoogleFonts.firaSans(fontSize: 13,color: const Color(0xFF0188E2),fontWeight: FontWeight.w500)),
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_on,color: Colors.black.withOpacity(0.4),size: 18,),
                                        Text('${ data.city}',style: TextStyles.Ofont14B,),
                                      ],
                                    ),
                                    data.rating==null?Container():Row(
                                      children: [
                                        // const Text("★",style: TextStyle(color: Colors.green),textScaleFactor: 1,),
                                        // Text(data.rating.toString(),style: TextStyles.Ofont14B,),
                                        Text(data.offerPrice == null ? "" : "₹ ${data.offerPrice}",style:GoogleFonts.firaSans(fontSize: 13,color: const Color(0xFF0188E2),fontWeight: FontWeight.w500)),

                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Text(data.description.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                  maxLines: 3,
                                  style: TextStyles.Ofont13B,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
          )
        )
    );
  }



}

  Text titlText(String s){
    if(s=="1"){
    return Text("Hotels",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),);
    }else if(s=="3"){
    return Text("Homestays",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),);
    }else if(s=="2"){
     return Text("Villas",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),);
    }else if(s=="4"){
      return Text("Cottages",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),);
    }else if(s=="5"){
       return Text("Camps",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),);
    }else{
      return Text("All Hotels");
    }
  }











// class Hotel extends StatefulWidget {
//   String status;
//   String type;
//   String hoteltype;
//   Hotel({Key? key,required this.type,required this.hoteltype,required this.status}) : super(key: key);
//
//   @override
//   State<Hotel> createState() => _HotelState();
// }
//
// class _HotelState extends State<Hotel> {
//   final fliter=Get.put(FiterController());
//   final _get_hotelCont=Get.put(Get_hotelCont());
//   bool loader=true;
//   List<HomeTophotelData> hoteldata = [];
//   @override
//   void initState() {
//     print('--------ststus----------${widget.status}');
//     load();
//     super.initState();
//   }
//
//   load(){
//     widget.status=='1'?null:
//     HotelApi().hotelapi(type: widget.type,hotelType: widget.hoteltype).then((value){
//       setState((){
//         loader=false;
//         hoteldata=value.data!;
//       });
//
//     });
//     loader=false;
//     _get_hotelCont.get_hotelapi(type: widget.type,hotelType: widget.hoteltype).then((value)=> setState(() {}));
//   }
//   int price = 0;
//   double rating = 3;
//   var value;
//   bool selected=false;
//
//   @override
//   Widget build(BuildContext context) {
//     var width= MediaQuery.of(context).size.width;
//     var height= MediaQuery.of(context).size.height;
//     return  Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             onPressed: (){
//               Navigator.push(context,MaterialPageRoute(builder: (_)=>Bottom()));
//               // Get.to(()=>Bottom());
//             },
//             icon: Icon(Icons.arrow_back_sharp,color: Colors.black,),
//           ),
//           centerTitle: true,
//           title: Text(widget.hoteltype=='3'?'All Homestays':widget.hoteltype=='2'?'All Villas':'All Hotels',style: TextStyles.font22Blue500,
//           ),
//           actions: [
//             IconButton(onPressed: (){
//               Get.to(()=>Filter(hoteltype: widget.hoteltype, type: widget.type,));
//             }, icon:Image.asset('assests/setting.png',scale: 4),
//               color: Colors.black,)
//           ],
//         ),
//         body: loader==true?Center(child: CircularProgressIndicator()):Container(
//           width: double.infinity,
//           child:    widget.status=='0'?
//           ListView.builder(
//               shrinkWrap: true,
//               padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
//               itemCount: hoteldata.length,
//               scrollDirection: Axis.vertical,
//               physics: ScrollPhysics(),
//               itemBuilder: (context ,i){
//                 var data= hoteldata[i];
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 15),
//                   child: InkWell(
//                     onTap: (){
//                       Get.to(()=>HotelDetails(id: data.id.toString()));
//                     },
//                     child: Container(
//                       width:double.infinity,
//                       height: 100,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.blue.withOpacity(0.4)),
//                           borderRadius: BorderRadius.circular(3)
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: width*0.39,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.only(topLeft: Radius.circular(3),bottomLeft: Radius.circular(3)),
//                               child: Image(image:
//                               CachedNetworkImageProvider( Url.Image_URL+data.mainImage.toString(),
//                                 // NetworkImage(Url.Image_URL+data.mainImage.toString()
//                               ),
//                                 fit: BoxFit.fill,height: 100,),
//                             ),
//                           ),
//                           SizedBox(width: 8,),
//                           Container(
//                             width: width*0.47,
//                             padding: EdgeInsets.only(top: 5,bottom: 2),
//                             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               mainAxisSize: MainAxisSize.max,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Text('${data.hotelName.toString()}',style: TextStyles.font16B,),
//                                     Text("₹ ${data.offerPrice}",style:GoogleFonts.firaSans(fontSize: 13,color: Color(0xFF0188E2),fontWeight: FontWeight.w500,),
//                                     ),
//                                   ],
//                                 ),
//                                 Container(
//                                     child: Row(
//                                       mainAxisAlignment:MainAxisAlignment.spaceBetween,mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(Icons.location_on,color: Colors.black.withOpacity(0.4),size: 18,),
//                                             Text('${ data.city}',style: TextStyles.Ofont14B,),
//                                           ],
//                                         ),
//                                         // Spacer(),
//                                         data.rating==null?Container():Row(
//                                           children: [
//                                             Text("★",style: TextStyle(color: Colors.green),textScaleFactor: 1,),
//                                             Text(data.rating.toString(),style: TextStyles.Ofont14B,),
//                                           ],
//                                         ),
//
//                                       ],
//                                     )),
//                                 SizedBox(height: 5,),
//                                 Container(
//                                   child: Text(data.description.toString(),
//                                     overflow: TextOverflow.ellipsis,
//                                     textAlign: TextAlign.justify,
//                                     maxLines: 3,
//                                     style: TextStyles.Ofont13B,),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }):
//           ListView.builder(
//               shrinkWrap: true,
//               padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
//               itemCount: fliter.filterlist.length,
//               scrollDirection: Axis.vertical,
//               physics: ScrollPhysics(),
//               itemBuilder: (context ,i){
//                 var data= fliter.filterlist[i];
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 15),
//                   child: InkWell(
//                     onTap: (){
//                       setState(() {
//                         Get.to(()=>HotelDetails(id: data.hotelId.toString()));
//                       });
//                     },
//                     child: Container(
//                       width:double.infinity,
//                       height: 100,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.blue.withOpacity(0.4)),
//                           borderRadius: BorderRadius.circular(3)
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: width*0.39,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.only(topLeft: Radius.circular(3),bottomLeft: Radius.circular(3)),
//                               child: Image(image:
//                               CachedNetworkImageProvider( Url.Image_URL+data.mainImage.toString(),
//                                 // NetworkImage(Url.Image_URL+data.mainImage.toString()
//                               ),
//                                 fit: BoxFit.fill,height: 100,),
//                             ),
//                           ),
//                           SizedBox(width: 8,),
//                           Container(
//                             width: width*0.47,
//                             padding: EdgeInsets.only(top: 5,bottom: 2),
//                             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               mainAxisSize: MainAxisSize.max,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Text(data.hotelName.toString(),style: TextStyles.font16B,),
//                                     Text("₹ ${data.offerPrice}",style:GoogleFonts.firaSans(fontSize: 13,color: Color(0xFF0188E2),fontWeight: FontWeight.w500,),
//                                     ),
//                                   ],
//                                 ),
//                                 Container(
//                                     child: Row(
//                                       mainAxisAlignment:MainAxisAlignment.spaceBetween,mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(Icons.location_on,color: Colors.black.withOpacity(0.4),size: 18,),
//                                             Text('${ data.city}',style: TextStyles.Ofont14B,),
//                                           ],
//                                         ),
//                                         // Spacer(),
//                                         data.rating==null?Container():Row(
//                                           children: [
//                                             Text("★",style: TextStyle(color: Colors.green),textScaleFactor: 1,),
//                                             Text(data.rating.toString(),style: TextStyles.Ofont14B,),
//                                           ],
//                                         ),
//                                       ],
//                                     )),
//                                 SizedBox(height: 5,),
//                                 Container(
//                                   child: Text(data.description.toString(),
//                                     overflow: TextOverflow.ellipsis,
//                                     textAlign: TextAlign.justify,
//                                     maxLines: 3,
//                                     style: TextStyles.Ofont13B,),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//         )
//     );
//   }
// }