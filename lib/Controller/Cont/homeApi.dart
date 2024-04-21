import 'dart:convert';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';
import 'package:najara_stays/Controller/authCont/baseUrl.dart';
import 'package:najara_stays/Modals/popularM.dart';
import 'package:najara_stays/Modals/reviewM.dart';

import '../../Modals/homeTophotelM.dart';
import '../../Modals/mybookingM.dart';
import '../../Modals/profileM.dart';
import '../../Modals/recentHotelM.dart';
import '../../Modals/searchcityM.dart';
import '../../Modals/whatpeopleM.dart';
import '../../common/sharepre.dart';
import 'package:http/http.dart' as http;

class HotelApi {
  final getuser_id=GetUserDetail();
  RxBool loader=true.obs;


  Future<PopularM> popular() async {
    final response = await get(Uri.parse("${Url.BASE_URL}popular-destinations"),
    );
    var data= jsonDecode(response.body);
    if (response.statusCode == 200) {
      loader.value=false;
      return PopularM.fromJson(data);
    }
    else {
      throw Exception('Failed to load post');
    }
  }

  Future<HomeTophotelM> Tophotelapi({type, hotelType}) async {
    var body  = {
      "type" : type.toString(),
      "hotel_type":hotelType.toString()
    };
    final response = await post(Uri.parse("${Url.BASE_URL}top-hotels"),
        body:body);
print('-----hotelapi------body---------------$body');
    var data= jsonDecode(response.body);
    if (response.statusCode == 200) {

      print('-----hotelapi------data---------------$data');
      return HomeTophotelM.fromJson(data);
    }
    else {
      throw Exception('Failed to load post');
    }
  }
  Future<WhatpeopleM> Whatpeole() async {
    final response = await get(Uri.parse("${Url.BASE_URL}testimonials"),);
    var data= jsonDecode(response.body);
    if (response.statusCode == 200) {
      loader.value=false;
      return WhatpeopleM.fromJson(data);
    }
    else {
      loader.value=false;
      throw Exception('Failed to load post');
    }
  }


  Future<MybookingM> Mybooking({type}) async {
    var userid=await  getuser_id.getUserData('id');
    var body  = {
      "user_id" :userid.toString(),
      "type" :type
    };
    print(body);
    final response = await post(Uri.parse("${Url.BASE_URL}my-bookings"),
        body:body);
    var data= jsonDecode(response.body);
    print('=======booking data ----------$data');
    if (response.statusCode == 200) {
      loader.value=false;
      return MybookingM.fromJson(data);
    }
    else {
      loader.value=false;
      throw Exception('Failed to load post');
    }
  }

  Future Refer({hotel_id}) async {
    var userid = await getuser_id.getUserData('id');
    var body = {
      "user_id": userid.toString(),
      "hotel_id": hotel_id
    };
    print('----------------body------refer-hotel-----------------$body');
    final response = await post(Uri.parse("${Url.BASE_URL}refer-hotel"),
        body: body);
    var data = jsonDecode(response.body);
    print(
        '----------------------refer-hotel----------- data ----------${data['data']['url']}');
    if (response.statusCode == 200) {
      loader.value = false;
      return data;
    }
    else {
      loader.value = false;
      throw Exception('Failed to load post');
    }
  }
  Future<ProfileM> Myprofile() async {
    var userid=await  getuser_id.getUserData('id');
    var body  = {
      "user_id" : userid.toString(),
    };
    print('----------------body------view-profile-----------------$body');
    final response = await post(Uri.parse("${Url.BASE_URL}view-profile"),
        body:body);
    if (response.statusCode == 200) {

      var data= jsonDecode(response.body);
      print('----------------------view-profile----------- data ----------${data}');
      loader.value=false;
      return ProfileM.fromJson(data);
    }
    else {
      loader.value=false;
      throw Exception('Failed to load post');
    }
  }


  Future<ReviewM> ReviewApi({id}) async {
    var body  = {
      "hotel_id" : id.toString(),
    };
    print('----------------body------------ReviewApi-----------------$body');
    final response = await post(Uri.parse("${Url.BASE_URL}review-rating"),
        body:body);
    if (response.statusCode == 200) {

      var data= jsonDecode(response.body);
      print('-----------------------ReviewApi----------- data ----------${data}');
      loader.value=false;
      return ReviewM.fromJson(data);
    }
    else {
      loader.value=false;
      throw Exception('Failed to load post');
    }
  }


  Future<SearchcityM> Searchcity({id}) async {
    var body  = {
      "city_name":id.toString(),
    };
    print('----------------body------------filter city-----------------$body');
    final response = await post(Uri.parse("${Url.BASE_URL}city-search"),
        body:body);
    if (response.statusCode == 200) {

      var data= jsonDecode(response.body);
      print('-----------------------filter city----------- data ----------${data}');
      loader.value=false;
      return SearchcityM.fromJson(data);
    }
    else {
      loader.value=false;
      throw Exception('Failed to load post');
    }
  }
  Future Term$CondApi() async {
    final response = await get(Uri.parse("${Url.BASE_URL}ckeditor/1"),);
        if (response.statusCode == 200) {

      var data= jsonDecode(response.body);
      print('-----------------------TermCondApi----------- data ----------${data}');
      loader.value=false;
      return data['data']['contant'];
    }
    else {
      loader.value=false;
      throw Exception('Failed to load post');
    }
  }
  Future<RecentHotelM> RecentHotel() async {
    // final response = await get(Uri.parse("${Url.BASE_URL}recently-updated"),);

    final response = await http.post(Uri.parse(Url.BASE_URL+ "top-hotels"),
        body: {
          "type" : "0",
          "hotel_type":"1"
        });
    if (response.statusCode == 200) {
      var data= jsonDecode(response.body);
      print('-----------------------RecentHotel----------- data ----------${data}');
      loader.value=false;
      return RecentHotelM.fromJson(data);
    }
    else {
      loader.value=false;
      throw Exception('Failed to load post');
    }
  }
  Future Youtube() async {
    final response = await get(Uri.parse("${Url.BASE_URL}youtube-link"),);
    if (response.statusCode == 200) {

      var data= jsonDecode(response.body);
      print('-----------------------Youtube----------- data ----------${data['data']['image']}');
      loader.value=false;
      return data['data']['image'];
    }
    else {
      loader.value=false;
      throw Exception('Failed to load post');
    }
  }
  Future GoogleMap() async {
    final response = await get(Uri.parse("${Url.BASE_URL}youtube-link"),);
    if (response.statusCode == 200) {

      var data= jsonDecode(response.body);
      print('-----------------------Youtube----------- data ----------${data['data']['image']}');
      loader.value=false;
      return data['data']['image'];
    }
    else {
      loader.value=false;
      throw Exception('Failed to load post');
    }
  }
}