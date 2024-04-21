


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import 'package:najara_stays/screens/hotel_detail.dart';
import '../Controller/Cont/homeApi.dart';
import '../Modals/homeTophotelM.dart';
import '../common/textstyle.dart';
import 'bottomscreen.dart';
import 'hotel_list.dart';
import 'package:google_fonts/google_fonts.dart';


class TopHotel extends StatefulWidget {
  const TopHotel({Key? key,}) : super(key: key);
  @override
  State<TopHotel> createState() => TopHotelState();
}

class TopHotelState extends State<TopHotel>  with SingleTickerProviderStateMixin{

 List<HomeTophotelData> hoteldata = [];
 List<HomeTophotelData> villadata = [];
 List<HomeTophotelData> home_staydata = [];
 TabController? _tabController;
 bool loader=true;
 var type;
 int price = 0;
 double rating = 3;
 var value;
 bool selected=false;

  @override
  void initState() {
    load();
    _tabController = TabController(vsync: this, length: 3);
    type=_tabController!.index;
    super.initState();
  }

load(){
 HotelApi().Tophotelapi(type:'1',hotelType:'1').then((value){
    setState((){
      loader=false;
      hoteldata=value.data!;
    });

  });
 HotelApi().Tophotelapi(type:'1',hotelType:'2').then((value){
    setState((){
      loader=false;
      villadata=value.data!;
    });

  });
 HotelApi().Tophotelapi(type:'1',hotelType:'3').then((value){
    setState((){
      loader=false;
      home_staydata=value.data!;
    });
  });
  loader=false;
}


  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    setState(() {
      type=_tabController!.index;
    });
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (_)=>const Bottom()));
              // Get.to(()=>Bottom());
            },
            icon: const Icon(Icons.arrow_back_sharp,color: Colors.black,),
          ),
          centerTitle: true,
          title: Text(type=='3'?'Top Home Stays':type=='2'?'Top Villa':'Top Lodges',style: TextStyles.font22Blue500,
          ),
          //     actions: [
          //   IconButton(onPressed: (){
          //    Get.to(()=>Filter(hoteltype: widget.hoteltype, type: widget.type,));
          //   }, icon:Image.asset('assests/setting.png',scale: 4),
          //     color: Colors.black,)
          // ],

          
        ),
        body: loader==true?const Center(child: CircularProgressIndicator()):
        Container(
        
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 1,color: Colors.grey))
          ),
          child: Column(
            children: [
              // const Divider(
              //   color: Colors.grey,
              // ),
              Container(
               // color: Colors.red,
                width: double.infinity,
                alignment: Alignment.center,
                height: 35,
                child: TabBar(
                  
                  labelColor: Colors.blue,
                  controller: _tabController,
                  isScrollable: false,
                  indicatorWeight: 0.0,
                  automaticIndicatorColorAdjustment: true,
                  indicatorColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                 // labelPadding: EdgeInsets.symmetric(horizontal: width*0.002,vertical: 0.0),
                 // padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 2.0),
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(color: Colors.black,width: 1)
                  ),
                  tabs: <Widget>[
                    Tab(
                      child:Container(
                        height: 30,
                        alignment: Alignment.center,
                        //padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 5.0),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: const Text('Hotels',
                            style: TextStyle(fontSize: 18,color: Color(0xFF004AAD),fontWeight: FontWeight.w500,)),
                        ),),
                    ),

                    Tab(
                      child:Container(
                          height: 30,
                          alignment: Alignment.center,
                        //  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 5.0),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: const Text("Homestays",
                                style: TextStyle(fontSize: 18,color: Color(0xFF004AAD),fontWeight: FontWeight.w500,)),
                          )
                      ),
                    ),
                    Tab(
                      child:Container(
                          height: 30,
                          alignment: Alignment.center,
                        //  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 5.0),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: const Text("Villas",
                                style: TextStyle(fontSize: 18,color: Color(0xFF004AAD),fontWeight: FontWeight.w500,)),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              // const Divider(
              //   color: Colors.grey,
              // ),
              Container(
                height: 30,
               // color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 42),
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
              ),

              //        const Divider(
              //   color: Colors.grey,
              // ), 
                // Container(
                //   height: 10,
                //   width: double.infinity,
                //   color: Colors.black,
                // ),
              Flexible(
                flex:1,
                fit: FlexFit.loose,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Hotel1(context,width,height),
                    Home_stay(context,width,height),
                    Villa(context,width,height),
                  ],
                ),
              ),
 

            ],
          )
        )
    );
  }
 Widget Hotel1(context,width,height){
   return SizedBox(
     height: 100,
     child:hoteldata.isEmpty?
     Center(child: Text('No Data Found',style: TextStyles.font16B)):  ListView.builder(
         shrinkWrap: true,
         padding: const EdgeInsets.only(left: 15,right: 15,top: 0),
         itemCount: hoteldata.length,
         scrollDirection: Axis.vertical,
         physics: const ScrollPhysics(),
         itemBuilder: (context ,i){
           var data= hoteldata[i];
           return Padding(
             padding: const EdgeInsets.only(bottom: 15),
             child: InkWell(
               onTap: (){
                 Get.to(()=>HotelDetails(id: data.id.toString()));
               },
               child: Container(
                 width:double.infinity,
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
                         child: Image(image:
                         CachedNetworkImageProvider( Url.Image_URL+data.mainImage.toString(),
                           // NetworkImage(Url.Image_URL+data.mainImage.toString()
                         ),
                           fit: BoxFit.fill,height: 120,),
                       ),
                     ),
                     const SizedBox(width: 8,),
                     Container(
                       width: width*0.46,
                       padding: const EdgeInsets.only(top: 5,bottom: 2),
                       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         mainAxisSize: MainAxisSize.max,
                         children: [
                           Text(data.hotelName.toString(),style: TextStyles.font16B,),
                            data.rating==null?Container():Row(
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.only(left:3.0),
                                     child: const Text("★",style: TextStyle(color: Colors.green),textScaleFactor: 1,),
                                   ),
                                   Text(data.rating.toString(),style: TextStyles.Ofont14B,),
                                 ],
                               ),

                          // Text(data.offerPrice == null ? "" : "₹ ${data.offerPrice}",style:GoogleFonts.firaSans(fontSize: 13,color: const Color(0xFF0188E2),fontWeight: FontWeight.w500,),),
                           Row(
                             mainAxisAlignment:MainAxisAlignment.spaceBetween,mainAxisSize: MainAxisSize.max,
                             children: [
                               Row(
                                 children: [
                                   Icon(Icons.location_on,color: Colors.black.withOpacity(0.4),size: 18,),
                                   Text('${ data.city}',style: TextStyles.Ofont14B,),
                                 ],
                               ),
                               // Spacer(),
                              Text(data.offerPrice == null ? "" : "₹ ${data.offerPrice}",style:GoogleFonts.firaSans(fontSize: 13,color: const Color(0xFF0188E2),fontWeight: FontWeight.w500,),),

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
         }),
   );
 }
 Widget Villa(context,width,height){
   return  SizedBox(
     height: 100,
     child: villadata.isEmpty?
     Center(child: Text('No Data Found',style: TextStyles.font16B)):  ListView.builder(
         shrinkWrap: true,
         padding: const EdgeInsets.only(left: 15,right: 15,top: 0),
         itemCount: villadata.length,
         scrollDirection: Axis.vertical,
         physics: const ScrollPhysics(),
         itemBuilder: (context ,i){
           var data= villadata[i];
           return Padding(
             padding: const EdgeInsets.only(bottom: 15),
             child: InkWell(
               onTap: (){
                 Get.to(()=>HotelDetails(id: data.id.toString()));
               },
               child: Container(
                 width:double.infinity,
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
                         child: Image(image:
                         CachedNetworkImageProvider( Url.Image_URL+data.mainImage.toString(),
                           // NetworkImage(Url.Image_URL+data.mainImage.toString()
                         ),
                           fit: BoxFit.cover,height: 120,),
                       ),
                     ),
                     const SizedBox(width: 8,),
                     Container(
                       width: width*0.45,
                       padding: const EdgeInsets.only(top: 5,bottom: 2),
                       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         mainAxisSize: MainAxisSize.max,
                         children: [
                           Text(data.hotelName.toString(),style: TextStyles.font16B,),
                            data.rating==null?Container():Row(
                                 children: [
                                   const Text("★",style: TextStyle(color: Colors.green),textScaleFactor: 1,),
                                   Text(data.rating.toString(),style: TextStyles.Ofont14B,),
                                 ],
                               ),
                          // Text(data.offerPrice == null ? "" : "₹ ${data.offerPrice}",style:GoogleFonts.firaSans(fontSize: 13,color: const Color(0xFF0188E2),fontWeight: FontWeight.w500,),),
                           Row(
                             mainAxisAlignment:MainAxisAlignment.spaceBetween,mainAxisSize: MainAxisSize.max,
                             children: [
                               Row(
                                 children: [
                                   Icon(Icons.location_on,color: Colors.black.withOpacity(0.4),size: 18,),
                                   Text('${ data.city}',style: TextStyles.Ofont14B,),
                                 ],
                               ),
                               // Spacer(),
                          Text(data.offerPrice == null ? "" : "₹ ${data.offerPrice}",style:GoogleFonts.firaSans(fontSize: 13,color: const Color(0xFF0188E2),fontWeight: FontWeight.w500,),),


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
         }),
   );
 }
 Widget Home_stay(context,width,height){
   return  SizedBox(
     height: 100,
     child:  home_staydata.isEmpty?
     Center(child: Text('No Data Found',style: TextStyles.font16B)): ListView.builder(
         shrinkWrap: true,
         padding: const EdgeInsets.only(left: 15,right: 15,top: 0),
         itemCount: home_staydata.length,
         scrollDirection: Axis.vertical,
         physics: const ScrollPhysics(),
         itemBuilder: (context ,i){
           var data= home_staydata[i];
           return Padding(
             padding: const EdgeInsets.only(bottom: 15),
             child: InkWell(
               onTap: (){
                 Get.to(()=>HotelDetails(id: data.id.toString()));
               },
               child: Container(
                 width:double.infinity,
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
                         child: Image(image:
                         CachedNetworkImageProvider( Url.Image_URL+data.mainImage.toString(),
                           // NetworkImage(Url.Image_URL+data.mainImage.toString()
                         ),
                           fit: BoxFit.cover,height: 120,),
                       ),
                     ),
                     const SizedBox(width: 8,),
                     Container(
                       width: width*0.45,
                       padding: const EdgeInsets.only(top: 5,bottom: 2),
                       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         mainAxisSize: MainAxisSize.max,
                         children: [
                          
                           Text(data.hotelName.toString(),style: TextStyles.font16B,),
                            data.rating==null?Container():Row(
                                 children: [
                                   const Text("★",style: TextStyle(color: Colors.green),textScaleFactor: 1,),
                                   Text(data.rating.toString(),style: TextStyles.Ofont14B,),
                                 ],
                               ),
                          // Text(data.offerPrice == null ? "" : "₹ ${data.offerPrice}",style:GoogleFonts.firaSans(fontSize: 13,color: const Color(0xFF0188E2),fontWeight: FontWeight.w500,),),
                           Row(
                             mainAxisAlignment:MainAxisAlignment.spaceBetween,mainAxisSize: MainAxisSize.max,
                             children: [
                               Row(
                                 children: [
                                   Icon(Icons.location_on,color: Colors.black.withOpacity(0.4),size: 18,),
                                   Text('${ data.city}',style: TextStyles.Ofont14B,),
                                 ],
                               ),
                               // Spacer(),
                           Text(data.offerPrice == null ? "" : "₹ ${data.offerPrice}",style:GoogleFonts.firaSans(fontSize: 13,color: const Color(0xFF0188E2),fontWeight: FontWeight.w500,),),


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
         }),
   );
 }



}

