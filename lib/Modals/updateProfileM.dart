// /// error : false
// /// message : "Profile updated successfully."
// /// data : {"user":{"name":"Dushyant Vishwakarma","profile_image":"uploads/profile_pictures/10479c4271694b4498188a12634ccd76.png","phone_number":"70149326509","email":"dushyant.vedanshtechnovision@gmail.com"}}
//
// class UpdateProfileM {
//   UpdateProfileM({
//       bool? error,
//       String? message,
//     UpdateProfileData? data,}){
//     _error = error;
//     _message = message;
//     _data = data;
// }
//
//   UpdateProfileM.fromJson(dynamic json) {
//     _error = json['error'];
//     _message = json['message'];
//     _data = json['data'] != null ? UpdateProfileData.fromJson(json['data']) : null;
//   }
//   bool? _error;
//   String? _message;
//   UpdateProfileData? _data;
// UpdateProfileM copyWith({  bool? error,
//   String? message,
//   UpdateProfileData? data,
// }) => UpdateProfileM(  error: error ?? _error,
//   message: message ?? _message,
//   data: data ?? _data,
// );
//   bool? get error => _error;
//   String? get message => _message;
//   UpdateProfileData? get data => _data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['error'] = _error;
//     map['message'] = _message;
//     if (_data != null) {
//       map['data'] = _data?.toJson();
//     }
//     return map;
//   }
//
// }
//
// /// user : {"name":"Dushyant Vishwakarma","profile_image":"uploads/profile_pictures/10479c4271694b4498188a12634ccd76.png","phone_number":"70149326509","email":"dushyant.vedanshtechnovision@gmail.com"}
//
// class UpdateProfileData {
//   UpdateProfileData({
//       User? user,}){
//     _user = user;
// }
//
//   UpdateProfileData.fromJson(dynamic json) {
//     _user = json['user'] != null ? User.fromJson(json['user']) : null;
//   }
//   User? _user;
//   UpdateProfileData copyWith({  User? user,
// }) => UpdateProfileData(  user: user ?? _user,
// );
//   User? get user => _user;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_user != null) {
//       map['user'] = _user?.toJson();
//     }
//     return map;
//   }
//
// }
//
// /// name : "Dushyant Vishwakarma"
// /// profile_image : "uploads/profile_pictures/10479c4271694b4498188a12634ccd76.png"
// /// phone_number : "70149326509"
// /// email : "dushyant.vedanshtechnovision@gmail.com"
//
// class User {
//   User({
//       String? name,
//       String? profileImage,
//       String? phoneNumber,
//       String? email,}){
//     _name = name;
//     _profileImage = profileImage;
//     _phoneNumber = phoneNumber;
//     _email = email;
// }
//
//   User.fromJson(dynamic json) {
//     _name = json['name'];
//     _profileImage = json['profile_image'];
//     _phoneNumber = json['phone_number'];
//     _email = json['email'];
//   }
//   String? _name;
//   String? _profileImage;
//   String? _phoneNumber;
//   String? _email;
// User copyWith({  String? name,
//   String? profileImage,
//   String? phoneNumber,
//   String? email,
// }) => User(  name: name ?? _name,
//   profileImage: profileImage ?? _profileImage,
//   phoneNumber: phoneNumber ?? _phoneNumber,
//   email: email ?? _email,
// );
//   String? get name => _name;
//   String? get profileImage => _profileImage;
//   String? get phoneNumber => _phoneNumber;
//   String? get email => _email;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['name'] = _name;
//     map['profile_image'] = _profileImage;
//     map['phone_number'] = _phoneNumber;
//     map['email'] = _email;
//     return map;
//   }
//
// }