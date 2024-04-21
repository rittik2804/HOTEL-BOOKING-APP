/// error : true
/// message : "Recently updated hotels."
/// data : [{"id":"14","main_image":"uploads/main_images/images_(10).jpeg","description":"yttytytytytytytytyty","hotel_name":"dsds","address":"bhopal bus ","rating":"4","rating_count":"0","offer_price":"400","city":"Bhopal"},{"id":"13","main_image":"uploads/main_images/images_(9).jpeg","description":"21212121212","hotel_name":"Five star","address":"indore bus","rating":"4","rating_count":"0","offer_price":"300","city":"Indore"},{"id":"13","main_image":"uploads/main_images/images_(9).jpeg","description":"21212121212","hotel_name":"Five star","address":"indore bus","rating":"4","rating_count":"0","offer_price":"400","city":"Indore"},{"id":"2","main_image":"uploads/main_images/d20400b127f29793e8ada9efa910753a.jpeg","description":"1.demo\r\n2.demo","hotel_name":"hotel sayaji","address":"delhi bus","rating":"4","rating_count":"1","offer_price":"200","city":"Delhi"},{"id":"1","main_image":"uploads/main_images/a27c1c7821d57d252ada5a0c2a1f7ba2.jpeg","description":"1.demo\r\n2.demo","hotel_name":"Hotel radisson","address":"bhopal bus","rating":"4.2","rating_count":"5","offer_price":"1000","city":"Bhopal"}]

class RecentHotelM {
  RecentHotelM({
      bool? error, 
      String? message, 
      List<RecentHotelData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  RecentHotelM.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RecentHotelData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<RecentHotelData>? _data;
RecentHotelM copyWith({  bool? error,
  String? message,
  List<RecentHotelData>? data,
}) => RecentHotelM(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<RecentHotelData>? get data => _data;

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

/// id : "14"
/// main_image : "uploads/main_images/images_(10).jpeg"
/// description : "yttytytytytytytytyty"
/// hotel_name : "dsds"
/// address : "bhopal bus "
/// rating : "4"
/// rating_count : "0"
/// offer_price : "400"
/// city : "Bhopal"

class RecentHotelData {
  RecentHotelData({
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

  RecentHotelData.fromJson(dynamic json) {
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
  RecentHotelData copyWith({  String? id,
  String? mainImage,
  String? description,
  String? hotelName,
  String? address,
  String? rating,
  String? ratingCount,
  String? offerPrice,
  String? city,
}) => RecentHotelData(  id: id ?? _id,
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