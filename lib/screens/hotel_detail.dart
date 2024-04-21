
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:najara_stays/Controller/Cont/date_manage.dart';
import 'package:najara_stays/Modals/mybookingM.dart';

import 'package:najara_stays/Modals/reviewM.dart';
import 'package:najara_stays/screens/booking.dart';
import 'package:najara_stays/screens/mybooking.dart';
import 'package:najara_stays/screens/paymentscreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Controller/Cont/homeApi.dart';
import '../Controller/Cont/referApi.dart';
import '../Controller/authCont/baseUrl.dart';
import '../Controller/Cont/hoteldetailApi.dart';
import '../Modals/hoteldetailM.dart';
import '../common/textstyle.dart';

class HotelDetails extends StatefulWidget {
  String id;
  
   HotelDetails({required this.id});

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  TextEditingController email=TextEditingController();
  TextEditingController namecont=TextEditingController();
  TextEditingController buddyname=TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _referCont=Get.put(ReferController());
  HotelDetailData data = HotelDetailData();
  ReviewData rewiewdata=ReviewData();
  List<Reviews>   review=[];
  List photo=[];
  List<Rooms>  room=[];
  List<AmenitiesIcon> amenit=[];
  List<Rooms> roomamenit=[];
  String hotelType = "0";
  String has_kitchen="0";
  bool isBooked=false;
  List <MybookingData> upcomingHotelList=[];
  
bool loader= true;
var index1;
var type;
var scrollercount=1;
 int boockedRoom=5;
// var referLink;
@override
  void initState() {
   load();
   print( "THe length is "+ room.length.toString());
   print(isBooked.toString());
   super.initState();
  }


  load(){
    print('----widget.id-------------${widget.id}');
    HotelApi().ReviewApi(id:widget.id,).then((value){
      setState((){
        rewiewdata=  value.data!;
        review=  value.data!.reviews!;
        print('----referlink-------------${rewiewdata.totalRating}');
      });

    });

  HoteldetailApi().hoteldetails(widget.id, context).then((value){
      setState((){
        loader= false;
        data = value.data!;
        has_kitchen =data.hasKitchin!;

        print("The value of kitchen is" + has_kitchen);
        photo = value.data!.images!;
        amenit = value.data!.amenitiesIcon!;
        room = value.data!.rooms!;
        roomamenit=value.data!.rooms!;
        hotelType = value.data!.hotelType!;
        dataArrayList.addAll(value.data!.images!);
        dataArrayList.add(data.imgName.toString());
        print("the hotel imageData"+dataArrayList.toString());
        
      });
      
    });

    //   HotelApi().Mybooking(type: '1').then((value) {
    //   setState((){
    //     upcomingHotelList=value.data!;
    //      for (var element in upcomingHotelList) {
    //         if (element.hotelId==widget.id) {
    //           isBooked=true;
    //           return;
    //         }
    //       }
    //   });

    // });
  }

  List<String> dataArrayList = [];
  bool select = true;

  String? Selectfloorfirst;
  bool isfloorfirst = false;
  var _index=0;

