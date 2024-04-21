

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import '../../Auth/otp.dart';
import '../../Modals/homeTophotelM.dart';
import '../../common/sharepre.dart';


class Get_hotelCont extends GetxController {
  RxList<HomeTophotelData> getHotel_list=<HomeTophotelData>[].obs;
  RxBool isLoading = false.obs;

  final _get_user_detail = GetUserDetail();

  ////////////////////////////////////////////////////// HOTEL  API /////////////////////////////////////////////////////


  Future get_hotelapi({type, hotelType}) async {
    var body  = {
      "type" : type.toString(),
      "hotel_type":hotelType.toString()
    };
    try{
    final response = await http.post(Uri.parse(Url.BASE_URL+ "top-hotels"),
        body:body);
    print('-----hotelapi------body---------------$body');
    var data= jsonDecode(response.body);
    if (response.statusCode == 200) {
      HomeTophotelM hoteldata=HomeTophotelM.fromJson(data);
      print('-----hotelapi------data---------------$data');
      getHotel_list.value=hoteldata.data!;

    }
    else {
      throw Exception('Failed to load post');
    }
  }catch(e){
      print(e);
    }

  }
}