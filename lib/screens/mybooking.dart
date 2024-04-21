// ignore_for_file: non_constant_identifier_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:najara_stays/Controller/Cont/hoteldetailApi.dart';
import 'package:najara_stays/Modals/hoteldetailM.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Controller/Cont/cancelBookingApi.dart';
import '../Controller/Cont/homeApi.dart';
import '../Controller/Cont/reviewApi.dart';
import '../Controller/authCont/baseUrl.dart';
import '../Modals/mybookingM.dart';
import '../common/textstyle.dart';


class Mybooking extends StatefulWidget {

  // Mybooking({required this.club_id});

  @override
  State<Mybooking> createState() => MybookingState();
}

class MybookingState extends State<Mybooking> with SingleTickerProviderStateMixin{
  final _cancelCont = Get.put(CancelCont());

  TextEditingController _text =TextEditingController();
  TextEditingController reviewtext =TextEditingController();

  String dateConvert(String date) {
    final format = DateFormat("yyyy-MM-dd");
    DateTime getDate = format.parse(date);
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    final String cDate = formatter.format(getDate);
    return cDate;
  }
  String timeConvert(String time) {
    final format = DateFormat('yyyy-MM-dd HH:mm');
    DateTime getDate = format.parse(time);
    final DateFormat formatter = DateFormat('hh:mm a');
    final String cDate = formatter.format(getDate);
    return cDate;
  }
  TabController? _tabController;
List <MybookingData> upcomingdata=[];
List <MybookingData> Cancelleddata=[];
List <MybookingData> Completeddata=[];
HotelDetailData data = HotelDetailData();

  bool loader=false;
  var _index;


  void initState() {
    super.initState();
    load();
    _tabController = TabController(vsync: this, length: 3);
  }
  @override
  void didChangeDependencies() {
    setState((){
      loader=true;
    });
    super.didChangeDependencies();
  }


