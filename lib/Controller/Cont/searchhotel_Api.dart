import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:najara_stays/Controller/authCont/baseUrl.dart';

import '../../Modals/homeTophotelM.dart';

import '../../screens/searchHotel.dart';



class SearchhotelController extends GetxController {
  RxList<HomeTophotelData> hotellist = <HomeTophotelData>[].obs;

  RxBool isLoading = false.obs;


  Future<void> searchApi({required String query,
    required String room_type,
    required String total_no_adults,
    required String total_no_children,
    required String total_no_rooms,
    required String start_date,
    required String end_date,
    

    required BuildContext context,}) async {
    var body  = {
      "query":query.toString(),
      "room_type":room_type.toString(),
      "total_no_adults":total_no_adults.toString(),
      "total_no_children":total_no_children.toString(),
      "total_no_rooms":total_no_rooms,
      "start_date":start_date,
      "end_date":end_date

    };
    final response = await post(Uri.parse(Url.BASE_URL+ "search-hotels"),
        body: body
    );
    print("body-----------------searchApi-------$body");
    if (response.statusCode == 200) {
      var data= jsonDecode(response.body);
        if (data["error"] == true) {
        //  CommonToast(context: context, title:data["message"], alignCenter: false);
          isLoading.value = false;
        } else {
      //CommonToast(context: context, title: data["message"].toString(), alignCenter: false);
      HomeTophotelM movieWebM =HomeTophotelM.fromJson(data);

      hotellist.value=movieWebM.data!;

      isLoading.value = false;
      Get.to(()=>Searchhotel(status: '0',));
      print("The start date is "+ start_date);
      print("The end date is "+ end_date);
      print("The total room date is "+total_no_rooms);

    }}
    else {
      throw Exception('Failed to load post');
    }
  }
}