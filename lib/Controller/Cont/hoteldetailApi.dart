import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart';



import '../../Modals/hoteldetailM.dart';
import '../../Modals/hotellistM.dart';
import '../../Modals/mybookingM.dart';
import '../../common/sharepre.dart';
import '../../screens/hotel_detail.dart';
import '../../screens/searchHotel.dart';
import '../authCont/baseUrl.dart';




class HoteldetailApi  {

  RxBool isLoading = true.obs;


  final _get_user_detail = GetUserDetail();
  Future<HoteldetailM> hoteldetails(id,BuildContext context,) async {
    var body  = {"id":id,};

    final response = await post(Uri.parse("${Url.BASE_URL}fetch-hotel"),
        body: body
    );
    print('------------------hoteldetail-----------body-----------');
    if (response.statusCode == 200) {
      isLoading.value = false;
      var data= await jsonDecode(response.body);
      print('------------------hoteldetail-------------${data.toString()}-----------');
     print("The kitchen is"+ data['data']['has_kitchen']);
    // has_kitchen =data['data']['has_kitchen'];
      return HoteldetailM.fromJson(data);
    }
    else {
      throw Exception('Failed to load post');
    }
  }

  Future<MybookingM> Mybooking(id,BuildContext context,) async {

    var id=await _get_user_detail.getUserData('id');
    var body  = {"user_id":id,};

    final response = await post(Uri.parse("${Url.BASE_URL}my-bookings"),
        body: body
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
      var data= await jsonDecode(response.body);

       print('===========Mybookingdaata-----------$data');
      return MybookingM.fromJson(data);
    }
    else {
      throw Exception('Failed to load post');
    }
  }
  
}







// class HoteldetailController extends GetxController {
//   HoteldetailData tophotel = HoteldetailData();
//   List  photo=[];
//   List<Rooms>  room=[];
//   List<AmenitiesIcon> amenit=[];
//   List<Rooms> roomamenit=[];
//   var isLoading = true.obs;
//
//   Future<void> Topcatgory({id}) async {
//     var body  = {"id":'32',};
//
//     final response = await post(Uri.parse(Url.BASE_URL+ "fetch-hotel"),
//         body: body
//     );
//     if (response.statusCode == 200) {
//       HoteldetailM _albumModel = HoteldetailM.fromJson(jsonDecode(response.body));
//       tophotel=_albumModel.data!;
//
//       print('-------tophotel---------${tophotel.city}');
//
//       isLoading.value = false;
//       photo=_albumModel.data!.images!;
//       amenit=_albumModel.data!.amenitiesIcon!;
//       room=_albumModel.data!.rooms!;
//       roomamenit=_albumModel.data!.rooms!;
//
//       // photo=value.data!.images!;
//       // amenit=value.data!.amenitiesIcon!;
//       // room=value.data!.rooms!;
//       // roomamenit=value.data!.rooms!;
//       print('-------photo---------${photo.length}');
//       print('-------amenit---------${amenit.length}');
//       print('-------room---------${room.length}');
//       print('-------roomamenit---------${roomamenit.length}');
//       Get.to(()=>HotelDetails());
//     } else {
//       isLoading.value = false;
//       Get.snackbar('Error Loading data!',
//           'Sever responded: ${response.statusCode}:${response.reasonPhrase.toString()}');
//     }
//   }
//
//
//
//
//
//
// }