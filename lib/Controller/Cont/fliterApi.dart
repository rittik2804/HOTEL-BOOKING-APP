import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart';
import 'package:najara_stays/Controller/Cont/get_hotel_Api.dart';
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import '../../Modals/homeTophotelM.dart';




class FiterController extends GetxController {
  final _get_hotelCont=Get.put(Get_hotelCont());
  RxBool isLoading = false.obs;

  Future<void> filterApi({required String city,
    required String roomtype,
    required String minprice,
    required String maxprice,
    required String rating,
    required String hoteltype,
    required String type,
    required BuildContext context,}) async {
    var body  = {
      "city":city.toString(),
      "room_type":roomtype.toString(),
      "min_price":minprice.toString(),
      "max_price":maxprice.toString(),
      "rating":rating,
      "hotel_type":hoteltype
    };

    final response = await post(Uri.parse(Url.BASE_URL+ "filter"),
        body: body
    );
    print("body-----------------filterApi-------$body");
    if (response.statusCode == 200) {
      var data= jsonDecode(response.body);

      if (data["error"] == true) {
        CommonToast(context: context, title:data["message"], alignCenter: true);
        isLoading.value = false;
      } else {
        _get_hotelCont.getHotel_list.clear();
        print("body-----------------filterApi----------$data");
        CommonToast(context: context, title: data["message"].toString(), alignCenter: false);
        HomeTophotelM Filter =HomeTophotelM.fromJson(data);
        // filterlist=Filter.data!;
        _get_hotelCont.getHotel_list.value=Filter.data!;
        isLoading.value = false;
        Get.back();
      }
  }
    else {
      throw Exception('Failed to load post');
    }
  }
}