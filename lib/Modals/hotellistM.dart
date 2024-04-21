/// error : false
/// message : "Hotel List"
/// data : [{"id":"2","main_image":"uploads/main_images/0ca15b94ab177aebd417bead09897e0c2814c9ce.jpeg","type":"1","hotel_type":"1","slug":null,"hotel_name":"IVY Resort","description":"IVY Resort is a beautiful drive in property with private parking, Very near from ISBT Shimla with inhouse restaurant facilities. We are also good for large groups.","contact":"9857151334","aadhar":"uploads/Aadhar/WhatsApp_Image_2023-03-29_at_19.58.31.jpeg","aadhar_back":"uploads/Aadhar/WhatsApp_Image_2023-03-29_at_19.58.311.jpeg","pan":"uploads/Pan/WhatsApp_Image_2023-03-29_at_19.58.31_(1).jpeg","gst":"YET TO RECIEVE","cheque":"uploads/Cheque/WhatsApp_Image_2023-03-29_at_19.58.31.jpeg","certificate":"uploads/Certificate/WhatsApp_Image_2023-03-29_at_19.58.30.jpeg","license":"uploads/License/WhatsApp_Image_2023-03-29_at_19.58.30.jpeg","address":"2 Darni ka bagicha Lalpani Shimla 4, 171004","created_at":"2023-03-29 22:39:43","updated_at":"2023-04-06 11:34:46","state":"14","city":"1262","is_top_hotel":"1","room_quantity":null,"commission":"20","google_map_link":null,"offer_price":"11995","rating":"4.75","rating_count":"4","city_name":"Shimla","state_name":"Himachal Pradesh"},{"id":"3","main_image":"uploads/main_images/Screenshot_(143)_11zon_11zon.png","type":"1","hotel_type":"2","slug":null,"hotel_name":"Pahuna Upvan ","description":"Pahuna Upvan Villa is a beautiful property in Shimla outskirts where the view from the property is fabulous and peaceful. One can get a great stay along with the delicious food and nurture their moments during vacations.","contact":"9816008075","aadhar":"uploads/Aadhar/Pahuna_Adhaar_Front.jpg","aadhar_back":"uploads/Aadhar/Adhaar_Pahuna_Back_Side.jpg","pan":"uploads/Pan/Pan_Card.jpg","gst":"YET TO RECIEVE","cheque":"uploads/Cheque/Pan_Card.jpg","certificate":"uploads/Certificate/Pahuna_Lesse_Agreement.jpg","license":"uploads/License/Pahuna_Lesse_Agreement.jpg","address":"SH 13, Plot No 13, Palenighat Juban Seoni, Near golf Course Naldera, Shimla, Himachal Pradesh 171006","created_at":"2023-03-30 22:31:12","updated_at":"2023-04-06 11:50:28","state":"14","city":"1262","is_top_hotel":"1","room_quantity":null,"commission":"20","google_map_link":null,"offer_price":"11045","rating":"4.50","rating_count":"1","city_name":"Shimla","state_name":"Himachal Pradesh"}]

