







import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import '../../Auth/otp.dart';
import '../../Auth/resetpassword.dart';
import '../../common/sharepre.dart';


class ResetCont extends GetxController {
  RxBool isLoading = false.obs;
  String id = '';
  String name = '';
  String email = '';
  final _get_user_detail = GetUserDetail();
  ////////////////////////////////////////////////////// LOGIN API /////////////////////////////////////////////////////
  Future<void> resetApi(
      {required String password,
        required String id,
        required BuildContext context,}) async {
    try{
      var request = http.MultipartRequest('POST', Uri.parse(Url.BASE_URL+'update-password'));
      request.fields.addAll({
        'user_id': id,
        'password': password.toString(),
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseJson = await response.stream.bytesToString();
        var responseDecode = json.decode(responseJson);

        if (responseDecode["error"] == true) {
          CommonToast(context: context, title:responseDecode["message"], alignCenter: false);

        } else {
          CommonToast(context: context, title: responseDecode["message"].toString(), alignCenter: false);
          Get.to(Congrate());
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