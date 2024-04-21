/// error : false
/// message : "User Profile."
/// data : {"name":"John Doe","profile_image":"uploads/profile_pictures/700a83afd944d4dd3d4dddf9d0e21d65.png","phone_number":"789658452","email":"user123@gmail.com"}

class ProfileM {
  ProfileM({
      bool? error, 
      String? message,
    ProfileData? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  ProfileM.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  ProfileData? _data;
ProfileM copyWith({  bool? error,
  String? message,
  ProfileData? data,
}) => ProfileM(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  ProfileData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// name : "John Doe"
/// profile_image : "uploads/profile_pictures/700a83afd944d4dd3d4dddf9d0e21d65.png"
/// phone_number : "789658452"
/// email : "user123@gmail.com"

class ProfileData {
  ProfileData({
      String? name, 
      String? profileImage, 
      String? phoneNumber, 
      String? email,}){
    _name = name;
    _profileImage = profileImage;
    _phoneNumber = phoneNumber;
    _email = email;
}

  ProfileData.fromJson(dynamic json) {
    _name = json['name'];
    _profileImage = json['profile_image'];
    _phoneNumber = json['phone_number'];
    _email = json['email'];
  }
  String? _name;
  String? _profileImage;
  String? _phoneNumber;
  String? _email;
  ProfileData copyWith({  String? name,
  String? profileImage,
  String? phoneNumber,
  String? email,
}) => ProfileData(  name: name ?? _name,
  profileImage: profileImage ?? _profileImage,
  phoneNumber: phoneNumber ?? _phoneNumber,
  email: email ?? _email,
);
  String? get name => _name;
  String? get profileImage => _profileImage;
  String? get phoneNumber => _phoneNumber;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['profile_image'] = _profileImage;
    map['phone_number'] = _phoneNumber;
    map['email'] = _email;
    return map;
  }

}