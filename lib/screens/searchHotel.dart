
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controller/Cont/homeApi.dart';
import '../Controller/Cont/searchFilterApi.dart';
import '../Controller/authCont/baseUrl.dart';
import '../Controller/Cont/searchhotel_Api.dart';
import '../Modals/searchcityM.dart';
import '../common/textstyle.dart';
import 'hotel_detail.dart';

class Searchhotel extends StatefulWidget {
String status;

  Searchhotel({Key? key, required this.status}) : super(key: key);

  @override
  State<Searchhotel> createState() => SearchhotelState();
}

class SearchhotelState extends State<Searchhotel> {
  final fliter=Get.put(SearchFiterController());
  final _searchCont=Get.put(SearchhotelController());

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
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
             // Navigator.push(context, MaterialPageRoute(builder: (_)=>Bottom()));
            },
            icon: const Icon(Icons.arrow_back_sharp,color: Colors.black,),
          ),
          centerTitle: true,
          title: Text('Search List',style: TextStyles.font22Blue500,
          ),
          actions: [
            IconButton(onPressed: (){
              Get.to(()=>FilterS());
            }, icon:Image.asset('assests/setting.png',scale: 4),
              color: Colors.black,)
          ],
        ),
        body: Obx(() => SizedBox(
            width: double.infinity,
            child: ListView.builder(
              
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 20,right: 15,top: 0),
                itemCount: _searchCont.hotellist.length,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                itemBuilder: (context ,i){
                  var data =_searchCont.hotellist[i];
                  // if (_searchCont.hotellist[i].) {
                    
                  // }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: InkWell(
                      onTap: (){
                        Get.to(()=>HotelDetails(id: data.id.toString(),));
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
                              width: width*0.45,
                              padding: const EdgeInsets.only(top: 5,bottom: 2),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(data.hotelName.toString(),style: TextStyles.font16B,),
                                 // Text("₹ ${data.offerPrice}",style:GoogleFonts.firaSans(fontSize: 13,color: const Color(0xFF0188E2),fontWeight: FontWeight.w500,),
                                  //),

                                         data.rating==null?
                                         
                                         Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left:3.0),
                                            child: const Text("★",style: TextStyle(color: Colors.green),textScaleFactor: 1,),
                                          ),
                                          Text("0.0",style: TextStyles.Ofont14B,),
                                        ],
                                      ):Row(
                                        children: [
                                          const Text("★",style: TextStyle(color: Colors.green),textScaleFactor: 1,),
                                          Text(data.rating.toString(),style: TextStyles.Ofont14B,),
                                        ],
                                      ),
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(width: 0),
                                          Icon(Icons.location_on,color: Colors.black.withOpacity(0.4),size: 18),
                                          Text('${ data.city}',style: TextStyles.Ofont14B,),
                                        ],
                                      ),
                                      Text("₹ ${data.offerPrice}",style:GoogleFonts.firaSans(fontSize: 13,color: const Color(0xFF0188E2),fontWeight: FontWeight.w500,),
                                  ),
                                      // data.rating==null?Container():Row(
                                      //   children: [
                                      //     const Text("★",style: TextStyle(color: Colors.green),textScaleFactor: 1,),
                                      //     Text(data.rating.toString(),style: TextStyles.Ofont14B,),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(data.description.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    textScaleFactor: 1,
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
                })))
    );
  }
}







class FilterS extends StatefulWidget {

  const FilterS({Key? key,}) : super(key: key);

  @override
  State<FilterS> createState() => FilterSState();
}

class FilterSState extends State<FilterS> {
  List<SearchcityData> getCitySearch=[];
  List<SearchcityData> getCityListAdd=[];
  var id;
  @override
  void initState() {
    print('---------hoteltype------------$widget');
    load();
    super.initState();
  }


  load(){
    HotelApi().Searchcity(id:'',).then((value){
      setState((){
        getCityListAdd = getCitySearch =value.data!;
      });
    });
  }

  final fliter = Get.put(SearchFiterController());
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
                  const Icon(Icons.close,color: Colors.black,))
                ],),
              countryListField(context),

              const SizedBox(height: 20,),

              Text('Price',style: TextStyles.font16B,),
              const SizedBox(height: 10,),
              SizedBox(
                height: 20,
                child: RangeSlider(
                  values: RangeValues(start, end),
                  labels: RangeLabels(start.toString(), end.toString()),
                  min: 250,
                  max: 10000,
                  activeColor: const Color(0xFF004AAD),
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

              const SizedBox(height: 20,),
              Text('Rating',style: TextStyles.font16B,),
              const SizedBox(height: 10,),
              SizedBox(
                height: 35,
                child: Row(
                  children: [
                    Radio(
                        fillColor:
                        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          return (rating1) ? Colors.white :const Color(0xFF004AAD);
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
              SizedBox(
                height: 35,
                child: Row(
                  children: [
                    Radio(
                        fillColor:
                        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          return (rating1) ? Colors.white : const Color(0xFF004AAD);
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
              SizedBox(
                height: 35,
                child: Row(
                  children: [
                    Radio(
                        fillColor:
                        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          return (rating1) ? Colors.white :const Color(0xFF004AAD);
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
              SizedBox(
                height: 35,
                child: Row(
                  children: [
                    Radio(
                        fillColor:
                        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          return (rating1) ? Colors.white : const Color(0xFF004AAD);
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
              const SizedBox(height: 30,),
              fliter.isLoading.value==true?const Center(child: CircularProgressIndicator()): InkWell(
                onTap: (){
                  setState(() {
                    fliter.isLoading.value=true;
                    fliter.searchfilterApi(city:id==null?'':id.toString(),roomtype: '',minprice: num.parse(start.toStringAsFixed(0)).toString(),
                        maxprice: num.parse(end.toStringAsFixed(0)).toString(),rating: rating.toString(),context: context, query: '',).then((value) {
                      setState(() {
                        fliter.isLoading.value=false;
                      });
                    });
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
                      Text('Done',style:TextStyles.font22W),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue.shade700,
                        child: const Icon(Icons.arrow_forward_outlined,color: Colors.white,),
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
                                      hintText: "Enter your city",
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
                  child: const Icon(Icons.close)),
              hintText: 'Enter City',
              hintStyle: TextStyles.hint_text,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1.5,color: Colors.black.withOpacity(0.2))
              )
          )
      ),
    );
  }
}

