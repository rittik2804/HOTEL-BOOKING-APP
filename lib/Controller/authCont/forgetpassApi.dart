

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import '../../Auth/otp.dart';
import '../../common/sharepre.dart';


class ForgetCont extends GetxController {
  RxBool isLoading = false.obs;
  String id = '';
  String name = '';
  String email = '';
  final _get_user_detail = GetUserDetail();

  ////////////////////////////////////////////////////// LOGIN API /////////////////////////////////////////////////////


  Future<void> forgetApi({
    required String email,
        required BuildContext context,}) async {
    try{
      var request = http.MultipartRequest('POST', Uri.parse(Url.BASE_URL+'forget-password'));
      request.fields.addAll({
        'email': email.toString(),
      });
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseJson = await response.stream.bytesToString();
        var responseDecode = json.decode(responseJson);
        if (responseDecode["error"] == true) {
          CommonToast(context: context, title:responseDecode["message"], alignCenter: false);
        } else {
          CommonToast(context: context, title: responseDecode["message"].toString(), alignCenter: false);
          // name = responseDecode["data"]["name"];
          id = responseDecode["data"]["id"];
          Navigator.push(context, MaterialPageRoute(builder: (_)=>Otp(otp: responseDecode['data']['otp'],type: '2', id: id, email: email,)));
          print("otp---------------------pto------------${id}");

        }
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