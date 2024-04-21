/// error : false
/// message : "Review & Rating."
/// data : {"total_rating":1,"average":"4","reviews":[{"id":"35","user_id":"116","hotel_id":"34","description":"review testing demo\r\n","rating":"4","created_at":"2023-03-02 12:54:43","User_name":null}]}

class ReviewM {
  ReviewM({
      bool? error, 
      String? message,
    ReviewData? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  ReviewM.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? ReviewData.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  ReviewData? _data;
ReviewM copyWith({  bool? error,
  String? message,
  ReviewData? data,
}) => ReviewM(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  ReviewData? get data => _data;

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

/// total_rating : 1
/// average : "4"
/// reviews : [{"id":"35","user_id":"116","hotel_id":"34","description":"review testing demo\r\n","rating":"4","created_at":"2023-03-02 12:54:43","User_name":null}]

class ReviewData {
  ReviewData({
      num? totalRating, 
      String? average, 
      List<Reviews>? reviews,}){
    _totalRating = totalRating;
    _average = average;
    _reviews = reviews;
}

  ReviewData.fromJson(dynamic json) {
    _totalRating = json['total_rating'];
    _average = json['average'];
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(Reviews.fromJson(v));
      });
    }
  }
  num? _totalRating;
  String? _average;
  List<Reviews>? _reviews;
  ReviewData copyWith({  num? totalRating,
  String? average,
  List<Reviews>? reviews,
}) => ReviewData(  totalRating: totalRating ?? _totalRating,
  average: average ?? _average,
  reviews: reviews ?? _reviews,
);
  num? get totalRating => _totalRating;
  String? get average => _average;
  List<Reviews>? get reviews => _reviews;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_rating'] = _totalRating;
    map['average'] = _average;
    if (_reviews != null) {
      map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "35"
/// user_id : "116"
/// hotel_id : "34"
/// description : "review testing demo\r\n"
/// rating : "4"
/// created_at : "2023-03-02 12:54:43"
/// User_name : null

class Reviews {
  Reviews({
      String? id, 
      String? userId, 
      String? hotelId, 
      String? description, 
      String? rating, 
      String? createdAt, 
      dynamic userName,}){
    _id = id;
    _userId = userId;
    _hotelId = hotelId;
    _description = description;
    _rating = rating;
    _createdAt = createdAt;
    _userName = userName;
}

  Reviews.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _hotelId = json['hotel_id'];
    _description = json['description'];
    _rating = json['rating'];
    _createdAt = json['created_at'];
    _userName = json['User_name'];
  }
  String? _id;
  String? _userId;
  String? _hotelId;
  String? _description;
  String? _rating;
  String? _createdAt;
  dynamic _userName;
Reviews copyWith({  String? id,
  String? userId,
  String? hotelId,
  String? description,
  String? rating,
  String? createdAt,
  dynamic userName,
}) => Reviews(  id: id ?? _id,
  userId: userId ?? _userId,
  hotelId: hotelId ?? _hotelId,
  description: description ?? _description,
  rating: rating ?? _rating,
  createdAt: createdAt ?? _createdAt,
  userName: userName ?? _userName,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get hotelId => _hotelId;
  String? get description => _description;
  String? get rating => _rating;
  String? get createdAt => _createdAt;
  dynamic get userName => _userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['hotel_id'] = _hotelId;
    map['description'] = _description;
    map['rating'] = _rating;
    map['created_at'] = _createdAt;
    map['User_name'] = _userName;
    return map;
  }

}