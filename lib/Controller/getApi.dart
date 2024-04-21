// import 'dart:convert';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:get/route_manager.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// import 'package:najara_stays/Controller/baseUrl.dart';
//
// import '../Modals/popularM.dart';
//
//
//
// class PopularController extends GetxController {
//   List<PopularData> bannerdata = [];
//   var isLoading = true.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     Tophotel();
//   }
//   Future<void> Tophotel() async {
//     final response = await get(Uri.parse(Url.BASE_URL+ "popular-destinations"),
//     );
//     if (response.statusCode == 200) {
//       PopularM _albumModel = PopularM.fromJson(jsonDecode(response.body));
//       bannerdata=_albumModel.data!;
//       isLoading.value = false;
//
//     } else {
//       isLoading.value = false;
//       Get.snackbar('Error Loading data!',
//           'Sever responded: ${response.statusCode}:${response.reasonPhrase.toString()}');
//     }
//   }
// }




// import 'dart:convert';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:get/route_manager.dart';
// import 'package:http/http.dart';
// import 'package:najara_stays/Controller/baseUrl.dart';
//
// import '../Modals/homeTophotelM.dart';
// import '../common/sharepre.dart';
//
//
//
// class TophotelController extends GetxController {
//   List<HomeTophotelData> tophotel = [];
//   var isLoading = true.obs;
//   final _get_user_detail = GetUserDetail();
//   @override
//   void onInit() {
//     super.onInit();
//     Topcatgory();
//   }
//   Future<void> Topcatgory() async {
//     final response = await get(Uri.parse(Url.BASE_URL+ "top-hotels"),);
//     if (response.statusCode == 200) {
//       HomeTophotelM _albumModel = HomeTophotelM.fromJson(jsonDecode(response.body));
//       tophotel=_albumModel.data!;
//       print('-------tophotel---------${tophotel.length}');
//       isLoading.value = false;
//
//     } else {
//       isLoading.value = false;
//       Get.snackbar('Error Loading data!',
//           'Sever responded: ${response.statusCode}:${response.reasonPhrase.toString()}');
//     }
//   }
// }