  _launchURL(Url) async {
    if (await canLaunch(Url)) {
      await launch(Url);
    } else {
      throw 'Could not launch $Url';
    }
  }
  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.amber,
      body: loader==true?const Center(child: CircularProgressIndicator()):
      Form(
        key: _formkey,
        child: SafeArea(
          
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                        width:double.infinity,
                        height: 270,
                     // color: Colors.amber,
                      child: PageView.builder(
                       onPageChanged: (index){
                         setState((){_index=index;});},
                          scrollDirection: Axis.horizontal,
                          itemCount: dataArrayList.length,
                          itemBuilder: (c,i){
                         var datas =  dataArrayList.reversed.toList()[i];
                         print(" the length is "+dataArrayList.length.toString());
                         print(dataArrayList.toString());
                         print("$datas-------------------------leanth");
                            return Container(
                             
                               height: 450,
                              // width: 260,
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                
                                imageUrl: "${Url.Image_medium_URL}$datas${Url.Image_medium_suffix}",
                               // imageUrl: "${Url.Image_medium_URL}$datas${Url.Image_medium_suffix}",
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            );
                      })
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width*0.45,
                      bottom: 5,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: buildIndicator(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                              onTap:(){
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back,color: Colors.white,)),
                          // CircleAvatar(
                          //   radius: 14,
                          //   backgroundColor: Colors.white,
                          //   child:   Icon(Icons.favorite_sharp,color: Color(0xFFC0392B),size: 18,),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20.0,top: 11,right: 30),
                //   child: Container(
                //     color: Colors.amber,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(data.hotelName.toString(),style:GoogleFonts.firaSans(fontSize: 16,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.w500,),),
                       
                //         const SizedBox(height: 4,),
                //         Container(
                //           color: Colors.green,
                //           width: double.infinity,
                //           child: Row(
                //             children: [
                //                 Icon(Icons.location_on,color: Colors.red,),
                //             //  Image.asset('assests/pin.png',fit: BoxFit.fill,height: 15,width: 15),
                              
                //                 //  Text(
                //                 //   data.address.toString(),style:GoogleFonts.firaSans(fontSize: 13,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.w500,),overflow: TextOverflow.ellipsis,softWrap: false,maxLines: 3,
                //                 // ),
                //                 Container(
                                 
                //                   width: double.infinity,
                //                       color: Colors.green,
                //                   child: Text("data"),
                //                 )
                              
                //             ],),
                //         ),
                //            //Text(data.address.toString(),style:GoogleFonts.firaSans(fontSize: 13,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.w500,),),
                //       ],
                //     ),
                //   ),
                // ),

                Container(
                 // color: Colors.amberAccent,
                  padding: const EdgeInsets.only(left: 22.0,top: 11,right: 30),
                  height: 80,
                  width: double.infinity,
                 // color: Colors.amber,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
               Padding(
                 padding: const EdgeInsets.only(left:10.0),
                 child: Text(data.hotelName.toString(),style:GoogleFonts.firaSans(fontSize: 16,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.w500,),),
               ),
                    Expanded(
                      child: Container(
                      width: double.infinity,
                      //color: Colors.green,
                      child: Row(
                        children: [
                         const  Icon(Icons.location_on,color: Colors.red,),
                          Expanded(
                            child: Text(
                              data.address.toString(),style:GoogleFonts.firaSans(fontSize: 14,color: Colors.black.withOpacity(0.8),),
                               softWrap: true,textAlign: TextAlign.justify,
                              ),
                              
                              
                              ),
                        ],
                      ),
                    ))
                  ],
                ),),
                Padding(
                  padding: const EdgeInsets.only(left: 29.0,top: 5,right: 30,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Description',style:GoogleFonts.firaSans(fontSize: 16,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.w500,),),
                      InkWell(
                        onTap: (){
                          setState(() {
                            Reviewpopup(context ,data.id);
                            // Share.share(referLink);
                          });

                        },
                        child: Container(
                          height: 22,
                          padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF004AAD),
                            borderRadius: BorderRadius.circular(3),
                          ),

                          child: Text('Refer Now',style:GoogleFonts.firaSans(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w500,),),
                        ),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //
                      //     // SizedBox(height: 2,),
                      //     // Row(children: [
                      //     //   Container(
                      //     //     padding: EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                      //     //     decoration: BoxDecoration(
                      //     //       color: Color(0xFF0188E2),
                      //     //       borderRadius: BorderRadius.circular(2),
                      //     //     ),
                      //     //       child: Text(data.rating==null?'Review & rating':data.rating.toString()  ,style:GoogleFonts.firaSans(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w400,),),),
                      //     //   // RatingBar.builder(
                      //     //   //   initialRating: data.rating==null?0:double.parse('${data.rating}'),
                      //     //   //   minRating: 1,
                      //     //   //   itemSize: 10,
                      //     //   //   direction: Axis.horizontal,
                      //     //   //   allowHalfRating: true,
                      //     //   //   itemCount: 5,
                      //     //   //   itemPadding: EdgeInsets.symmetric(horizontal: 1.0,vertical: 4),
                      //     //   //   itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber,size: 1,),
                      //     //   //   onRatingUpdate: (rating) {
                      //     //   //     print(rating);
                      //     //   //   },
                      //     //   // ),
                      //     //
                      //     // ],)
                      //   ],
                      // )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 29.0,right: 29,bottom: 5),
                  child: Text(data.description.toString(),
                    softWrap: true,textAlign: TextAlign.justify,
                    style:TextStyle(fontSize: 14,color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.w400,),
                  ),),
                const SizedBox(height: 6,),
                data.googleMapLink==null?Container():
                InkWell(
                  onTap: (){
                    setState(() {
                      print(data.googleMapLink.toString());
                      // _launchURL(data.googleMapLink.toString());
                      // _launchMapsUrl( 22.719569,75.8937);
                     isBooked==false? showLocationPopUp(context):Get.off(() => Mybooking());
                    });

                  },
                  child: Container(
                    height: 28,
                    margin:const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF004AAD),
                      borderRadius: BorderRadius.circular(3),
                    ),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on,color: Colors.white,size: 20,),
                        Text(' Location ',style:GoogleFonts.firaSans(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w500,),),
                      ],
                    ),
                  ),
                ),

                const Divider(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 29.0,top: 5,bottom: 5 ),
                  child: Center(child: Text('Rooms Category',style:GoogleFonts.firaSans(fontSize: 18,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.w500,),)),
                ),
                //SizedBox(height: 7,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                  child: SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      dragStartBehavior: DragStartBehavior.start,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: room.length,
                      itemBuilder: (c,index){
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.blue.withOpacity(0.3),width: 1)
                              ),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7.0,top:8 ,right: 5,bottom: 8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(room[index].roomName.toString(),style:GoogleFonts.firaSans(fontSize: 16,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.w500,),),
                                        InkWell(
                                          onTap: (){
                                            showDialog(
                                                barrierColor: Colors.black.withOpacity(0.9),
                                                useSafeArea:false ,
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Scaffold(
                                                    body: Container(
                                                      padding: const EdgeInsets.all(10),
                                                      width: double.infinity,
                                                      child: Stack(
                                                        alignment: Alignment.topRight,
                                                        children: [
                                                          ListView.builder(
                                                              itemCount: room[index].pictures!.length,
                                                              itemBuilder: (c,i){
                                                                return Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: ClipRRect(
                                                                      child:
                                                                      CachedNetworkImage(
                                                                        fit: BoxFit.fill,
                                                                        imageUrl:Url.Image_URL+room[index].pictures![i].path.toString(),
                                                                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                                                        height: 300,
                                                                      ),
                                                                      // Image.network(Url.Image_URL+room[index].roomPics![i].path.toString())
                                                                  ),
                                                                );
                                                              }),
                                                          InkWell(
                                                            onTap: (){Navigator.pop(context);},
                                                            child: const Padding(
                                                              padding: EdgeInsets.only(top: 22.0,right: 8),
                                                              child: CircleAvatar(
                                                                backgroundColor: Colors.white,
                                                                radius: 18,
                                                                child: Icon(Icons.close,color: Colors.black,),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),

                                                    ),
                                                  );});
                                          },
                                          child: Container(
                                            height: 20,
                                            padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                                            child: Row(
                                              children: [
                                                Text('View Room Photos',style:GoogleFonts.firaSans(fontSize: 12,color:const Color(0xFF004AAD),fontWeight: FontWeight.w400,),),
                                                const SizedBox(width: 5,),
                                                const Icon(Icons.filter,color: Color(0xFF004AAD),size: 13,)
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(height: 1,color: Colors.blue.withOpacity(0.3),),
                                  room[index].amenitiesIcons==null?const SizedBox() :Padding(
                                    padding: const EdgeInsets.only(left: 8.0,top:8 ,right: 5,bottom: 8),
                                    child: Text('Amenities',style:GoogleFonts.firaSans(fontSize: 16,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.w500,),),
                                  ),
                                  room[index].amenitiesIcons.toString()==null.toString()?const SizedBox():SizedBox(
                                      height: 75,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: const BouncingScrollPhysics(),
                                          padding: const EdgeInsets.only(left: 2),
                                          itemCount: room[index].amenitiesIcons!.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context ,i){
                                            return Padding(
                                              padding: const EdgeInsets.only(right: 8),
                                              child: Card(
                                                elevation: 3,
                                                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: const BorderSide(color: Colors.transparent)),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8.0,right: 8,top: 10,bottom: 5),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 28,
                                                        child: Image.network(Url.Image_URL+room[index].amenitiesIcons![i].path.toString()),
                                                      ),
                                                      Padding(
                                                          padding:  const EdgeInsets.only(top: 6.0),
                                                          child: SizedBox(
                                                              child: Text(room[index].amenitiesIcons![i].name.toString(),style:GoogleFonts.firaSans(fontSize: 11,color: Colors.black.withOpacity(0.7),fontWeight: FontWeight.w400,),
                                                              )
                                                          )
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          })),
                                  const SizedBox(height: 10,),
                                 has_kitchen=="0"?
                                const Padding(
                                   padding:  EdgeInsets.all(2.0),
                                   child: FittedBox(
                                    fit: BoxFit.contain,
                                     child: Text("Welcome to a Homestay Property that may include a bedroom,hall, and kitchen for your convenience.",
                                     style: TextStyle(color: Color.fromARGB(255, 131, 130, 130)),
                                     maxLines: 2,
                                                                       ),
                                   ),
                                 ): Container(
                                   
                                    width: double.infinity,
                                    height: 130,
                                    child: 
                                       ListView(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Row(
                                          children: [
                                          Card(
                                            elevation: 3,
                                            
                                            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: const BorderSide(color: Colors.transparent)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 18.0,right: 18,top: 5,),
                                              child: InkWell(
                                                onTap: (){
                                                  setState((){
                                                    Selectfloorfirst=null;
                                                    type='1';
                                                  });
                                                },
                                                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    SizedBox(
                                                        child: Text('EP',style:TextStyles.font16B500,
                                                        )
                                                    ),
                                                    SizedBox(height: 22,
                                                      width: 22,
                                                      child:
                                                      const Icon(Icons.radio_button_checked,color: Color(0xFF004AAD),size: 22,),
                                                    ),

                                                    SizedBox(
                                                        child: Text('₹${room[index].offerPrice}',style:TextStyles.font16Blue600,
                                                        )
                                                    ),
                                                    Padding(
                                                        padding:  const EdgeInsets.only(top: 1.0),
                                                        child: SizedBox(
                                                            child: Text('Room',style:GoogleFonts.firaSans(fontSize: 11,color: Colors.black,fontWeight: FontWeight.w400,),
                                                            )
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ) ,
                                          Card(
                                            elevation: 3,
                                            
                                            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: const BorderSide(color: Colors.transparent)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 18.0,right: 18,top: 5,bottom: 5),
                                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  SizedBox(
                                                      child: Text('CP',style:TextStyles.font16B500,
                                                      )
                                                  ),
                                                  SizedBox(height: 20,
                                                    width: 35,
                                                    child: Radio(
                                                      fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                                        return (isfloorfirst) ? Colors.white : const Color(0xFF004AAD);
                                                      }),
                                                      focusColor: Colors.white,
                                                      hoverColor: Colors.white,
                                                      autofocus: false,
                                                      value: room[index].cpMealPrice.toString(),
                                                      groupValue: index1==index?Selectfloorfirst:null,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          index1=index;
                                                          Selectfloorfirst = value.toString();
                                                          type='2';
                                                          print(type.toString());
                                                        });
                                                      },
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    //  child: Text('₹${room[index].cpMealPrice}',style:TextStyles.font16Blue600,
                                                    child:
                                                    Text(
                                                      (int.parse(room[index].cpMealPrice!) + int.parse(room[index].offerPrice!)).toString(),
                                                      style:TextStyles.font16Blue600
                                                      )
                                                  ),
                                                  Padding(
                                                      padding:  const EdgeInsets.only(top: 1.0),
                                                      child: SizedBox(
                                                          child: Text('Breakfast',
                                                          overflow: TextOverflow.ellipsis,
                                                          style:GoogleFonts.firaSans(fontSize: 11,color: Colors.black,fontWeight: FontWeight.w400,
                                                          
                                                          ),
                                                          )
                                                      )
                                                  ),

                                                   Padding(
                                                      padding:  const EdgeInsets.only(top: 1.0),
                                                      child: SizedBox(
                                                          child: Text('(Complimentary)',
                                                          overflow: TextOverflow.ellipsis,
                                                          style:GoogleFonts.firaSans(fontSize: 11,color: Colors.black,fontWeight: FontWeight.w400,
                                                          
                                                          ),
                                                          )
                                                      )
                                                  ),
                                                 
                                                  
                                                ],
                                              ),
                                            ),
                                          ) ,
                                          Card(
                                            elevation: 3,
                                            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: const BorderSide(color: Colors.transparent)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5.0,right: 5,top: 3,bottom: 3),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  SizedBox(
                                                      child: Text('MAP',style:TextStyles.font16B500,
                                                      )
                                                  ),
                                                  SizedBox(height: 20,
                                                    width: 35,
                                                    child: Radio(
                                                      fillColor:
                                                      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                                        return (isfloorfirst) ? Colors.white : const Color(0xFF004AAD);
                                                      }),
                                                      focusColor: Colors.white,
                                                      hoverColor: Colors.white,
                                                      autofocus: false,
                                                      value:room[index].mapMealPrice.toString(),
                                                      groupValue:  index1==index?Selectfloorfirst:null,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          index1=index;
                                                          Selectfloorfirst = value.toString();
                                                          type='3';
                                                          print(type.toString());
                                                        });
                                                      },
                                                    ),
                                                  ),

                                                  SizedBox(
                                                      child: 
                                                    Text(
                                                      (int.parse(room[index].mapMealPrice!) + int.parse(room[index].offerPrice!)).toString(),
                                                      style:TextStyles.font16Blue600
                                                      )
                                                  ),
                                                  // Padding(
                                                  //     padding:  const EdgeInsets.only(top: 1.0),
                                                  //     child: SizedBox(
                                                  //         child: Text('Breakfast+Lunch\n/Dinner',
                                                  //         overflow: TextOverflow.ellipsis,
                                                  //           textAlign: TextAlign.center,
                                                  //           //fontsize 11
                                                  //           style:GoogleFonts.firaSans(fontSize: 11,color: Colors.black,fontWeight: FontWeight.w400,),
                                                  //         )
                                                  //     )
                                                  // ),
                                              Padding(
                                                 padding:  const EdgeInsets.only(top: 1.0),
                                                      child: SizedBox(
                                                          child: Text('Breakfast + Lunch /',
                                                         
                                                          style:GoogleFonts.firaSans(fontSize: 11,color: Colors.black,fontWeight: FontWeight.w400,
                                                          
                                                          ),
                                                          )
                                                      )
                                                  ),
                                                    Padding(
                                                 padding:  const EdgeInsets.only(top: 1.0),
                                                      child: SizedBox(
                                                          child: Text('Dinner',
                                                         
                                                          style:GoogleFonts.firaSans(fontSize: 11,color: Colors.black,fontWeight: FontWeight.w400,
                                                          
                                                          ),
                                                          )
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ) ,
                                          Card(
                                           
                                            elevation: 3,
                                            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: const BorderSide(color: Colors.transparent)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5.0,right: 5,top: 2,bottom: 2),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  SizedBox(
                                                      child: Text('AP',style:TextStyles.font16B500,
                                                      )
                                                  ),
                                                  SizedBox(height: 20,
                                                    width: 35,
                                                    child: Radio(
                                                      fillColor:
                                                      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                                        return (isfloorfirst) ? Colors.white :const Color(0xFF004AAD);
                                                      }),
                                                      focusColor: Colors.white,
                                                      hoverColor: Colors.white,
                                                      autofocus: false,
                                                      value: room[index].apMealPrice.toString(),
                                                      groupValue: index1==index?Selectfloorfirst:null,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          index1=index;
                                                          Selectfloorfirst = value.toString();
                                                          type='4';
                                                          print(type.toString());
                                                        });
                                                      },
                                                    ),
                                                  ),

                                                  SizedBox(
                                                      child: 
                                                      Text(
                                                      (int.parse(room[index].apMealPrice!) + int.parse(room[index].offerPrice!)).toString(),
                                                      style:TextStyles.font16Blue600
                                                      )
                                                  ),
   
                                                   Padding(
                                                 padding:  const EdgeInsets.only(top: 1.0),
                                                      child: SizedBox(
                                                          child: Text('Breakfast + Lunch +',
                                                         
                                                          style:GoogleFonts.firaSans(fontSize: 11,color: Colors.black,fontWeight: FontWeight.w400,
                                                          
                                                          ),
                                                          )
                                                      )
                                                  ),
                                                    Padding(
                                                 padding:  const EdgeInsets.only(top: 1.0),
                                                      child: SizedBox(
                                                          child: Text('Dinner',
                                                         
                                                          style:GoogleFonts.firaSans(fontSize: 11,color: Colors.black,fontWeight: FontWeight.w400,
                                                          
                                                          ),
                                                          )
                                                      )
                                                  ),

                                                
                                                ],
                                              ),
                                            ),
                                          ) ,
                                        ],),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('  Available ${hotelType == "3"? "Unit" :"Room"}: ${room[index].roomsAvailable.toString()}', style:GoogleFonts.firaSans(fontSize: 13,color: Colors.black,fontWeight: FontWeight.w500,)),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [



                                          Selectfloorfirst==null? Text('₹${room[index].offerPrice.toString()}/-',
                                            style:GoogleFonts.firaSans(fontSize: 18,color: Color(0xFF004AAD),fontWeight: FontWeight.w600,),):
                                          index1==index?
                                          Text('₹${int.parse(room[index].offerPrice.toString())+int.parse(Selectfloorfirst.toString())}/-',
                                            style:GoogleFonts.firaSans(fontSize: 18,color: Color(0xFF004AAD),fontWeight: FontWeight.w600,),):Text('₹${room[index].offerPrice.toString()}/-',
                                            style:GoogleFonts.firaSans(fontSize: 18,color: Color(0xFF004AAD),fontWeight: FontWeight.w600,),),
                                          const SizedBox(width: 8,),
                                          InkWell(
                                            onTap:(){
                                              setState(() {
                                                room[index].allRoomsBooked==false?
                                                Get.to(()=> Booking(
                                                  hotelId: data.id.toString(),
                                                  roomtype:room[index].roomType.toString(),
                                                  mealtype: index1==index?type:'1',
                                                  roomId: room[index].id.toString(),
                                                  dueAmount: data.offerPrice.toString(),
                                                  //dueAmount: data.due_amount,
                                                  hoteltype: data.hotelType.toString(),
                                                  roomName:room[index].roomName!
                                                
                                                  ))
                                                    :CommonToast(context: context, title:"Room is not available", alignCenter: true);
                                              });

                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                                              decoration: BoxDecoration(
                                                color:const Color(0xFF004AAD),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Text('Book Now',style:GoogleFonts.firaSans(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500,),),
                                            ),
                                          ),
                                          const SizedBox(width: 8,),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20,),
                                ],
                              )),
                        );
                      },
                    ),
                  ) ,
                ),
                const SizedBox(height: 10,),
                review.isEmpty?Container():
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                  child:Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.blue.withOpacity(0.3),width: 1)
                    ),
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              // scrollercount
                              Text('Ratings & reviews',style:GoogleFonts.firaSans(fontSize: 14,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.w500,),),
                            ],
                          ),
                        ),
                        Divider(height: 1,color: Colors.blue.withOpacity(0.3),),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('${rewiewdata.average}',style:GoogleFonts.firaSans(fontSize: 22,color: Colors.black,fontWeight: FontWeight.w400,)),
                                RatingBar.builder(
                                  initialRating: rewiewdata.average==null?0:double.parse('${rewiewdata.average}'),
                                  minRating: 1,
                                  itemSize: 25,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(horizontal: 1.0,vertical: 4),
                                  itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber,size: 1,),
                                  ignoreGestures: true,
                                  onRatingUpdate: (rating) {},
                                ),
                                Container(width: 20,)
                              ],
                            ),
                        Center(child:Text('${rewiewdata.totalRating} Ratings',style:GoogleFonts.firaSans(fontSize: 12,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.w500,),)),
                        const SizedBox(height: 10,),
                        Divider(height: 1,color: Colors.blue.withOpacity(0.3),),
                      const SizedBox(height: 2,),
                        ListView.builder(
                          shrinkWrap: true,
                          dragStartBehavior: DragStartBehavior.start,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: scrollercount,
                          itemBuilder: (c,index){
                            var data=review[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8,bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0,),
                                  child: Text('${data.userName ?? ''}',style:GoogleFonts.firaSans(fontSize: 15,color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.w500,),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0,),
                                  child: RatingBar.builder(
                                    initialRating: data.rating==null?0:double.parse('${data.rating}'),
                                    minRating: 1,
                                    itemSize: 12,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    ignoreGestures: true,
                                    itemPadding: const EdgeInsets.symmetric(vertical: 4),
                                    itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber,size: 1,),
                                    onRatingUpdate: (rating) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0,bottom: 8,right:10),
                                  child:data.description==null?null:Text('${data.description}',
                                    style:GoogleFonts.firaSans(fontSize: 12,color: Colors.black.withOpacity(0.7),fontWeight: FontWeight.w400,),),
                                ),
                                Divider(height: 1,color: Colors.blue.withOpacity(0.4),),

                              ] ,
                            )
                          );
                        }),
                   scrollercount==review.length?Container():
                   InkWell(
                     onTap: (){
                       setState(() {
                         scrollercount=review.length;
                       });
                     },
                     child: Container(
                              height:30,
                              alignment: Alignment.bottomRight,
                              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFF004AAD),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.blue.withOpacity(0.3),width: 1)
                                ),
                                padding: const EdgeInsets.only(bottom: 5,top: 5,left: 5,right: 5),
                                child: Text('All reviews',
                                  textAlign: TextAlign.center,
                                  style:GoogleFonts.firaSans(fontSize: 14,
                                  color: Colors.white,fontWeight: FontWeight.w500,),),
                              )),
                   ),
                      ],
                    ),
                  ) ,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  AnimatedSmoothIndicator buildIndicator() {
    return  AnimatedSmoothIndicator(
      activeIndex: _index,
      count: dataArrayList.length,
      effect: const ScrollingDotsEffect(
        activeStrokeWidth: 2.6,
        activeDotScale: 1.3,
        maxVisibleDots: 5,
        radius: 8,
        strokeWidth: 20,
        spacing: 8,
        dotHeight: 8,
        dotWidth: 8,
        dotColor: Color(0xFFD9D9D9),
        activeDotColor:Color(0xFF004AAD),
      ),
    );
  }

  Future Reviewpopup(context,hotelId){
    return  showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: StatefulBuilder(builder: (context, StateSetter setState) {
            return       Padding(
              padding: const EdgeInsets.only(right: 18.0,left: 18,top: 18,bottom: 18),
              child: Container(
                width: 335,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.blue.withOpacity(0.3),width: 1)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0,left: 10,top: 18,bottom: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height:40,
                        child: Card(
                          elevation: 3,
                          child: TextField(
                            controller: namecont,
                            decoration: InputDecoration(
                                hintText: 'Your Name',
                                hintStyle: TextStyles.hint_text,
                                contentPadding: const EdgeInsets.only(top: 2,left: 10),
                                focusColor: Colors.white,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none
                                )
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height:40,
                        child: Card(
                          elevation: 3,
                          child: TextField(
                            controller: buddyname,
                            decoration: InputDecoration(
                                hintText: 'Your Buddy Name',
                                hintStyle: TextStyles.hint_text,
                                contentPadding: const EdgeInsets.only(top: 2,left: 10),
                                focusColor: Colors.white,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none
                                )
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height:40,
                        child: Card(
                          elevation: 3,
                          child: TextField(
                            controller: email,
                            decoration: InputDecoration(
                                hintText: 'Buddy Email ',
                                hintStyle: TextStyles.hint_text,
                                contentPadding: const EdgeInsets.only(top: 2,left: 10),
                                focusColor: Colors.white,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none
                                )
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height:35,
                          decoration: BoxDecoration(
                            color: const Color(0xFF004AAD),
                            borderRadius: BorderRadius.circular(3),
                          ),

                          child: MaterialButton(
                            minWidth: double.infinity,
                            onPressed: (){
                              setState((){
                                if(_formkey.currentState!.validate()){
                                  _referCont.isLoading.value=true;
                                  _referCont.searchApi(context: context,name: namecont.text.toString(),buddy_name: buddyname.text.toString(),contact:email.text.toString(),
                                      referType: 'hotel',
                                      hotelId: hotelId).then((value) {
                                    namecont.clear();
                                    buddyname.clear();
                                    email.clear();
                                    setState(() {
                                      _referCont.isLoading.value=false;
                                      Navigator.pop(context);
                                    });

                                  });
                                }
                              });
                            },
                            child: Text('Refer Now',style:GoogleFonts.firaSans(fontSize: 20,color: Colors.white,
                                fontWeight: FontWeight.w500,letterSpacing: 1)
                              ,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Future showLocationPopUp(context){
    return  showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: StatefulBuilder(builder: (context, StateSetter setState) {
            return  
               Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                width: 335,
                height: 145,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.blue.withOpacity(0.3),width: 1),
                ),
                child:   Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                          //  color: Colors.amber,
                            child: const Text("Location details will be accessible after completion of the booking process.",textAlign: TextAlign.center,))),
                         Expanded(
                          flex: 1,
                          child: Container(
                            
                            width: double.infinity,
                            child: ElevatedButton(
                              
                              onPressed: (){
                                Navigator.pop(context);
                              },
                               child: Text("Ok",style: TextStyle(color: Colors.black),),
                               style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffeee8f4),
                                elevation: 0,
                                
                                shape: RoundedRectangleBorder(
                                  
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.blue.withOpacity(0.3),width: 1
                                  )
                                  
                                )
                               ),
                               ),
                          ),
                         )
                          
                    ],
                  ),
                
              
            );
          }),
        );
      },
    );
  }

}