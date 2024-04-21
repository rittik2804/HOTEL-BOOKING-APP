import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:najara_stays/Controller/Cont/date_manage.dart';
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import 'package:najara_stays/Modals/profileM.dart';

import '../../Modals/cal_bookingpriceM.dart';




class Searchprice {
  RxBool isLoading = true.obs;
  Future<CalBookingpriceM> searchpriceApi({
    required String hotel_id,
    required String room_type,
    required String total_no_adults,
    required String total_no_children,
    required String total_no_rooms,
    required String meal_type,
    required String starttime,
    required String endtime,
    required String couponCode,
    required BuildContext context,}) async {
    var body  = {
      "hotel_id":hotel_id,
      "room_type":room_type.toString(),
      "total_no_adults":total_no_adults.toString(),
      "total_no_children":total_no_children.toString(),
      "total_no_rooms":total_no_rooms,
      "meal_type":meal_type,
      "start_date_time":starttime,
      "end_date_time":endtime,
      "coupon_code":couponCode,
    };
    
    print('----------------CalBookingpriceMbody----------------------$body');
    final response = await post(Uri.parse(Url.BASE_URL+ "calculate-booking-price"),
        body: body
    );

    if (response.statusCode == 200) {
      var data= jsonDecode(response.body);
      print('--------data---------$data');
      if (data["error"] == true) {
        
        DateMange.isBookingPossible=false.obs;
        CommonToast(context: context, title: data["message"].toString(), alignCenter: true);
        return CalBookingpriceM.fromJson(data);
        
      }else {
        print("data load false");
        
        // CommonToast(context: context,
        //     title: data["message"].toString(),
        //     alignCenter: false);
         DateMange.isBookingPossible=true.obs;
        isLoading.value = false;
        return CalBookingpriceM.fromJson(data);
      }

      }
    else {
      throw Exception('Failed to load post');
    }
  }



}