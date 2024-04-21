

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:najara_stays/screens/hotel_detail.dart';

import '../Controller/Cont/fliterApi.dart';
import '../Controller/Cont/homeApi.dart';
import '../Controller/Cont/searchhotel_Api.dart';
import '../Controller/authCont/baseUrl.dart';
import '../Modals/searchcityM.dart';
import '../common/textstyle.dart';

class Filter extends StatefulWidget {
 String hoteltype;
 String type;
   Filter({Key? key,required this.hoteltype,required this.type,}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<SearchcityData> getCitySearch=[];
  List<SearchcityData> getCityListAdd=[];
var id;
  @override
  void initState() {
    print('---------hoteltype------------${widget.hoteltype}');
    Load();
    super.initState();
  }


  Load(){
    HotelApi().Searchcity(id:'',).then((value){
      setState((){
        getCityListAdd = getCitySearch =value.data!;
      });
    });
  }

  final fliter = Get.put(FiterController());
  TextEditingController searchBank=TextEditingController();
  TextEditingController city=TextEditingController();

  double start=250.0;
  double end = 10000.0;
  String? rating='';
  String value = '1';
  bool rating1=false;
  bool selected1=false;
  bool selected2=false;
  bool selected3=false;
  bool selected4=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Filter',style: TextStyles.font22Blue500,),
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon:
                Icon(Icons.close,color: Colors.black,))
              ],),
            countryListField(context),
            SizedBox(height: 20,),

            Text('Price',style: TextStyles.font16B,),
            SizedBox(height: 10,),
            Container(
              height: 20,
              child: RangeSlider(
                values: RangeValues(start, end),
                labels: RangeLabels(start.toString(), end.toString()),
                min: 250,
                max: 10000,
                activeColor: Color(0xFF004AAD),
                onChanged: (value) {
                  setState(() {
                    start = value.start;
                    end = value.end;
                  });
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(3)
                      ),
                      padding: const EdgeInsets.only(left: 5,right: 5),
                      child: Text('₹ ${num.parse(start.toStringAsFixed(0))}',style: TextStyles.font12B,)),
                  Container(
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(3)
                      ),
                      padding: const EdgeInsets.only(left: 5,right: 5),
                      child: Text('₹ ${num.parse(end.toStringAsFixed(0))}',style: TextStyles.font12B,)),
                ],),
            ),
            SizedBox(height: 20,),
            Text('Rating',style: TextStyles.font16B,),
            SizedBox(height: 10,),
            Container(
              height: 35,
              child: Row(
                children: [
                  Radio(
                      fillColor:
                      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        return (rating1) ? Colors.white : Color(0xFF52C1FF);
                      }),
                      value: '1',
                      groupValue: rating,
                      onChanged: (val){
                        setState((){
                          rating=val;
                          print(rating);
                        });

                      }),
                  Text('Above 1.0 rating',style: TextStyles.font12B,)
                ],
              ),
            ),
            Container(
              height: 35,
              child: Row(
                children: [
                  Radio(
                      fillColor:
                      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        return (rating1) ? Colors.white : Color(0xFF52C1FF);
                      }),
                      value: '2',
                      groupValue: rating,
                      onChanged: (val){
                        setState((){
                          rating=val;
                          print(rating);
                        });

                      }),
                  Text('Above 2.0 rating',style: TextStyles.font12B,)
                ],
              ),
            ),
            Container(
              height: 35,
              child: Row(
                children: [
                  Radio(
                      fillColor:
                      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        return (rating1) ? Colors.white : Color(0xFF52C1FF);
                      }),
                      value: '3',
                      groupValue: rating,
                      onChanged: (val){
                        setState((){
                          rating=val;
                          print(rating);
                        });
                      }),
                  Text('Above 3.0 rating',style: TextStyles.font12B,)
                ],
              ),
            ),
            Container(
              height: 35,
              child: Row(
                children: [
                  Radio(
                      fillColor:
                      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        return (rating1) ? Colors.white : Color(0xFF52C1FF);
                      }),
                      value: '4',
                      groupValue: rating,
                      onChanged: (val){
                        setState((){
                          rating=val;
                          print(rating);
                        });

                      }),
                  Text('Above 4.0 rating',style: TextStyles.font12B,)
                ],
              ),
            ),
            SizedBox(height: 30,),
          fliter.isLoading.value==true?Center(child: CircularProgressIndicator()): InkWell(
              onTap: (){
                setState(() {
                  fliter.isLoading.value=true;
                  fliter.filterApi(city:id==null?'':id.toString(),roomtype: '',minprice: num.parse(start.toStringAsFixed(0)).toString(),
                      maxprice: num.parse(end.toStringAsFixed(0)).toString(),rating: rating.toString(),context: context,  hoteltype: widget.hoteltype,
                      type:widget.type ).then((value) {
                        setState(() {
                          fliter.isLoading.value=false;
                        });
                  });
                });

              },
              child: Container(
                height: 50,
                padding: EdgeInsets.only(right:6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFF004AAD)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 50,),
                    Container(
                      child: Text('Done',style:TextStyles.font22W),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue.shade700,
                      child: Icon(Icons.arrow_forward_outlined,color: Colors.white,),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
  Widget countryListField(context){
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
          onTap: (){
            showDialog(
              context: context,
              barrierDismissible:false,
              builder: (BuildContext context) {
                return StatefulBuilder(
                    builder: (context, setState){
                      return Dialog(
                          backgroundColor:Colors.white ,
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          elevation: 16,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Spacer(),
                                  InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 10.0,top: 5.0),
                                      child: Icon(Icons.clear,color: Colors.black,size: 24,),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin : const EdgeInsets.only(right: 10.0,left: 10.0,bottom: 5.0,top: 5.0),
                                child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        getCitySearch = getCityListAdd
                                            .where((name) => name.name!
                                            .toLowerCase()
                                            .contains(value.toLowerCase()))
                                            .toList();
                                        city.text=value;
                                      });
                                    },
                                    keyboardType: TextInputType.text,
                                    controller: searchBank,
                                    decoration: InputDecoration(
                                      hintText: "Search location / city",
                                       hintStyle: TextStyles.hint_text,
                                        )
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount: getCitySearch.isEmpty ? 0 : getCitySearch.length,
                                    itemBuilder: (context, index) {
                                      var data =getCitySearch[index];
                                      return ListTile(
                                        onTap: (){
                                          setState((){
                                            city.text=data.name.toString();
                                            id=data.id.toString();
                                            Navigator.pop(context);
                                          });
                                        },
                                        title: Text('${data.name}'),
                                      );
                                    }),
                              )
                            ],
                          )
                      );
                    }
                );
              },
            );
          },
          readOnly: true,
          controller: city,
          decoration:InputDecoration(
              suffixIcon: InkWell(
                  onTap: (){
                    setState(() {
                      city.clear();
                      id='';
                    });
                  },
                  child: Icon(Icons.close)),
              hintText: 'Search location / city',
              hintStyle: TextStyles.hint_text,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1.5,color: Colors.black.withOpacity(0.2))
              )
          )
      ),
    );
  }
}












