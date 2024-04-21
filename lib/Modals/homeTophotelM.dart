/// error : false
/// message : "Top Hotels."
/// data : [{"id":"1","main_image":"uploads/main_images/5ceb6755f730f05aff4a5033f54b205e.jpeg","description":"qqqqqqqqqq\r\nqqqqqqqqqq","hotel_name":"Five star","address":"bhopal bus","rating":"5.0","rating_count":"2","offer_price":"1000","city":"Bhopal"}]

class HomeTophotelM {
  HomeTophotelM({
      bool? error, 
      String? message, 
      List<HomeTophotelData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  HomeTophotelM.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(HomeTophotelData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<HomeTophotelData>? _data;
HomeTophotelM copyWith({  bool? error,
  String? message,
  List<HomeTophotelData>? data,
}) => HomeTophotelM(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<HomeTophotelData>? get data => _data;

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

/// id : "1"
/// main_image : "uploads/main_images/5ceb6755f730f05aff4a5033f54b205e.jpeg"
/// description : "qqqqqqqqqq\r\nqqqqqqqqqq"
/// hotel_name : "Five star"
/// address : "bhopal bus"
/// rating : "5.0"
/// rating_count : "2"
/// offer_price : "1000"
/// city : "Bhopal"

class HomeTophotelData {
  HomeTophotelData({
      String? id, 
      String? mainImage, 
      String? description, 
      String? hotelName, 
      String? address, 
      String? rating, 
      String? ratingCount, 
      String? offerPrice, 
      String? city,}){
    _id = id;
    _mainImage = mainImage;
    _description = description;
    _hotelName = hotelName;
    _address = address;
    _rating = rating;
    _ratingCount = ratingCount;
    _offerPrice = offerPrice;
    _city = city;
}

  HomeTophotelData.fromJson(dynamic json) {
    _id = json['id'];
    _mainImage = json['main_image'];
    _description = json['description'];
    _hotelName = json['hotel_name'];
    _address = json['address'];
    _rating = json['rating'];
    _ratingCount = json['rating_count'];
    _offerPrice = json['offer_price'];
    _city = json['city'];
  }
  String? _id;
  String? _mainImage;
  String? _description;
  String? _hotelName;
  String? _address;
  String? _rating;
  String? _ratingCount;
  String? _offerPrice;
  String? _city;
  HomeTophotelData copyWith({  String? id,
  String? mainImage,
  String? description,
  String? hotelName,
  String? address,
  String? rating,
  String? ratingCount,
  String? offerPrice,
  String? city,
}) => HomeTophotelData(  id: id ?? _id,
  mainImage: mainImage ?? _mainImage,
  description: description ?? _description,
  hotelName: hotelName ?? _hotelName,
  address: address ?? _address,
  rating: rating ?? _rating,
  ratingCount: ratingCount ?? _ratingCount,
  offerPrice: offerPrice ?? _offerPrice,
  city: city ?? _city,
);
  String? get id => _id;
  String? get mainImage => _mainImage;
  String? get description => _description;
  String? get hotelName => _hotelName;
  String? get address => _address;
  String? get rating => _rating;
  String? get ratingCount => _ratingCount;
  String? get offerPrice => _offerPrice;
  String? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['main_image'] = _mainImage;
    map['description'] = _description;
    map['hotel_name'] = _hotelName;
    map['address'] = _address;
    map['rating'] = _rating;
    map['rating_count'] = _ratingCount;
    map['offer_price'] = _offerPrice;
    map['city'] = _city;
    return map;
  }

}