
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import 'package:najara_stays/screens/bottomscreen.dart';
import '../../Modals/updateProfileM.dart';
import '../../common/sharepre.dart';


class ReviewCont extends GetxController {
  RxBool isLoading = false.obs;
  final _get_user_detail = GetUserDetail();
  ////////////////////////////////////////////////////// LOGIN API /////////////////////////////////////////////////////
  Future<void> reviewApi({
        required String text,
        required String rating,
        required String hotelId,
        required BuildContext context,}) async {
    try{
      var request = http.MultipartRequest('POST', Uri.parse(Url.BASE_URL+'submit-review'));
      var userId= await _get_user_detail.getUserData('id');
      request.fields.addAll({
        'user_id': userId,
        'description': text,
        'rating': rating,
        'hotel_id': hotelId,
      });
      print('----------------Review--------------- request.fields--------------__${ request.fields}');
      http.StreamedResponse response = await request.send();
      var responseJson = await response.stream.bytesToString();
      var responseDecode = json.decode(responseJson);
      if (response.statusCode == 200) {
        print('----------------Review---------------responseDecode--------------__${responseDecode}');
        if (responseDecode["error"] == true) {
          isLoading.value = false;
          isLoading = false.obs;
          CommonToast(context: context, title:responseDecode["message"], alignCenter: false);

        } else {
          isLoading = true.obs;
          isLoading.value = true;
          print('----------------Review---------------responseDecode--------------__${responseDecode}');
          CommonToast(context: context, title: responseDecode["message"].toString(), alignCenter: false);
        }
        isLoading.value = false;
      } else {
        print(response.reasonPhrase);
      }}catch(e){
      print("-----------------ERRORRRRRRRRRRRRR-------------------------Review");
      isLoading.value = false;
      CommonToast(context: context, title: 'Check My connection', alignCenter: true);
      print(e);
    }
  }
}