// class Filterlist extends StatefulWidget {
//   String hoteltype;
//    Filterlist({Key? key,required this.hoteltype}) : super(key: key);
//
//   @override
//   State<Filterlist> createState() => _FilterlistState();
// }

// class _FilterlistState extends State<Filterlist> {
//   final fliter=Get.put(FiterController());
//   @override
//   Widget build(BuildContext context) {
//     var width= MediaQuery.of(context).size.width;
//     var height= MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: (){
//            Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_sharp,color: Colors.black,),
//         ),
//         centerTitle: true,
//         title: Text(widget.hoteltype=='3'?'Home Stays':widget.hoteltype=='2'?'Villa':'HOTELS',style: TextStyles.font22B,
//         ),
//       ),
//       body:SingleChildScrollView (
//       child:  ListView.builder(
//           shrinkWrap: true,
//           padding: const EdgeInsets.only(left: 20,right: 15,top: 20),
//           itemCount: fliter.filterlist.length,
//           scrollDirection: Axis.vertical,
//           physics: ScrollPhysics(),
//           itemBuilder: (context ,i){
//             var data= fliter.filterlist[i];
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 15),
//               child: InkWell(
//                 onTap: (){
//                   setState(() {
//                     Get.to(()=>HotelDetails(id: data.hotelId.toString()));
//                   });
//
//                 },
//                 child: Container(
//                   width:double.infinity,
//                   height: 100,
//                   decoration: BoxDecoration(
//                       border: Border.all(color: Colors.blue.withOpacity(0.4)),
//                       borderRadius: BorderRadius.circular(3)
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                   width: width*0.39,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.only(topLeft: Radius.circular(3),bottomLeft: Radius.circular(3)),
//                           child: Image(image:
//                           CachedNetworkImageProvider( Url.Image_URL+data.mainImage.toString(),
//                             // NetworkImage(Url.Image_URL+data.mainImage.toString()
//                           ),
//                             fit: BoxFit.fill,height: 100,),
//                         ),
//                       ),
//                       SizedBox(width: 8,),
//                       Container(
//                         width: width*0.45,
//                         padding: EdgeInsets.only(top: 5,bottom: 2),
//                         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Row(
//                               mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                               mainAxisSize: MainAxisSize.max,
//                               children: [
//                                 Text(data.hotelName.toString(),style: TextStyles.font14B500,),
//                                 Text("₹ ${data.offerPrice}",style:GoogleFonts.firaSans(fontSize: 13,color: Color(0xFF0188E2),fontWeight: FontWeight.w500,),
//                                 ),
//                               ],
//                             ),
//                             Container(
//                                 child: Row(
//                                   mainAxisAlignment:MainAxisAlignment.spaceBetween,mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Icon(Icons.location_on,color: Colors.black.withOpacity(0.4),size: 18,),
//                                         Text('${ data.city}',style: TextStyles.hint_text,),
//                                       ],
//                                     ),
//                                     // Spacer(),
//                                     data.rating==null?Container():Row(
//                                       children: [
//                                         Text("★",style: TextStyle(color: Colors.green),textScaleFactor: 1,),
//                                         Text(data.rating.toString(),style: TextStyles.hint_text,),
//                                       ],
//                                     ),
//
//                                   ],
//                                 )),
//                             SizedBox(height: 5,),
//                             Container(
//                               child: Text(data.description.toString(),
//                                 overflow: TextOverflow.ellipsis,
//                                 textAlign: TextAlign.justify,
//                                 maxLines: 3,
//                                 style: TextStyles.Ofont10B,),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//     ),);
//   }
// }
