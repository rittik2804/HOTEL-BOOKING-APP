import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:najara_stays/Controller/authCont/baseUrl.dart';

import '../../Modals/hotellistM.dart';
import '../../common/sharepre.dart';
import '../../screens/bottomscreen.dart';
import '../../screens/searchHotel.dart';



class ReferController extends GetxController {
  RxBool isLoading = false.obs;

  final getuser_id=GetUserDetail();

  Future<void> searchApi({
    required String name,
    required String buddy_name,
    required String contact,
    required String referType,
    required String hotelId,

    required BuildContext context,}) async {
    var userId = await getuser_id.getUserData('id');
    var body  = {
      "referred_by":userId.toString(),
      "user_name":name.toString(),
      "buddy_name":buddy_name.toString(),
      "buddy_contact":contact.toString(),
      "refer_type":referType.toString(),
      "hotel_id":hotelId.toString(),
    };
    print('----ReferControllerbody---------$body');

    final response = await post(Uri.parse(Url.BASE_URL+ "refer"),
        body: body
    );

    if (response.statusCode == 200) {
      var data= jsonDecode(response.body);
      if (data["error"] == true) {
        CommonToast(context: context, title:data["message"], alignCenter: false);
        isLoading.value = false;
      } else {
        CommonToast(context: context, title: data["message"].toString(), alignCenter: false);
        print('----ReferControllerbody---------${data["message"]}');
        isLoading.value = false;
        // Get.to(()=>Hotellist());
      }}
    else {
      throw Exception('Failed to load post');
    }
  }
}