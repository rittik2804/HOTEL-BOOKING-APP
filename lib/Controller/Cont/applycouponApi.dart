import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:najara_stays/Modals/redeemCouponM.dart';
import 'package:najara_stays/Controller/authCont/baseUrl.dart';

import '../../Modals/cal_bookingpriceM.dart';
import '../../common/sharepre.dart';
import '../../screens/booking.dart';



class CouponApi {
  final _get_user_detail = GetUserDetail();
  RxBool isLoading = true.obs;

  Future couponpriceApi({
    required String couponCode,
    required String amount,
    required BuildContext context,}) async {
  var  userId= await _get_user_detail.getUserData("id",);
    var body  = {
      "user_id":userId,
      "coupon_code":couponCode.toString(),
      "amount":amount.toString(),
    };
    print('----------------redeem-----------------couponpriceApi-------------$body');
    final response = await post(Uri.parse(Url.BASE_URL+ "redeem"),
        body: body
    );

    if (response.statusCode == 200) {
      var data= jsonDecode(response.body);
      print('--------couponpriceApi-------------------data-----------------------${data['data']==null?"12":data}');
      isLoading.value = false;
      CommonToast(context: context, title: data["message"].toString(), alignCenter: false);
      return data['data']==null?"12":data;


    }
    else {
      throw Exception('Failed to load post');
    }
  }
}