class HotellistM {
  HotellistM({
      bool? error, 
      String? message, 
      List<HotellistData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  HotellistM.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(HotellistData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<HotellistData>? _data;
HotellistM copyWith({  bool? error,
  String? message,
  List<HotellistData>? data,
}) => HotellistM(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<HotellistData>? get data => _data;

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
/// main_image : "uploads/main_images/0ca15b94ab177aebd417bead09897e0c2814c9ce.jpeg"
/// type : "1"
/// hotel_type : "1"
/// slug : null
/// hotel_name : "IVY Resort"
/// description : "IVY Resort is a beautiful drive in property with private parking, Very near from ISBT Shimla with inhouse restaurant facilities. We are also good for large groups."
/// contact : "9857151334"
/// aadhar : "uploads/Aadhar/WhatsApp_Image_2023-03-29_at_19.58.31.jpeg"
/// aadhar_back : "uploads/Aadhar/WhatsApp_Image_2023-03-29_at_19.58.311.jpeg"
/// pan : "uploads/Pan/WhatsApp_Image_2023-03-29_at_19.58.31_(1).jpeg"
/// gst : "YET TO RECIEVE"
/// cheque : "uploads/Cheque/WhatsApp_Image_2023-03-29_at_19.58.31.jpeg"
/// certificate : "uploads/Certificate/WhatsApp_Image_2023-03-29_at_19.58.30.jpeg"
/// license : "uploads/License/WhatsApp_Image_2023-03-29_at_19.58.30.jpeg"
/// address : "2 Darni ka bagicha Lalpani Shimla 4, 171004"
/// created_at : "2023-03-29 22:39:43"
/// updated_at : "2023-04-06 11:34:46"
/// state : "14"
/// city : "1262"
/// is_top_hotel : "1"
/// room_quantity : null
/// commission : "20"
/// google_map_link : null
/// offer_price : "11995"
/// rating : "4.75"
/// rating_count : "4"
/// city_name : "Shimla"
/// state_name : "Himachal Pradesh"

class HotellistData {
  HotellistData({
      String? id, 
      String? mainImage, 
      String? type, 
      String? hotelType, 
      dynamic slug, 
      String? hotelName, 
      String? description, 
      String? contact, 
      String? aadhar, 
      String? aadharBack, 
      String? pan, 
      String? gst, 
      String? cheque, 
      String? certificate, 
      String? license, 
      String? address, 
      String? createdAt, 
      String? updatedAt, 
      String? state, 
      String? city, 
      String? isTopHotel, 
      dynamic roomQuantity, 
      String? commission, 
      dynamic googleMapLink, 
      String? offerPrice, 
      String? rating, 
      String? ratingCount, 
      String? cityName, 
      String? stateName,}){
    _id = id;
    _mainImage = mainImage;
    _type = type;
    _hotelType = hotelType;
    _slug = slug;
    _hotelName = hotelName;
    _description = description;
    _contact = contact;
    _aadhar = aadhar;
    _aadharBack = aadharBack;
    _pan = pan;
    _gst = gst;
    _cheque = cheque;
    _certificate = certificate;
    _license = license;
    _address = address;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _state = state;
    _city = city;
    _isTopHotel = isTopHotel;
    _roomQuantity = roomQuantity;
    _commission = commission;
    _googleMapLink = googleMapLink;
    _offerPrice = offerPrice;
    _rating = rating;
    _ratingCount = ratingCount;
    _cityName = cityName;
    _stateName = stateName;
}

  HotellistData.fromJson(dynamic json) {
    _id = json['id'];
    _mainImage = json['main_image'];
    _type = json['type'];
    _hotelType = json['hotel_type'];
    _slug = json['slug'];
    _hotelName = json['hotel_name'];
    _description = json['description'];
    _contact = json['contact'];
    _aadhar = json['aadhar'];
    _aadharBack = json['aadhar_back'];
    _pan = json['pan'];
    _gst = json['gst'];
    _cheque = json['cheque'];
    _certificate = json['certificate'];
    _license = json['license'];
    _address = json['address'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _state = json['state'];
    _city = json['city'];
    _isTopHotel = json['is_top_hotel'];
    _roomQuantity = json['room_quantity'];
    _commission = json['commission'];
    _googleMapLink = json['google_map_link'];
    _offerPrice = json['offer_price'];
    _rating = json['rating'];
    _ratingCount = json['rating_count'];
    _cityName = json['city_name'];
    _stateName = json['state_name'];
  }
  String? _id;
  String? _mainImage;
  String? _type;
  String? _hotelType;
  dynamic _slug;
  String? _hotelName;
  String? _description;
  String? _contact;
  String? _aadhar;
  String? _aadharBack;
  String? _pan;
  String? _gst;
  String? _cheque;
  String? _certificate;
  String? _license;
  String? _address;
  String? _createdAt;
  String? _updatedAt;
  String? _state;
  String? _city;
  String? _isTopHotel;
  dynamic _roomQuantity;
  String? _commission;
  dynamic _googleMapLink;
  String? _offerPrice;
  String? _rating;
  String? _ratingCount;
  String? _cityName;
  String? _stateName;
  HotellistData copyWith({  String? id,
  String? mainImage,
  String? type,
  String? hotelType,
  dynamic slug,
  String? hotelName,
  String? description,
  String? contact,
  String? aadhar,
  String? aadharBack,
  String? pan,
  String? gst,
  String? cheque,
  String? certificate,
  String? license,
  String? address,
  String? createdAt,
  String? updatedAt,
  String? state,
  String? city,
  String? isTopHotel,
  dynamic roomQuantity,
  String? commission,
  dynamic googleMapLink,
  String? offerPrice,
  String? rating,
  String? ratingCount,
  String? cityName,
  String? stateName,
}) => HotellistData(  id: id ?? _id,
  mainImage: mainImage ?? _mainImage,
  type: type ?? _type,
  hotelType: hotelType ?? _hotelType,
  slug: slug ?? _slug,
  hotelName: hotelName ?? _hotelName,
  description: description ?? _description,
  contact: contact ?? _contact,
  aadhar: aadhar ?? _aadhar,
  aadharBack: aadharBack ?? _aadharBack,
  pan: pan ?? _pan,
  gst: gst ?? _gst,
  cheque: cheque ?? _cheque,
  certificate: certificate ?? _certificate,
  license: license ?? _license,
  address: address ?? _address,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  state: state ?? _state,
  city: city ?? _city,
  isTopHotel: isTopHotel ?? _isTopHotel,
  roomQuantity: roomQuantity ?? _roomQuantity,
  commission: commission ?? _commission,
  googleMapLink: googleMapLink ?? _googleMapLink,
  offerPrice: offerPrice ?? _offerPrice,
  rating: rating ?? _rating,
  ratingCount: ratingCount ?? _ratingCount,
  cityName: cityName ?? _cityName,
  stateName: stateName ?? _stateName,
);
  String? get id => _id;
  String? get mainImage => _mainImage;
  String? get type => _type;
  String? get hotelType => _hotelType;
  dynamic get slug => _slug;
  String? get hotelName => _hotelName;
  String? get description => _description;
  String? get contact => _contact;
  String? get aadhar => _aadhar;
  String? get aadharBack => _aadharBack;
  String? get pan => _pan;
  String? get gst => _gst;
  String? get cheque => _cheque;
  String? get certificate => _certificate;
  String? get license => _license;
  String? get address => _address;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get state => _state;
  String? get city => _city;
  String? get isTopHotel => _isTopHotel;
  dynamic get roomQuantity => _roomQuantity;
  String? get commission => _commission;
  dynamic get googleMapLink => _googleMapLink;
  String? get offerPrice => _offerPrice;
  String? get rating => _rating;
  String? get ratingCount => _ratingCount;
  String? get cityName => _cityName;
  String? get stateName => _stateName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['main_image'] = _mainImage;
    map['type'] = _type;
    map['hotel_type'] = _hotelType;
    map['slug'] = _slug;
    map['hotel_name'] = _hotelName;
    map['description'] = _description;
    map['contact'] = _contact;
    map['aadhar'] = _aadhar;
    map['aadhar_back'] = _aadharBack;
    map['pan'] = _pan;
    map['gst'] = _gst;
    map['cheque'] = _cheque;
    map['certificate'] = _certificate;
    map['license'] = _license;
    map['address'] = _address;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['state'] = _state;
    map['city'] = _city;
    map['is_top_hotel'] = _isTopHotel;
    map['room_quantity'] = _roomQuantity;
    map['commission'] = _commission;
    map['google_map_link'] = _googleMapLink;
    map['offer_price'] = _offerPrice;
    map['rating'] = _rating;
    map['rating_count'] = _ratingCount;
    map['city_name'] = _cityName;
    map['state_name'] = _stateName;
    return map;
  }

}