

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import '../../Auth/otp.dart';
import '../../common/sharepre.dart';
class SignupCont extends GetxController {
  RxBool isLoading = false.obs;
  String id = '';
  String name = '';
  final _get_user_detail = GetUserDetail();
  ////////////////////////////////////////////////////// LOGIN API /////////////////////////////////////////////////////
  Future<void> signupApi(
      {required String pass,
        required String email,
        required String name,
        required String phone_number,
        required BuildContext context,}) async {
    try{
      var request = http.MultipartRequest('POST', Uri.parse('${Url.BASE_URL}signup'));
      request.fields.addAll({
        'email': email,
        'name': name,
        'password': pass,
        'phone_number': phone_number,
      });
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseJson = await response.stream.bytesToString();
        print("fields ===================$responseJson");
        var responseDecode = json.decode(responseJson);
        if (responseDecode["error"] == true) {
          if(responseDecode['message']=='The email field must contain a unique value'){
            isLoading.value = false;
            CommonToast(context: context, title: responseDecode['message'], alignCenter: false);
          }
          else{
            isLoading.value = false;
            CommonToast(context: context, title:responseDecode['message'], alignCenter: false);
          }
        } else {
          isLoading = true.obs;
          id = responseDecode["data"]["id"];
          print(responseDecode["data"]["otp"]);
          Get.off(()=>Otp(otp:responseDecode["data"]["otp"] ,type: '1', id: id, email: responseDecode["data"]["email"]));
          CommonToast(context: context, title: responseDecode["message"], alignCenter: false);
        }
        print("XXXXXXXXXXXXXXXXXXXXXXXXXX");
        print(responseDecode);
        print("XXXXXXXXXXXXXXXXXXXXXXXXXX");
      } else {
        CommonToast(context: context, title: response.reasonPhrase, alignCenter: true);
        print(response.reasonPhrase);
      }}catch(e){
      print("ERRORRRRRRRRRRRRR");
      isLoading.value = false;
      CommonToast(context: context, title: 'Check My connection', alignCenter: true);
      print(e);
    }
  }
}