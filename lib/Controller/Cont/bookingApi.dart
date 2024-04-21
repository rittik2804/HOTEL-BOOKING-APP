

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import 'package:najara_stays/screens/bottomscreen.dart';
import 'package:najara_stays/screens/paymentscreen.dart';
import '../../Modals/bookingM.dart';
import '../../common/sharepre.dart';


class BookingCont extends GetxController {
  RxBool isLoading = false.obs;
  String id = '';
  String name = '';
  String email = '';
  var _paymentResponse;
  final _get_user_detail = GetUserDetail();

  ////////////////////////////////////////////////////// LOGIN API /////////////////////////////////////////////////////



  Future<BookingM> bokingApi({
        required String hotelid,
        required String first_name,
        required String last_name,
        required String email,
        required String number,
        required String address,
        required String statedate,
        required String enddate,
        required String roomtype,
        required String totalroom,
        required String totaladult,
        required String totalchild,
        required String totalinfant,
        required String meal_type,
        required String price,
        required String dueamount,
        required String room_id,
        required String coupon_id,
        required BuildContext context,
        String fcmToken = '123'}) async {
    var id=await _get_user_detail.getUserData('id');
    var request = http.MultipartRequest('POST', Uri.parse('${Url.BASE_URL}booking'));
    request.fields.addAll({
      "user_id":id,
      "hotel_id":hotelid,
      "first_name":first_name,
      "last_name":last_name,
      "email":email,
      "contact_number":number,
      "address":address,
      "room_type":roomtype,
      "start_date_time":statedate,
      "end_date_time":enddate,
      "total_no_rooms":totalroom,
      "total_no_adults":totaladult,
      "total_no_children":totalchild,
      "total_no_infant":totalinfant,
      "meal_type":meal_type,
      "booking_amount":price,
      "due_amount":dueamount,
      "room_id":room_id,
      "coupon_code":coupon_id,
    });
    print('=======body  ----------${request.fields}');
    http.StreamedResponse response = await request.send();
    var responseJson = await response.stream.bytesToString();
    var data = json.decode(responseJson);
    print('response  ----------${json.encode(data)}');
    print( "the booking response is "+data.toString());
    try{
    if (response.statusCode == 200) {
      if(data['error'] == true){
      //  CommonToast(context: context, title: data["message"].toString(), alignCenter: false);
      }else{
        CommonToast(context: context, title: data["message"].toString(), alignCenter: false);
        var id = data['data']['booking_id'].toString();
        print('--------- id ----------$id');
        await _get_user_detail.setUserData("bookingId", id);
      }
      return BookingM.fromJson(data);
    }
    else {
      CommonToast(context: context, title: data["message"].toString(), alignCenter: false);
      return BookingM.fromJson(data);
    }
  }catch(e){
      print('errrrrrr-------------$e');
      CommonToast(context: context, title: data["message"].toString(), alignCenter: false);
      return  BookingM.fromJson(data);

    }
  }

}


class BookingValApi {
  final getuser_id=GetUserDetail();

  RxBool loader=true.obs;

  Future<void> bookingvalidationApi(
      {
        // required String payment_id,
        // required String payment_status,
        // required String statusCode,
        // required String orderId,
        required String booking_id,
        required String paymet_status,
        required String paymet_id,
        required String order_id,

       
        required BuildContext context,
        String fcmToken = '123'}) async {
    //var bookingId = await getuser_id.getUserData('bookingId');
    var body  = {
      // "booking_id":bookingId,
      // "payment_id":payment_id,
      // "payment_status":payment_status,
      // "block_id": statusCode,
      // "statusCode":statusCode,
      "booking_id": booking_id,
      "payment_status": paymet_status,
      "payment_id": paymet_id,
      "orderId": order_id

    };

    final response = await http.post(Uri.parse("${Url.BASE_URL}validate-booking"),
        body:body);
    print('------------bookingvalidationApi  ----------$body');
    var data= jsonDecode(response.body);
    print('----------------------bookingvalidation data ----------$data');
    if (response.statusCode == 200) {
      print('---------bookingvalidation data ----------$data');
      //CommonToast(context: context, title: data["message"].toString(), alignCenter: false);
      // Get.off(()=>Bottom());
    }
    else {

      throw Exception('Failed to load post');
    }
  }

}