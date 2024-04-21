import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:najara_stays/Controller/Cont/searchhotel_Api.dart';
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import '../../Modals/homeTophotelM.dart';



class SearchFiterController extends GetxController {
  final _searchCont=Get.put(SearchhotelController());
  // List<FilterData> filterlist = [];

  RxBool isLoading = false.obs;

  Future<void> searchfilterApi({required String city,
    required String roomtype,
    required String minprice,
    required String maxprice,
    required String rating,
    required String query,

    required BuildContext context,}) async {
    var body  = {
      "city":city.toString(),
      "room_type":roomtype.toString(),
      "min_price":minprice.toString(),
      "max_price":maxprice.toString(),
      "rating":rating,
      "query":query
    };
    final response = await post(Uri.parse(Url.BASE_URL+ "searchfilter"),
        body: body
    );
    print("body-----------------filterApi-------$body");
    if (response.statusCode == 200) {
      var data= jsonDecode(response.body);
      print("body-----------------filterApi----------$data");
      if (data["error"] == true) {
        CommonToast(context: context, title:data["message"], alignCenter: true);
        isLoading.value = false;
      } else {
        _searchCont.hotellist.clear();
        CommonToast(context: context, title: data["message"].toString(), alignCenter: false);
        HomeTophotelM Filter =HomeTophotelM.fromJson(data);
        _searchCont.hotellist.value=Filter.data!;
        isLoading.value = false;
        Get.back();
        // Get.off(()=>Searchhotel(status: '1',));
      }
    }
    else {
      throw Exception('Failed to load post');
    }
  }
}