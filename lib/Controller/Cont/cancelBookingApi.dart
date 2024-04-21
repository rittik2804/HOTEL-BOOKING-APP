
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import 'package:najara_stays/screens/bottomscreen.dart';
import 'package:najara_stays/screens/mybooking.dart';
import '../../common/sharepre.dart';


class CancelCont extends GetxController {
  final getuser_id=GetUserDetail();


  ////////////////////////////////////////////////////// LOGIN API /////////////////////////////////////////////////////
  Future<void> cancelbookingApi(
      {required String bookingId,
        required String reason,
        required BuildContext context,}) async {
    var userid=await  getuser_id.getUserData('id');
    try{
      var request = http.MultipartRequest('POST', Uri.parse(Url.BASE_URL+'cancel-booking'));
      request.fields.addAll({
        'booking_id':bookingId.toString(),
        'user_id':userid.toString(),
        'reason':reason.toString(),
      });
print('--------cancelbookingApi--------------------------${request.fields}');
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseJson = await response.stream.bytesToString();
        var responseDecode = json.decode(responseJson);
        print('--------cancelbookingApi-------------responseDecode-------------${responseDecode}');
        if (responseDecode["error"] == true) {
          print('--------cancelbookingApi---------true----responseJson-------------${responseJson}');
          CommonToast(context: context, title:responseDecode["message"], alignCenter: false);

        } else {
          print('--------cancelbookingApi--------false-----responseJson-------------${responseJson}');
          CommonToast(context: context, title: responseDecode["message"].toString(), alignCenter: false);
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>Bottom()), (route) => true);
        }
      } else {
        print(response.reasonPhrase);
      }}catch(e){
      print("ERRORRRRRRRRRRRRR");

      CommonToast(context: context, title: 'Check My connection', alignCenter: true);
      print(e);
    }
  }
}