  load(){
    HotelApi().Mybooking(type: '1').then((value) {
      setState((){
        upcomingdata=value.data!;
      });

    });
    HotelApi().Mybooking(type: '2').then((value) {
      setState((){
        Cancelleddata=value.data!;
      });
    });
    HotelApi().Mybooking(type: '3').then((value) {
      setState((){
        Completeddata=value.data!;
      });
    });


  

  }
    _launchURL(String id) async {

    HoteldetailApi().hoteldetails(id, context).then((value){
      setState((){
        
        data = value.data!;
          });
       }).then((value) async{
      print( "the google map link is"+data.id.toString());
      if (await canLaunch(data.googleMapLink.toString())) {

      await launch(data.googleMapLink.toString());
     } else {

      Get.snackbar("Something went wrong", "Location is not available for this hotel");
     
     // throw 'Could not launch $Url';

     }
       });

  }




  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading:  const Padding(
          padding: EdgeInsets.only(left: 28.0),
          child: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 25,),
        ),
        centerTitle:true,title: Text("My Bookings",  style: TextStyles.font22Blue500),
      ),
      body:loader==false?const Center(child: CircularProgressIndicator()):
      Column(
        // shrinkWrap: true,
        // physics: BouncingScrollPhysics(),
        children: [
          //const SizedBox(height: 15,),
          // const Divider(
          //   color: Colors.grey,
          // ),
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey))
            ),
            width: double.infinity,
            alignment: Alignment.center,
            height: 40,
            child: TabBar(
              labelColor: Colors.blue,
              controller: _tabController,
              isScrollable: false,
              indicatorWeight: 0.0,
              automaticIndicatorColorAdjustment: true,
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: EdgeInsets.symmetric(horizontal: width*0.05,vertical:0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.0),
              indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.blue,width: 2)
              ),
              tabs: <Widget>[
                Tab(
                  child:Container(
                    height: 30,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 2.0),
                    decoration: const BoxDecoration(
                      // border: Border.all(color: Colors.blue),
                      // borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: const Text('Upcoming',
                        style: TextStyle(fontSize: 18,color:Color(0xFF004AAD),fontWeight: FontWeight.w500,letterSpacing: 0.2),),
                    ),),
                ),
                Tab(
                  child:Container(
                      height: 30,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 2.0),
                      decoration: const BoxDecoration(
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: const Text("Cancelled",
                            style: TextStyle(fontSize: 18,color: Color(0xFF004AAD),
                                fontWeight: FontWeight.w500,letterSpacing: 0.2)),
                      )
                  ),
                ),
                Tab(
                  child:Container(
                      height: 30,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 2.0),
                      decoration: const BoxDecoration(
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: const Text("Completed",
                            style: TextStyle(fontSize: 18,color:Color(0xFF004AAD),fontWeight: FontWeight.w500)),
                      )
                  ),
                ),
              ],
            ),
          ),
          // const Divider(
          //   color: Colors.grey,
          // ),
          // Container(
          //   width: double.infinity,
          //   alignment: Alignment.center,
          //   height: 40,
          //   child: TabBar(
          //     labelColor: Colors.blue,
          //     controller: _tabController,
          //     isScrollable: true,
          //     indicatorWeight: 0.0,
          //     indicatorColor: Colors.blue,
          //     unselectedLabelColor: Colors.white,
          //     indicatorSize: TabBarIndicatorSize.label,
          //     labelPadding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: 0.0),
          //     padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 5.0),
          //     indicator: BoxDecoration(
          //       borderRadius: BorderRadius.circular(3.0),
          //       color: Colors.blue,
          //     ),
          //     tabs: <Widget>[
          //       Tab(
          //         child:Container(
          //           height: 30,
          //           alignment: Alignment.center,
          //           padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
          //           decoration: BoxDecoration(
          //             border: Border.all(color: Colors.blue),
          //             borderRadius: BorderRadius.circular(3.0),
          //           ),
          //           child: Text('Upcoming',
          //             style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w400),),),
          //       ),
          //       Tab(
          //         child:Container(
          //             height: 30,
          //             alignment: Alignment.center,
          //             padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
          //             decoration: BoxDecoration(
          //               border: Border.all(color: Colors.blue),
          //               borderRadius: BorderRadius.circular(3.0),
          //             ),
          //             child: Text("Cancelled",
          //                 style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w400))
          //         ),
          //       ),
          //       Tab(
          //         child:Container(
          //             height: 30,
          //             alignment: Alignment.center,
          //             padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
          //             decoration: BoxDecoration(
          //               border: Border.all(color: Colors.blue),
          //               borderRadius: BorderRadius.circular(3.0),
          //             ),
          //             child: Text("Completed",
          //                 style: TextStyle(fontSize: 14,color:Colors.black,fontWeight: FontWeight.w400))
          //         ),
          //       ),
          //
          //     ],
          //   ),
          //
          // ),
          Flexible(
            flex:1,
            fit: FlexFit.loose,
            child: TabBarView(
              controller: _tabController,
              // physics: BouncingScrollPhysics(),
              children: [
                MyBooking(context,width,height),
                CancelledBooking(context,width),
                CancelledBooking(context,width),
               

              ],
            ),
          )

        ],
      ),
    );
  }
  Widget MyBooking(context,width,height){
    return  Padding(
        padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
        child:
        upcomingdata.isEmpty? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assests/travel.png',height: 200,width: 200,),
              const SizedBox(height: 15,),
              Text("No Booking",style:  GoogleFonts.firaSans(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500,),),
              const SizedBox(height: 5,),
              Text("All your Bookings will show up here.",
                  style: TextStyles.font14B),
              const SizedBox(height: 80,),
            ],
          )
            :
        SizedBox(
          width: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: upcomingdata.length,
               // dragStartBehavior: DragStartBehavior.start,
              scrollDirection: Axis.vertical,
              itemBuilder: (context ,i){
                var data = upcomingdata[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: (){
                      print(data.createdAt);
                      setState(() {
                        showdatails(context,data.bookingId,data.userName,data.checkedInDate,data.checkedoutDate,
                            data.mainImage, data.hotelName,data.email,data.contactNumber,data.checkedInDate,
                            data.checkedoutDate,data.totalGuests,data.totalNoRooms, data.roomName,data.bookingAmount,
                            data.dueAmount,data.address,data.createdAt,data.cancelOn,data.status,null,data.startDate,data.endDate);
                      });

                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        //color: Colors.amber,
                          border: Border.all(color: Colors.blue.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(3)
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                               
                                width: width*0.39,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(3),bottomLeft: Radius.circular(3)),
                                  child:
                                  Image(image:
                                  CachedNetworkImageProvider( Url.Image_URL+data.mainImage.toString(),
                                  // NetworkImage(Url.Image_URL+data.mainImage.toString(),
                                  ),fit: BoxFit.fill,height: 95,),
                                ),
                              ),
                              const SizedBox(width: 6,),
                              Expanded(
                                child: Container(
                                 // color: Colors.amber,
                                  width: double.infinity,
                                  height: 90,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(data.hotelName.toString(),style: TextStyles.font16B,maxLines: 1,softWrap: true,overflow: TextOverflow.ellipsis,),
                                      // SizedBox(height:8,),
                                      Row(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.location_on,color: Colors.black.withOpacity(0.4),size: 15,),
                                          Flexible(child: Text(data.address.toString(),
                                            textScaleFactor: 1,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyles.Ofont13B,)),
                                        ],
                                      ),
                                      // SizedBox(height: 8,),
                                      Text("${data.startDate}-${data.endDate}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyles.Ofont13B,),
                                      // SizedBox(height: 8,),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("ID: ${data.bookingId}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyles.Ofont13B,),
                                          // InkWell(
                                          //   onTap: (){
                                          //     Cancelpopup(data.id.toString());
                                          //   },
                                            // child: Container(
                                            //   margin: const EdgeInsets.only(right: 7),
                                            //   padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 7),
                                            //   decoration: BoxDecoration(
                                            //       color:const Color(0xFF004AAD),
                                            //       borderRadius: BorderRadius.circular(3)
                                            //   ),
                                            //   child:  Text("Cancel",
                                            //       overflow: TextOverflow.ellipsis,
                                            //       maxLines: 3,
                                            //       style: GoogleFonts.firaSans(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w400,)),
                                            // ),
                                          //),
                          
                                        ],
                                      ),
                                      const SizedBox(height: 1,),
                                    ],
                                  ),
                                ),
                              ),
                            
                            ],
                          ),

                          ElevatedButton(
                            onPressed: (){
                               _launchURL(upcomingdata[i].hotelId.toString());
                            },
                             child: Text("Location",style: TextStyle(color: Colors.white),),
                             style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1)
                              )
                             ),
                             )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }

  Widget CancelledBooking(context,width){
    return Padding(
        padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
        child: Cancelleddata.isEmpty? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assests/travel.png',height: 200,width: 200,),
              const SizedBox(height: 15,),
              Text("No Cancelled Booking",style:  GoogleFonts.firaSans(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500,),),
              const SizedBox(height: 5,),
              Text("All your cancelled Bookings will show up here.",
                  style: TextStyles.font14B),
              const SizedBox(height: 80,)
            ],
          ),
        )
            :
        ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: Cancelleddata.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context ,i){
              var data= Cancelleddata[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: InkWell(
                  onTap: (){
                    print(data.createdAt);
                    setState(() {
                      showdatails(context,data.bookingId,data.userName,data.checkedInDate,data.checkedoutDate,data.mainImage,
                          data.hotelName,data.email,data.contactNumber,data.checkedInDate,data.checkedoutDate,data.totalGuests,data.totalNoRooms,
                          data.roomName,data.bookingAmount,data.dueAmount,data.address,data.createdAt,data.cancelOn,
                          data.status,data.checkOutPayment,data.startDate,data.endDate);
                    });

                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                    
                        border: Border.all(color: Colors.blue.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(3)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: width*0.39,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(3),bottomLeft: Radius.circular(3)),
                            child:
                            Image(image:
                            CachedNetworkImageProvider( Url.Image_URL+data.mainImage.toString(),
                              // NetworkImage(Url.Image_URL+data.mainImage.toString(),
                            ),fit: BoxFit.fill,height: 95,),
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.hotelName.toString(),style: TextStyles.font16B,),
                                // SizedBox(height:8,),
                                Row(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on,color: Colors.black.withOpacity(0.4),size: 15,),
                                    Flexible(child: Text(data.address.toString(),
                                      textScaleFactor: 1,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyles.Ofont13B,)),
                                  ],
                                ),
                                // SizedBox(height: 8,),
                                Text("${data.startDate}-${data.endDate}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyles.Ofont13B,),
                                // SizedBox(height: 8,),
                                Text("ID: ${data.bookingId}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyles.Ofont13B,),
                                // Row(
                                //   mainAxisSize: MainAxisSize.max,
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //
                                //     InkWell(
                                //       onTap: (){
                                //         Cancelpopup(data.id.toString());
                                //       },
                                //       child: Container(
                                //         margin: EdgeInsets.only(right: 7),
                                //         padding: EdgeInsets.symmetric(vertical: 3,horizontal: 7),
                                //         decoration: BoxDecoration(
                                //             color:Color(0xFF004AAD),
                                //             borderRadius: BorderRadius.circular(3)
                                //         ),
                                //         child:  Text("Cancel",
                                //             overflow: TextOverflow.ellipsis,
                                //             maxLines: 3,
                                //             style: GoogleFonts.firaSans(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w400,)),
                                //       ),
                                //     ),
                                //
                                //   ],
                                // ),
                                const SizedBox(height: 3,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

  Widget Bookingcopleted(context,width){
    return  Padding(
        padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10
        ),
        child:Completeddata.isEmpty?Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assests/travel.png',height: 200,width: 200,),
              const SizedBox(height: 15,),
              Text("No Booking Complete",style:  GoogleFonts.firaSans(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500,),),
              const SizedBox(height: 5,),
              Text("All your complete Bookings will show up here.",
                  style: TextStyles.font14B),
              const SizedBox(height: 80,)
            ],
          ),
        )
            : ListView.builder(
            shrinkWrap: true,
            itemCount: Completeddata.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context ,i){
              var data= Completeddata[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: InkWell(
                  onTap: (){
                    print(data.createdAt);
                    setState(() {
                      showdatails(context,data.bookingId,data.userName,data.checkedInDate,data.checkedoutDate,
                          data.mainImage, data.hotelName,data.email,data.contactNumber, data.checkedInDate,
                          data.checkedoutDate,data.totalGuests,data.totalNoRooms, data.roomName,data.bookingAmount,
                          data.dueAmount,data.address,data.createdAt,data.cancelOn,data.status.toString(),
                          data.checkOutPayment,data.startDate,data.endDate);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(3)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: width*.39,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(3),bottomLeft: Radius.circular(3)),
                            child: Image(image: NetworkImage(Url.Image_URL+data.mainImage.toString()),fit: BoxFit.fill,
                              height: 95,
                              ),
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Expanded(
                          child: Container(
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(data.hotelName.toString(),style: TextStyles.font16B,),
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          Reviewpopup(context, Completeddata[i].hotelId);
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:const Color(0xFF004AAD),
                                            borderRadius: BorderRadius.circular(2)
                                        ),
                                        margin: const EdgeInsets.only(right: 7),
                                        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                                        child: Text("Review",style:GoogleFonts.firaSans(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(height:8,),
                                Row(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on,color: Colors.black.withOpacity(0.4),size: 15,),
                                    Flexible(child: Text(data.address.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyles.Ofont13B,)),
                                  ],
                                ),
                                // SizedBox(height: 8,),
                                Container(
                                  child: Text("${data.startDate}-${data.endDate}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyles.Ofont13B,),
                                ),
                                // SizedBox(height: 8,),
                                Text("ID: ${data.bookingId}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyles.Ofont13B,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

Future Cancelpopup(bookingId){
    return  showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Reason"),
          content:

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                  border: Border.all(color:const Color(0xFF0188E2),width: 0.6)
              ),
              child: TextFormField(
                controller: _text,
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: 'Enter your reason',
                    hintStyle: TextStyles.Ofont10B,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8,vertical: 7)
                ),
              ),
            ),
          ),
          // TextFormField(
          //     controller: _text,
          //
          //     decoration:InputDecoration(
          //         hintText: 'Enter your reason',
          //         hintStyle: TextStyles.hint_text,
          //         enabledBorder: UnderlineInputBorder(
          //             borderSide: BorderSide(width: 1.5,color: Colors.black.withOpacity(0.2))
          //         )
          //     )
          // ),

          actions: [
             MaterialButton(
              child: new Text("Submit"),
              onPressed: () {
                CancelCont().cancelbookingApi(reason: _text.text.toString(), bookingId: bookingId, context: context);
              },
            ),
          ],
        );
      },
    );;
}

  Future showdatails(context,bookingId,name,startDate,endDate,image,hotelName,email,number, startTime,endTime,guest,room,
      roomType,bookingAmount,dueamount,address,onDate,cancelDate,cancelStatus,paidStatus,bookingstardate,bookingenddate){
    return   showDialog(
        barrierColor: Colors.black.withOpacity(0.8),
        useSafeArea:true ,
        context: context,
        builder: (BuildContext context) {
          return  Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                    color: Colors.white,
                    elevation: 4,
                    child: Column(  crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0,left: 8,right: 8,bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Booking Id",style: TextStyles.font14B500,),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(bookingId,style: TextStyles.Ofont12B,),
                                ],
                              ),
                              // cancelDate==null? Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Container(
                              //       alignment: Alignment.topCenter,
                              //     width: 150,
                              //         child: Text("Booked by $name on  ${dateConvert(onDate)}",style: TextStyles.Ofont12B,)),
                              //     Text("Time : ${timeConvert(onDate)}",style: TextStyles.Ofont12B,),
                              //   ],
                              // ):
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      alignment: Alignment.topCenter,
                                      width: 150,
                                      child: Text("Booked by $name on  ${dateConvert(onDate)}",style: TextStyles.Ofont12B,)),
                                  Text("Time : ${timeConvert(onDate)}",style: TextStyles.Ofont12B,),
              
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,color: Colors.black.withOpacity(0.2),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0,left: 8,right: 8,bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Hotel',style: TextStyles.font14B500,),
                                const SizedBox(height: 4,),
                                Text(hotelName,style: TextStyles.Ofont12B,),
                                const SizedBox(height: 4,),
                                Container(
                                    width: 200,
              
                                    child: Text(address,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.Ofont12B,)),
                              ],
                            ),
                            ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(3),bottomLeft: Radius.circular(3)),
                              child:
                              Container(
                                  height: 50,width: 80,
                                  child: Image(image:
                                  CachedNetworkImageProvider( Url.Image_URL+image.toString(),
                                    // NetworkImage(Url.Image_URL+data.mainImage.toString(),
                                  ),fit: BoxFit.fill,
                                    height: 95,width: 140,)),
                            ),
                          ],),
                        ),
                        Divider(
                          height: 1,color: Colors.black.withOpacity(0.2),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0,left: 8,right: 8,bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Primary Guest',style: TextStyles.Ofont12B,),
                                  const SizedBox(height: 4,),
                                  Text(name,style: TextStyles.font12B500,),
                                  const SizedBox(height: 4,),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Check In Date',style: TextStyles.Ofont12B,),
                                  const SizedBox(height: 4,),
                                  Text(startDate==null?bookingstardate:dateConvert(startDate),
                                    textAlign: TextAlign.center,
                                    style: TextStyles.font12B500,),
                                  const SizedBox(height: 4,),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Check In Time',style: TextStyles.Ofont12B,),
                                  const SizedBox(height: 4,),
                                  Text(startTime==null?"N/A":timeConvert(startTime),
              
                                    textAlign: TextAlign.center,
                                    style: TextStyles.font12B500,),
                                  const SizedBox(height: 4,),
                                ],
                              ),
                            ],),
                        ),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0,left: 8,right: 8,bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Mobile Number',style: TextStyles.Ofont12B,),
                                  const SizedBox(height: 4,),
                                  Text(number,style: TextStyles.font12B500,),
                                  const SizedBox(height: 4,),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Check Out Date',style: TextStyles.Ofont12B,),
                                  const SizedBox(height: 4,),
                                  Text(endDate==null?bookingenddate:dateConvert(endDate),style: TextStyles.font12B500,),
                                  const SizedBox(height: 4,),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Check Out Time',style: TextStyles.Ofont12B,),
                                  const SizedBox(height: 4,),
                                  Text(endTime==null?"N/A":timeConvert(endTime),style: TextStyles.font12B500,),
                                  const SizedBox(height: 4,),
                                ],
                              ),
                            ],),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                        //  color: Colors.amber,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0,left: 8,right: 14,bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Expanded(
                                  child: Container(
                                    //color: Colors.blueAccent,
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Email',
                                      style: TextStyles.Ofont12B,),
                                    const SizedBox(height: 4,),
                                    Container(
                                      width: 140,
                                      child: Text(email,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyles.font12B500,),
                                    ),
                                    const SizedBox(height: 4,),
                                  ],
                                ),
                                  )),
                                Expanded(
                                  child: Container(
                                    //color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                                                          
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Guest',style: TextStyles.Ofont12B,),
                                    const SizedBox(height: 4,),
                                    Text(guest,style: TextStyles.font12B500,),
                                    const SizedBox(height: 4,),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      //color: Colors.amberAccent
                                      
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:5.0),
                                            child: Text('Room : ',style: TextStyles.Ofont12B,),
                                          ),
                                          Text(room,style: TextStyles.font12B500,),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4,),
                                    Text('(${roomType})',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style:GoogleFonts.firaSans(fontSize: 9,color: Colors.black.withOpacity(0.4),fontWeight: FontWeight.w400,)),
                                    const SizedBox(height: 4,),
                                  ],
                                ),
                                      ],
                                    ),
                                  )
                                )
                              ],),
                          ),
                        ),
                        Divider(
                          height: 1,color: Colors.black.withOpacity(0.2),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0,left: 8,right: 8),
                          child: Text("Booking Details",style: TextStyles.font14B500,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0,left: 8,right: 8,bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Booking',style: TextStyles.Ofont12B,),
                                  const SizedBox(height: 4,),
                                  Text(cancelStatus=='1'? 'Booking Confirmed ':cancelStatus=='2'?'Booking Cancelled':cancelStatus=='3'?'Booking Completed':cancelStatus=='4'?'Cancelled Request':cancelStatus=='5'
                                      ?'Cancelled not approved':'N/A',style: GoogleFonts.firaSans(fontSize: 13,color: cancelStatus=='1'? Colors.green:cancelStatus=='3'? Colors.green:Colors.red,fontWeight: FontWeight.w500,),),
                                  const SizedBox(height: 4,),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Payment',style: TextStyles.Ofont12B,),
                                  const SizedBox(height: 4,),
                            
                                  Text(dueamount=="0.00"?"Successful":"Pending",style: GoogleFonts.firaSans(fontSize: 13,color:dueamount=="0.00"? Colors.green:Colors.red,fontWeight: FontWeight.w500,),),
                                  const SizedBox(height: 4,),
                                ],
                              ),
                              Container(width: 10,)
                            ],),
                        ),
                        Divider(
                          height: 1,color: Colors.black.withOpacity(0.2),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0,left: 8,right: 8),
                          child: Text("Payment Details",style: TextStyles.font14B500,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0,left: 8,right: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black.withOpacity(0.5),width: 1)
                            ),
                            child: Row(
              
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Advance Paid',style: TextStyles.font12B500,),
                                Text('₹ ${bookingAmount.toString().split('.').first}',style: TextStyles.font12B500,),
                              ],),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5,left: 8,right: 8,),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black.withOpacity(0.5),width: 1)
                            ),
                            child: Row(
              
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Grand Total',style: TextStyles.font12B500,),
                                Text('₹ ${int.parse(bookingAmount.toString().split('.').first)+int.parse(dueamount.toString().split('.').first)}',
                                  style: TextStyles.font12B500,),
                              ],),
                          ),
                        ),
                      Padding(
                          padding: const EdgeInsets.only(top:5,left: 8,right: 8,bottom: 12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black.withOpacity(0.5),width: 1)
                            ),
                            child: Row(
              
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Payable Amount',style: TextStyles.font12B500,),
                                Text('₹ ${int.parse(dueamount.toString().split('.').first)}',style: TextStyles.font12B500,)
                                // Text('₹ ${int.parse(bookingAmount.toString().split('.').first)+int.parse(dueamount.toString().split('.').first)}',
                                //   style: TextStyles.font12B500,),
                              ],),
                          ),
                        ),
                        
                           Container(
                           padding: EdgeInsets.symmetric(horizontal: 8),
              
                            
                          //  color: Colors.amber,
                          
                            child: Center(
                              child: ElevatedButton(
                                onPressed: (){
                                  Cancelpopup(bookingId);
                                },
                                 child: FittedBox(child: Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 10),
                                   child: Text("Cancel",style: TextStyle(color: Colors.black),),
                                 )),
                                style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(),
                                  borderRadius: BorderRadius.circular(0),
                                  
                                )
                                ),
                                 
                                 
                                 ),
                            ),
                          ),
                        const SizedBox(
                            height: 5,
                          )
                      ],
                    ),
                  ),
            ],
          );
            

          });
  }


  Future Reviewpopup(context,hotelId){
    var _rating='0';
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
            return Container(
              alignment: Alignment.center,
              height: 250,
              width: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 20.0),
                  Text("Rating Bar",textAlign: TextAlign.center,style: TextStyles.font22Blue500),
                  RatingBar.builder(
                    initialRating: double.parse('${_rating}'),
                    minRating: 1,
                    itemSize: 50,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0,vertical: 4),
                    itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber,size: 1,),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating.toString();
                        print(_rating);
                      });

                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                        border: Border.all(color:const Color(0xFF0188E2),width: 0.6)
                      ),
                      child: TextFormField(
                        controller: reviewtext,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Enter your review",
                          hintStyle: TextStyles.Ofont10B,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8,vertical: 7)
                        ),
                      ),
                    ),
                  ),
                   const SizedBox(height: 10.0),
                ],
              ),
            );
          }),
          actions: [
            MaterialButton(
              child: new Text("Submit"),
              onPressed: () {
                ReviewCont().reviewApi(text: reviewtext.text.toString(), rating: _rating, context: context, hotelId: hotelId).then((value) {
                  Navigator.pop(context);
                  reviewtext.clear();
                });

              },
            ),
          ],
        );
      },
    );
  }

}
