/// error : false
/// message : "Testimonials."
/// data : [{"id":"2","user_name":"John Doe","image":"uploads/testimonials/29f028774391ba4c4776c83160d992c7.png","description":"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).","created_at":"2023-02-25 18:56:14"},{"id":"3","user_name":"Mark Doe","image":"uploads/testimonials/77e11e8375392273920532ced44c5d0f.png","description":"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).","created_at":"2023-02-25 18:56:29"}]

class WhatpeopleM {
  WhatpeopleM({
      bool? error, 
      String? message, 
      List<WhatpeopleData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  WhatpeopleM.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(WhatpeopleData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<WhatpeopleData>? _data;
WhatpeopleM copyWith({  bool? error,
  String? message,
  List<WhatpeopleData>? data,
}) => WhatpeopleM(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<WhatpeopleData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "2"
/// user_name : "John Doe"
/// image : "uploads/testimonials/29f028774391ba4c4776c83160d992c7.png"
/// description : "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
/// created_at : "2023-02-25 18:56:14"

class WhatpeopleData {
  WhatpeopleData({
      String? id, 
      String? userName, 
      String? image, 
      String? description, 
      String? createdAt,}){
    _id = id;
    _userName = userName;
    _image = image;
    _description = description;
    _createdAt = createdAt;
}

  WhatpeopleData.fromJson(dynamic json) {
    _id = json['id'];
    _userName = json['user_name'];
    _image = json['image'];
    _description = json['description'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _userName;
  String? _image;
  String? _description;
  String? _createdAt;
  WhatpeopleData copyWith({  String? id,
  String? userName,
  String? image,
  String? description,
  String? createdAt,
}) => WhatpeopleData(  id: id ?? _id,
  userName: userName ?? _userName,
  image: image ?? _image,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get userName => _userName;
  String? get image => _image;
  String? get description => _description;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_name'] = _userName;
    map['image'] = _image;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    return map;
  }

}