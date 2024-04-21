
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import 'package:najara_stays/screens/bottomscreen.dart';
import '../../Modals/updateProfileM.dart';
import '../../common/sharepre.dart';


class UpdateprofileCont extends GetxController {
  RxBool isLoading = false.obs;
  final _get_user_detail = GetUserDetail();
  ////////////////////////////////////////////////////// LOGIN API /////////////////////////////////////////////////////
  Future<void> profieApi(
      {required String email,
        required String name,
        required String image,
        required String number,
        required BuildContext context,}) async {
    try{
      var request = http.MultipartRequest('POST', Uri.parse(Url.BASE_URL+'update-profile'));
      var userId= await _get_user_detail.getUserData('id');
      request.fields.addAll({
        'user_id': userId,
        'name': name,
        'phone_number': number,
        'email': email,
        // 'image': image,
      });
      print('------------$image');
      if(image==null.toString()){
        print('----if --------$image');
      }else{
        request.files.add(await http.MultipartFile.fromPath('image',image));
      }

      print('----------------profieApi------------------__${request.fields}');
      print('----------------profieApi------------------__${request.files}');
      print('----------------profieApi------------------__${image}');
      http.StreamedResponse response = await request.send();
      var responseJson = await response.stream.bytesToString();
      var responseDecode = json.decode(responseJson);
      if (response.statusCode == 200) {
        if (responseDecode["error"] == true) {
          isLoading.value = false;
          isLoading = false.obs;
          CommonToast(context: context, title:responseDecode["message"], alignCenter: false);
        } else {
          isLoading = true.obs;
          isLoading.value = true;
          print('----------------profieApi---------------responseDecode--------------__${responseDecode}');
          CommonToast(context: context, title: responseDecode["message"].toString(), alignCenter: false);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=>Bottom()), (route) => false);
        }
        isLoading.value = false;
      } else {
        print(response.reasonPhrase);
      }
  }catch(e){
      print("-----------------ERRORRRRRRRRRRRRR-------------------------UpdateprofileCont");
      isLoading.value = false;
      CommonToast(context: context, title: 'Check My connection', alignCenter: true);
      print(e);
    }
  }
}