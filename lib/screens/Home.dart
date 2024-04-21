

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:najara_stays/Controller/Cont/date_manage.dart';
import 'package:najara_stays/Controller/Cont/homeApi.dart';
import 'package:najara_stays/Controller/Cont/referApi.dart';
import 'package:najara_stays/screens/paymentscreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../Auth/DrawerScreen.dart';
import '../Controller/authCont/baseUrl.dart';
import '../Controller/Cont/searchhotel_Api.dart';
import '../Modals/popularM.dart';
import '../Modals/profileM.dart';
import '../Modals/recentHotelM.dart';
import '../Modals/whatpeopleM.dart';
import '../common/sharepre.dart';
import '../common/textstyle.dart';
import 'hotel_detail.dart';
import 'hotel_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  final _get_user_detail = GetUserDetail();
  YoutubePlayerController? _controller ;
  ScrollController scrollController=ScrollController();
  TextEditingController citycont=TextEditingController();
  TextEditingController namecont=TextEditingController();
  TextEditingController buddyname=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController Homestartdate = TextEditingController();
  TextEditingController Homeenddate = TextEditingController();
  final _searchCont=Get.put(SearchhotelController());
  final _referCont=Get.put(ReferController());
  final _formkey = GlobalKey<FormState>();
  ProfileData _profile=ProfileData();


  List<PopularData> popularHotel = [];
  List<RecentHotelData> newhotels = [];
  List<WhatpeopleData> peopledata = [];

  var items = ["0","1", "2", "3","4","5","6","8","9","10","11","12","13","14","15","16","17","18","19","20","21"];
  var roomtype = ['Deluxe Room', 'Executive Room', 'Suite Room','Family Suite Room',];

  bool loader=true;
  bool referloader=true;
  bool youtubeloder=true;
  var  name;
  var test;
  String? room;
  String dropdownvalue1 = '4';
  String dropdownvalue2 = '1';
  String dropdownvalue3= '0';
  String dropdownvalue4= '0';
   int adult=1;
  int children=0;
  bool isCheckInDatePicked=false;
  bool isCheckOutDatePicked=false;
 
  @override
  void initState() {
    var  today = DateTime.now();
   var cdate = DateFormat("yyyy-MM-dd ").format(today);
   DateTime yesterday = today!.add(const Duration(days: 1));
   var ydate = DateFormat("yyyy-MM-dd ").format(yesterday);

    DateMange.checkIndate= cdate;
    DateMange.chekOutDate=ydate;
   // linkLoad();
    nameloader();
    load();
    super.initState();
    print(DateMange.checkIndate.toString());
  }

  nameloader()async{
    name= await _get_user_detail.getUserData("name");
  }
  load(){
    HotelApi().Myprofile().then((value){
      setState(() {
        _profile=value.data!;
      });
    });
    // HotelApi().popular().then((value){
    //   setState((){
    //     loader=false;
    //     popularHotel=value.data!;
    //   });
    // });
    // HotelApi().RecentHotel().then((value){
    //   setState((){
    //     loader=false;
    //     newhotels=value.data!;
    //   });

    // });
    // HotelApi().Whatpeole().then((value){
    //   setState((){
    //     peopledata=value.data!;
    //   });
    // });
  }
  linkLoad(){
    HotelApi().Youtube().then((value){
      setState(() {
        _controller = YoutubePlayerController(
          initialVideoId: value.toString().split('/').last,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
            loop: true

          ),
        );
        youtubeloder=false;
      });
    });
  }

  

  @override
  Widget build(BuildContext context) {
    double total=(double.parse(dropdownvalue2)+double.parse(dropdownvalue3));
    RxInt totalroom=total.toInt().obs;
    var textscale=MediaQuery.of(context).textScaleFactor;
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: drawerScreen().getDrawer(context,name,_profile.profileImage),
        appBar: AppBar(
          toolbarHeight:40,
          elevation: 0,
          iconTheme: const IconThemeData(color: Color(0xFF004AAD)),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Container(
              height: 45,
              padding: const EdgeInsets.only(top: 3),
              child: Image.asset('assests/najara1.png')),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF004AAD),
                radius: 16,
                  child: IconButton(
                      onPressed: (){
                        launch('tel:+919418979000');
                      }, icon:  const Icon(Icons.phone,color: Colors.white,size: 18,))),
            )
          ],
        ),
        body:Form(
          key: _formkey,
          // child: loader == true ?
          // const Center(child: CircularProgressIndicator()):
      child:    SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 20.0,left: 20),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 29.0,right: 29,),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap:(){
                          Get.to(()=>Hotel(type: '0',hoteltype: '1', ));
                        },
                        child: Text('Hotels',
                          style: TextStyles.font18Blue500,),
                      ),
                      InkWell(
                        onTap:(){
                          Get.to(()=>Hotel(type: '0',hoteltype: '3', ));
                        },
                        child: Text('Homestays',
                          style: TextStyles.font18Blue500,),
                      ),
                      InkWell(
                        onTap:(){
                          Get.to(()=>Hotel(type: '0',hoteltype: '2',));
                        },
                        child: Text('Villas',
                          style: TextStyles.font18Blue500,),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20.0,left: 20),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),

                 Padding(
                  padding: const EdgeInsets.only(left: 29.0,right: 29,),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap:(){
                          Get.to(()=>Hotel(type: '0',hoteltype: '4', ));
                        },
                        child: Text('Cottages',
                          style: smallTextStyle),
                      ),
                      InkWell(
                        onTap:(){
                          Get.to(()=>Hotel(type: '0',hoteltype: '5', ));
                        },
                        child: Text('Camps',
                          style: smallTextStyle),
                      ),
                     
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20,top: 10,),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                     

                     
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.blue.withOpacity(0.3),width: 1)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(top: 10.0,right: 14,left: 14,bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                             Container(
                             // color: Colors.amber,
                          
                              height: 30,
                               child: Text('Let’s Book Your Stay..',style: TextStyles.font18Blue500,)

                                
                            ),
                          const SizedBox(height: 10),
                                    Container(
                            
                                height: 30,
                                child: Row(
                                  children: [
                                  Expanded(
                                      
                                    child: Container(
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                      color: const Color(0xFF004AAD),
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                      child: Center(child: Text("Check In",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                      
                                    )),

                                    Expanded(
                                      flex: 2,
                                      
                                      child: Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: TextFormField(
                                        
                                          textAlign: TextAlign.center,
                                            controller: Homestartdate,
                                            style: TextStyles.font16B,
                                            // validator: (mailvalid) {
                                            //   if (mailvalid!.isEmpty) {
                                            //     return "Please enter date";
                                            //   } else {
                                            //     return null;
                                            //   }
                                            // },
                                            readOnly: true,
                                            onTap: () async {
                                              DateTime? pickedTime = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2101));
                                              if (pickedTime != null) {
                                                String formattedDate =
                                                    DateFormat('yyyy-MM-dd').format(pickedTime);
                                                    setState(() {
                                                      DateMange.checkIndate=formattedDate;
                                                    });
                                              
                                              }
                                            },
                                            decoration: InputDecoration(

                                                hintText: DateMange.checkIndate.toString(),
                                                hintStyle: TextStyles.hint_text,
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: (BorderSide(
                                                      color: Colors.black.withOpacity(0.2),
                                                      width: 2)),
                                                ))),
                                      ),
                                    ),
                                  
                                  
                                  ],
                                ),
                              ),
                          
                          SizedBox(height: 10,),
                           Container(
                             height: 30,
                                child: Row(
                                  children: [
                                  Expanded(
                                      
                                    child: Container(
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                      color: const Color(0xFF004AAD),
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                      child: const Center(child: Text("Check Out",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                      
                                    )),

                                    Expanded(
                                      flex: 2,
                                      
                                      child: Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: TextFormField(
                                        
                                          textAlign: TextAlign.center,
                                            controller: Homeenddate,
                                            style: TextStyles.font16B,
                                            // validator: (mailvalid) {
                                            //   if (mailvalid!.isEmpty) {
                                            //     return "Please enter date";
                                            //   } else {
                                            //     return null;
                                            //   }
                                            // },
                                            readOnly: true,
                                            onTap: () async {
                                              DateTime? pickedTime = await showDatePicker(
                                               // helpText: "Please select",
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2101));
                                              if (pickedTime != null) {
                                                String formattedDate1 =
                                                    DateFormat('yyyy-MM-dd').format(pickedTime);
                                                  setState(() {
                                                      DateMange.chekOutDate=formattedDate1;
                                                  });
                                                       
                                              }
                                            },
                                            decoration: InputDecoration(

                                                hintText: DateMange.chekOutDate.toString(),
                                                hintStyle: TextStyles.hint_text,
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: (BorderSide(
                                                      color: Colors.black.withOpacity(0.2),
                                                      width: 2)),
                                                ))),
                                      ),
                                    ),
                                  
                                  
                                  ],
                                ),
                              ),
                       const SizedBox(height: 10,),
                            

                          SizedBox(
                            width: double.infinity,
                             height: 40,
                            child: Card(
                              elevation: 4,
                              child:   Padding(
                                padding: const EdgeInsets.only(top:0.0,left: 8,right:8),
                                child: TextFormField(
                                  controller: citycont,
                                  style:TextStyles.font14B,
                                  enableInteractiveSelection: false,
                                
                                  validator: (val){
                                    val.toString().isEmpty?"empty":Null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Location / City / Hotel Name',
                                      hintStyle: TextStyles.font14B,
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                      )
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child:
                            Card(
                              shadowColor: Colors.black,
                              elevation: 4,
                              child:    Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: DropdownButtonHideUnderline(
                                    child:  DropdownButton(
                                      hint: Text("Room Categories..",style: TextStyles.font14B ),
                                      iconSize: 1,
                                      icon: const Icon(Icons.keyboard_arrow_down_outlined,color: Colors.white,),
                                      style: TextStyles.font14B,
                                      borderRadius: BorderRadius.circular(10),
                                      value: room,
                                      dropdownColor: Colors.white,focusColor: Colors.white,
                                      items: roomtype.map((String items) {
                                        return DropdownMenuItem(
                                          onTap: (){
                                            setState(() {
                                              test=items=='Deluxe Room'?1:items=='Executive Room'?
                                              2:  items=='Suite Room'?3:items=='Family Suite Room'? 4:0;
                                              room = items;
                                            });
                                          },
                                          enabled: true,
                                          value: items,
                                          child: Text(items,style: TextStyles.font14B),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          test=newValue=='Deluxe Room'?1:newValue=='Executive Room'?
                                          2:  newValue=='Suite Room'?3:newValue=='Family Suite Room'? 4:0;
                                          room = newValue!;
                                        });
                                      },
                                    )),
                              ),
                            ),
                          ),


                          const SizedBox(height: 18),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width*0.39,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Room',
                                      style: TextStyles.font14B500,),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),

                                      //color: Colors.white,
                                      shadowColor: Colors.black,
                                      elevation: 0,
                                      child:    Container(
                                        height: 25,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(width: 1))
                                        ),
                                        padding: const EdgeInsets.only(left: 6,right:5),
                                        child: Center(
                                          child: Obx(() => calculateTotalRoom(totalroom))
                                          ),

                                            
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width*0.39,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex:1,
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Adult',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyles.font14B500,),
                                                Text('(Above 10 Years & below)',
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style:  GoogleFonts.firaSans(fontSize: 9,color: Colors.black.withOpacity(0.9),fontWeight: FontWeight.w400,),),
                                              ],
                                            ),
                                          ),
                                          Card(
                                            shadowColor: Colors.black,
                                            elevation: 4,
                                            child:    Container(
                                              height: 25,
                                              width: 60,
                                              padding: const EdgeInsets.only(left: 6,right:5),
                                              child:DropdownButtonHideUnderline(
                                                  child:  DropdownButton(
                                                    iconSize: 20,
                                                    icon: const Icon(Icons.keyboard_arrow_down_outlined,color: Colors.blue,),
                                                    style: const TextStyle(color: Colors.black),
                                                    borderRadius: BorderRadius.circular(10),
                                                    value: dropdownvalue2,
                                                    dropdownColor: Colors.white,focusColor: Colors.white,
                                                    items: items.map((String items) {
                                                      return DropdownMenuItem(
                                                        enabled: true,
                                                        value: items,
                                                        child: Text(items),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        dropdownvalue2 = newValue!;
                                                       // print(dropdownvalue2);
                                                      });
                                                    },
                                                  )),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width*0.39,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex:1,
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Children',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles.font14B500,),
                                          Text('(3-10 Years)',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style:  GoogleFonts.firaSans(fontSize: 9,color: Colors.black.withOpacity(0.9),fontWeight: FontWeight.w400,),),
                                        ],
                                      ),
                                    ),
                                    Card(
                                      shadowColor: Colors.black,
                                      elevation: 4,
                                      child:    Container(
                                        height: 25,
                                        width: 60,
                                        padding: const EdgeInsets.only(left: 6,right:5),
                                        child:DropdownButtonHideUnderline(
                                            child:  DropdownButton(
                                              iconSize: 20,
                                              icon: const Icon(Icons.keyboard_arrow_down_outlined,color: Colors.blue,),
                                              style: const TextStyle(color: Colors.black),
                                              borderRadius: BorderRadius.circular(10),
                                              value: dropdownvalue3,
                                              dropdownColor: Colors.white,focusColor: Colors.white,
                                              items: items.map((String items) {
                                                return DropdownMenuItem(
                                                  enabled: true,
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownvalue3 = newValue!;
                                                  //print(dropdownvalue3);
                                                });
                                              },
                                            )),),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width*0.39,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Infant',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyles.font14B500,),
                                        Text('(0 -3 Year)',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style:  GoogleFonts.firaSans(fontSize: 9,color: Colors.black.withOpacity(0.9),fontWeight: FontWeight.w400,),),
                                      ],
                                    ),
                                    Card(
                                      shadowColor: Colors.black,
                                      elevation: 4,
                                      child:    Container(
                                        height: 25,
                                        width: 60,
                                        padding: const EdgeInsets.only(left: 6,right:5),
                                        child:DropdownButtonHideUnderline(
                                            child:  DropdownButton(
                                              iconSize: 20,
                                              icon: const Icon(Icons.keyboard_arrow_down_outlined,color: Colors.blue,),
                                              style: const TextStyle(color: Colors.black),
                                              borderRadius: BorderRadius.circular(10),
                                              elevation: 4,
                                              value: dropdownvalue4,
                                              dropdownColor: Colors.white,focusColor: Colors.white,
                                              items: items.map((String items) {
                                                return DropdownMenuItem(
                                                  enabled: true,
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownvalue4 = newValue!;
                                                  print(dropdownvalue4);
                                                });
                                              },
                                            )),),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _searchCont.isLoading.value==true?const Center(child: CircularProgressIndicator()):
                          Material(
                            color: const Color(0xFF004AAD),
                            elevation: 5,
                            borderRadius: BorderRadius.circular(6),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              onPressed: (){
                                setState(() {
                                 // _formkey.currentState!.validate()
                                  if(citycont.text.isNotEmpty){
                                    _searchCont.isLoading.value=true;
                                    _searchCont.searchApi(query:citycont.text.toString(), room_type:room==null?'0':test.toString(),
                                        //total_no_adults: dropdownvalue2.toString(),
                                        total_no_adults: 1.toString(),
                                       //  total_no_children: dropdownvalue3.toString(),
                                         total_no_children: 1.toString(),
                                        context: context,
                                         //total_no_rooms: calculateTotalRoomValue(totalroom),
                                         total_no_rooms: 1.toString(),
                                        start_date: isCheckInDatePicked==true?DateMange.checkIndate:"",
                                        end_date: isCheckOutDatePicked==true?DateMange.chekOutDate:""
                                        
                                        
                                        
                                        ).then((value){
                                      setState(() {
                                        _searchCont.isLoading.value=false;
                                        citycont.clear();

                                      });
                                    });
                                  }else{
                                    CommonToast(context: context, title: "Please enter the city name", alignCenter: false);
                                  }
                                });
                              },
                              child: Text('Apply',style:GoogleFonts.firaSans(fontSize: 18,color: Colors.white,
                                  fontWeight: FontWeight.w500,letterSpacing: 1)
                                ,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                  
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 20,bottom: 15),
                  child: Text('Top Destinations',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font18Blue500,),
                ),
  
  

                  SizedBox(
                      height: 100,
                      child: ListView.builder(
                          padding: const EdgeInsets.only(left: 24),
                          itemCount:popularHotel.length,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemExtent: 140,
                          itemBuilder: (context ,i){
                            var data= popularHotel[i];
                            return Padding(
                              padding: const EdgeInsets.only(right: 28),
                              child: GestureDetector(
                              
                      onTap: () {
                   //  _searchCont.isLoading.value=true;
                    _searchCont.searchApi(
                      query:data.name.toString(),
                       room_type:room==null?'0':test.toString(),
                        total_no_adults: dropdownvalue2.toString(),
                        total_no_children: dropdownvalue3.toString(),
                        context: context,
                        total_no_rooms: calculateTotalRoomValue(totalroom),
                        start_date: isCheckInDatePicked==true?DateMange.checkIndate:"",
                        end_date: isCheckOutDatePicked==true?DateMange.chekOutDate:""
                        
                        
                        
                        ).then((value){
                      setState(() {
                       // _searchCont.isLoading.value=false;
                        citycont.clear();

                      });
                    });
                  
                                },
                                child: Card(
                                  elevation: 3,
                                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: const BorderSide(color: Colors.transparent)),
                                  child: Column(
                                    children: [
                                      Flexible(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                          child: Image(image:
                                          CachedNetworkImageProvider(Url.Image_URL+data.path.toString(),
                                            // NetworkImage(Url.Image_URL+data.path.toString()
                                          ),fit: BoxFit.fill,
                                              errorBuilder: (context, error, stackTrace) => const Center(child: CircularProgressIndicator()),
                                              width:130),
                                        ),
                                      ),
                                      Padding(
                                        padding:  const EdgeInsets.only(top: 5.0,bottom: 6),
                                        child: SizedBox(
                                            child: Text(data.name.toString(),style: TextStyles.font12B,)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                

                newhotels.isEmpty?Container():
                Padding(
                  padding: const EdgeInsets.only(right: 20.0,left: 20,top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Top Hotels',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.font18Blue500,),
                      InkWell(
                        onTap: (){
                          Get.to(()=>Hotel(type: '0',hoteltype: '1',));
                        },
                        child: Text('view more',
                          style: TextStyles.font13B,),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                newhotels.isEmpty?Container():
                SizedBox(
                    height: height*0.31,
                    child: ListView.builder(
                        padding: const EdgeInsets.only(left: 24),
                        itemCount: newhotels.length,
                        scrollDirection: Axis.horizontal,
                        itemExtent: 170,
                        itemBuilder: (context ,i){
                          var data= newhotels[i];
                          return Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: InkWell(
                              onTap: (){
                                Get.to(()=>HotelDetails(id:data.id.toString()));
                                print('Recently-----${data.id}');
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        Image(image: CachedNetworkImageProvider(Url.Image_URL+data.mainImage.toString()),
                                          fit: BoxFit.fill,height: 170),
                                        Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(5.0),
                                              padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 2),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  borderRadius: BorderRadius.circular(4)
                                              ),
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 3,),
                                                  const Icon(Icons.location_on,color: Colors.white,size: 18,),
                                                  Text('${ data.city}',style: GoogleFonts.firaSans(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w400,),),
                                                  const SizedBox(width: 3,),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  RatingBar.builder(
                                    initialRating: double.parse('${data.rating}'),
                                    minRating: 1,
                                    itemSize: 10,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0,vertical: 4),
                                    itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber,size: 1,),
                                    onRatingUpdate: (rating) {
                                      print('rating');
                                    },
                                  ),
                                  Text('₹ ${data.offerPrice.toString()}',style: TextStyles.Ofont14B,),
                                  const SizedBox(height: 3,),
                                  Text(data.hotelName.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles.font14B,),
                                ],
                              ),
                            ),
                          );
                        })),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0,left: 21,top: 20),
                  child: Text('Najara Stays is the best, Why? here is:',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font18Blue500,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18,top: 15,right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex:1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                    backgroundColor:Colors.white,
                                    radius: 14,
                                    child:Image.asset('assests/location_icon.png',scale: 3.8,)
                                ),
                                const SizedBox(width: 2,),
                                Text('Better Locations',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.font13B
                                  ,)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                    backgroundColor:Colors.white,
                                    radius: 14,
                                    child: Image.asset('assests/discount_icon.png',scale:  3.8,)
                                ),
                                const SizedBox(width: 2,),
                                Text('Better Prices',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.font13B,)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // CircleAvatar(
                                //     backgroundColor:Colors.white,
                                //     radius: 14,
                                //     child: Image.asset('assests/cancellation_con .png',scale:  3.8,)
                                // ),
                                //Icon(Icon(icon)),
                                Icon(Icons.dining_rounded,color: Color(0xffffb91a),),
                                const SizedBox(width: 2,),
                                Column(crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text('Complementary Breakfast',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyles.font13B,),
                                    ),
                                    // Text('T&C*',
                                    //     style:GoogleFonts.firaSans(fontSize: 8,color: Colors.black,fontWeight: FontWeight.w400,)),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                  backgroundColor:Colors.white,
                                  radius: 14,
                                  child:Image.asset('assests/hotel_icon.png',scale:  3.9,)
                              ),
                              const SizedBox(width: 2,),
                              Text('Clean Rooms',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.font13B,)
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                  backgroundColor:Colors.white,
                                  radius: 14,
                                  child: Image.asset('assests/agenticon.png',scale:  3.9,)
                              ),
                              const SizedBox(width: 2,),
                              Text('Repeat Customers',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.font13B,)
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 14,
                                  child: Image.asset('assests/privacy_icon.png',scale: 3.8,)
                              ),
                              const SizedBox(width: 2,),
                              Text('Privacy/Security',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.font13B,),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0,left: 20,top: 20),
                  child: Text('Let’s Refer & Earn..',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.font18Blue500,),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0,left: 20,top: 15),
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.blue.withOpacity(0.3),width: 1)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0,left: 18,top: 15,bottom: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height:40,
                            child: Card(
                              elevation: 3,
                              child: TextField(
                                controller: namecont,
                                style:TextStyles.font14B,
                                decoration: InputDecoration(
                                    hintText: 'Your Name..',
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
                                style:TextStyles.font14B,
                                decoration: InputDecoration(
                                    hintText: 'Your Buddy Name..',
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
                                controller: number,
                                style:TextStyles.font14B,
                                decoration: InputDecoration(
                                    hintText: 'Buddy Email.. ',
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
                          _referCont.isLoading.value==true?const Center(child: CircularProgressIndicator()):   Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Material(
                              color: const Color(0xFF004AAD),
                              elevation: 5,
                              borderRadius: BorderRadius.circular(6),
                              child: MaterialButton(
                                minWidth: double.infinity,
                                onPressed: (){
                                  setState((){
                                    if(_formkey.currentState!.validate()){
                                      _referCont.isLoading.value=true;
                                      _referCont.searchApi(context: context,name: namecont.text.toString(),buddy_name: buddyname.text.toString(),contact:number.text.toString(), referType: 'direct',
                                          hotelId: '').then((value) {
                                        namecont.clear();
                                        buddyname.clear();
                                        number.clear();
                                        setState(() {
                                          _referCont.isLoading.value=false;
                                        });

                                      });
                                    }
                                  });
                                },
                                child: Text('Refer Now',style:GoogleFonts.firaSans(fontSize: 18,color: Colors.white,
                                    fontWeight: FontWeight.w500,letterSpacing: 1)
                                  ,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                youtubeloder==true?Container():
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 15),
                  child: Text('Our Vlogs',
                    style: TextStyles.font18Blue500,),
                ),
                youtubeloder==true?Container(height: 0):
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                  ),
                ),
                peopledata.isEmpty ? Container(height: 0):
                Padding(
                  padding: const EdgeInsets.only(right: 20.0,left: 20,top:8),
                  child: Text("What People's Say",
                    style: TextStyles.font18Blue500,),
                ),
                peopledata.isEmpty ? Container(height: 0):
                const SizedBox(height: 18),
                peopledata.isEmpty ? Container(height: 0):
                SizedBox(
                    height: height*0.23,

                    child: ListView.builder(
                        padding: const EdgeInsets.only(left: 24),
                        itemCount: peopledata.length,
                        scrollDirection: Axis.horizontal,
                        itemExtent: 120,
                        itemBuilder: (context ,i){
                          var data= peopledata[i];
                          return Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                data.image==null?Container(
                                  decoration : BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: Colors.blueGrey,
                                  ),
                                  child:  const Icon(Icons.person,size: 80,color: Colors.grey,),
                                ):
                                CircleAvatar(
                                  backgroundImage:NetworkImage(Url.Image_URL+data.image.toString()),
                                  backgroundColor: Colors.white,
                                 //  child: Image(image: AssetImage('assests/img.png'),fit: BoxFit.fill,height: 200,),
                                  radius: 45,
                                ),
                                const SizedBox(height: 5,),
                                Text(data.userName.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.font14B,),
                                const SizedBox(height: 3,),
                                Text(data.description.toString(),
                                  maxLines: 3,textAlign:TextAlign.start,
                                  textScaleFactor: 1,

                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.Ofont13B,),
                              ],
                            ),
                          );
                        })),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Text calculateTotalRoom(RxInt totalroom){
    
    if (totalroom<3) {
      dropdownvalue1=1.toString();
      return Text("1",style: TextStyle(fontWeight: FontWeight.bold),);
    }else if(totalroom%3==0){
      dropdownvalue1=(totalroom/3).toInt().toString();
      return Text((totalroom/3).toInt().toString());
    }else{
      dropdownvalue1=((totalroom/3)+1).toInt().toString();
      return Text(((totalroom/3)+1).toInt().toString());
    }

  }

    String calculateTotalRoomValue(RxInt totalroom){
    
    if (totalroom<3) {
      dropdownvalue1=1.toString();
      return "1";
    }else if(totalroom%3==0){
      dropdownvalue1=(totalroom/3).toInt().toString();
  
     return (totalroom/3).toInt().toString();
    }else{
      dropdownvalue1=((totalroom/3)+1).toInt().toString();

      return ((totalroom/3)+1).toInt().toString();
    }

  }

}