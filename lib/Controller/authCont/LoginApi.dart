
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:najara_stays/Auth/otp.dart';
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import 'package:najara_stays/screens/bottomscreen.dart';
import '../../common/sharepre.dart';


class LoginCont extends GetxController {
  RxBool isLoading = false.obs;
  String id = '';
  String name = '';
  String email = '';
  final _get_user_detail = GetUserDetail();
  ////////////////////////////////////////////////////// LOGIN API /////////////////////////////////////////////////////
  Future<void> loginApi(
      {required String email,
        required String password,
        required String fcm_token,
        required BuildContext context,
        String fcmToken = '123'}) async {
    try{
      var request = http.MultipartRequest('POST', Uri.parse('${Url.BASE_URL}login'));
      request.fields.addAll({
        'email': email,
        'password': password,
        'fcm_token': fcm_token,
      });
      print('--------------reduest---------------${request.fields}');
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseJson = await response.stream.bytesToString();
        var responseDecode = json.decode(responseJson);
        if (responseDecode["error"] == true) {
          isLoading.value = false;
          isLoading = false.obs;
          CommonToast(context: context, title:responseDecode["message"], alignCenter: true);
        } else {
          if(responseDecode["message"]=="Please verify your email, we've sent OTP for the same."){
            isLoading.value = true;
            CommonToast(context: context, title: responseDecode["message"].toString(), alignCenter: true);
            Get.off(()=>Otp(otp: responseDecode["data"]["otp"], type: '1', id: responseDecode["data"]["id"],
                email: responseDecode["data"]["email"]));
          }else {
            isLoading.value = true;
            CommonToast(context: context, title: responseDecode["message"].toString(), alignCenter: false);
            name = responseDecode["data"]["name"];
            id = responseDecode["data"]["id"];
            String number = responseDecode['data']['phone_number'];
            String email = responseDecode['data']['email'];
            await _get_user_detail.setUserData("name", name);
            await _get_user_detail.setUserData("id", id);
            await _get_user_detail.setUserData('number', number);
            await _get_user_detail.setUserData('email', email);
            Get.off(() => Bottom());
          }  }
        isLoading.value = false;
      } else {
        print(response.reasonPhrase);
      }}catch(e){
      print("ERRORRRRRRRRRRRRR");
      isLoading.value = false;
      CommonToast(context: context, title: 'Check My connection', alignCenter: true);
      print(e);
    }
  }
}