




import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:najara_stays/Auth/login.dart';
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import 'package:najara_stays/screens/bottomscreen.dart';
import '../../common/sharepre.dart';


class OtpCont extends GetxController {
  RxBool isLoading = false.obs;
  String id = '';
  String name = '';
  String email = '';
  final _get_user_detail = GetUserDetail();
  ////////////////////////////////////////////////////// LOGIN API /////////////////////////////////////////////////////
  Future<void> otpApi({
    required String otp,
    required String id,
        required BuildContext context,}) async {
    var userId = await _get_user_detail.getUserData('id');
    try{
      var request = http.MultipartRequest('POST', Uri.parse('${Url.BASE_URL}verify-otp'));
      request.fields.addAll({
        'user_id': id.toString(),
        'otp': otp,
      });
      print('---------------------${request.fields}');
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseJson = await response.stream.bytesToString();
        var responseDecode = json.decode(responseJson);
        print("XXXXXXXXXXXXXXXXXXXXXXXXXX-------$responseDecode");
        if (responseDecode["error"] == true) {
          CommonToast(context: context, title:responseDecode["message"], alignCenter: false);

        } else {
          isLoading.value = false;
          CommonToast(context: context, title: responseDecode["message"].toString(), alignCenter: false);
          name = responseDecode["data"]["name"];
          // id = responseDecode["data"]["id"];
          // String number = responseDecode['data']['phone_number'];
          // String email = responseDecode['data']['email'];
          // await _get_user_detail.setUserData("name", name);
          // await _get_user_detail.setUserData("id", id);
          // await _get_user_detail.setUserData('number', number);
          // await _get_user_detail.setUserData('email', email);
          Get.off(()=>Login());
        }

        print("XXXXXXXXXXXXXXXXXXXXXXXXXX");
        print(responseDecode);
        print("XXXXXXXXXXXXXXXXXXXXXXXXXX");
      } else {
        print(response.reasonPhrase);
      }}catch(e){
      print("ERRORRRRRRRRRRRRR");
      isLoading.value = true;
      CommonToast(context: context, title: 'Check My connection', alignCenter: true);
      print(e);
    }
  }
}