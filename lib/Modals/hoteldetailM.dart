
class HoteldetailM {
  HoteldetailM({
      bool? error, 
      String? message,
    HotelDetailData? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  HoteldetailM.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? HotelDetailData.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  HotelDetailData? _data;
HoteldetailM copyWith({  bool? error,
  String? message,
  HotelDetailData? data,
}) => HoteldetailM(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  HotelDetailData? get data => _data;

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

class HotelDetailData {
  HotelDetailData({
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
      dynamic updatedAt,
      String? state,
      String? city,
      String? isTopHotel,
      String? roomQuantity,
      String? commission,
      String? googleMapLink,
      String? imgName,
      String? roomBooked,
      String? checkinTime,
      String? checkoutTime,
      String? mrp,
      String? offerPrice,
      String? hasKitchin,
      String? amenities,
      dynamic rating,
      String? ratingCount,
      List<Rooms>? rooms,
      List<AmenitiesIcon>? amenitiesIcon,
      List<String>? images,}){
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
    _imgName = imgName;
    _roomBooked = roomBooked;
    _checkinTime = checkinTime;
    _checkoutTime = checkoutTime;
    _mrp = mrp;
    _offerPrice = offerPrice;
    _hasKitchen = hasKitchin;
    _amenities = amenities;
    _rating = rating;
    _ratingCount = ratingCount;
    _rooms = rooms;
    _amenitiesIcon = amenitiesIcon;
    _images = images;
}

  HotelDetailData.fromJson(dynamic json) {
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
    _imgName = json['img_name'];
    _roomBooked = json['room_booked'];
    _checkinTime = json['checkin_time'];
    _checkoutTime = json['checkout_time'];
    _mrp = json['mrp'];
    _offerPrice = json['offer_price'];
    _hasKitchen=json['has_kitchen'];
    _amenities = json['amenities'];
    _rating = json['rating'];
    _ratingCount = json['rating_count'];
    if (json['rooms'] != null) {
      _rooms = [];
      json['rooms'].forEach((v) {
        _rooms?.add(Rooms.fromJson(v));
      });
    }
    if (json['amenities_icon'] != null) {
      _amenitiesIcon = [];
      json['amenities_icon'].forEach((v) {
        _amenitiesIcon?.add(AmenitiesIcon.fromJson(v));
      });
    }
    _images = json['images'] != null ? json['images'].cast<String>() : [];
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
  dynamic _updatedAt;
  String? _state;
  String? _city;
  String? _isTopHotel;
  String? _roomQuantity;
  String? _commission;
  String? _googleMapLink;
  String? _imgName;
  String? _roomBooked;
  String? _checkinTime;
  String? _checkoutTime;
  String? _mrp;
  String? _offerPrice;
  String? _hasKitchen;
  String? _amenities;
  dynamic _rating;
  String? _ratingCount;
  List<Rooms>? _rooms;
  List<AmenitiesIcon>? _amenitiesIcon;
  List<String>? _images;
  HotelDetailData copyWith({  String? id,
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
  dynamic updatedAt,
  String? state,
  String? city,
  String? isTopHotel,
  String? roomQuantity,
  String? commission,
  String? googleMapLink,
  String? imgName,
  String? roomBooked,
  String? checkinTime,
  String? checkoutTime,
  String? mrp,
  String? offerPrice,
  String? hasKitchin,
  String? amenities,
  dynamic rating,
  String? ratingCount,
  List<Rooms>? rooms,
  List<AmenitiesIcon>? amenitiesIcon,
  List<String>? images,
}) => HotelDetailData(  id: id ?? _id,
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
  imgName: imgName ?? _imgName,
  roomBooked: roomBooked ?? _roomBooked,
  checkinTime: checkinTime ?? _checkinTime,
  checkoutTime: checkoutTime ?? _checkoutTime,
  mrp: mrp ?? _mrp,
  offerPrice: offerPrice ?? _offerPrice,
  hasKitchin: hasKitchin??_hasKitchen,
  amenities: amenities ?? _amenities,
  rating: rating ?? _rating,
  ratingCount: ratingCount ?? _ratingCount,
  rooms: rooms ?? _rooms,
  amenitiesIcon: amenitiesIcon ?? _amenitiesIcon,
  images: images ?? _images,
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
  dynamic get updatedAt => _updatedAt;
  String? get state => _state;
  String? get city => _city;
  String? get isTopHotel => _isTopHotel;
  String? get roomQuantity => _roomQuantity;
  String? get commission => _commission;
  String? get googleMapLink => _googleMapLink;
  String? get imgName => _imgName;
  String? get roomBooked => _roomBooked;
  String? get checkinTime => _checkinTime;
  String? get checkoutTime => _checkoutTime;
  String? get mrp => _mrp;
  String? get offerPrice => _offerPrice;
  String? get hasKitchin => _hasKitchen;
  String? get amenities => _amenities;
  dynamic get rating => _rating;
  String? get ratingCount => _ratingCount;
  List<Rooms>? get rooms => _rooms;
  List<AmenitiesIcon>? get amenitiesIcon => _amenitiesIcon;
  List<String>? get images => _images;

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
    map['img_name'] = _imgName;
    map['room_booked'] = _roomBooked;
    map['checkin_time'] = _checkinTime;
    map['checkout_time'] = _checkoutTime;
    map['mrp'] = _mrp;
    map['offer_price'] = _offerPrice;
    map['amenities'] = _amenities;
    map['rating'] = _rating;
    map['rating_count'] = _ratingCount;
    if (_rooms != null) {
      map['rooms'] = _rooms?.map((v) => v.toJson()).toList();
    }
    if (_amenitiesIcon != null) {
      map['amenities_icon'] = _amenitiesIcon?.map((v) => v.toJson()).toList();
    }
    map['images'] = _images;
    return map;
  }

}

class AmenitiesIcon {
  AmenitiesIcon({
      String? name, 
      String? path,}){
    _name = name;
    _path = path;
}

  AmenitiesIcon.fromJson(dynamic json) {
    _name = json['name'];
    _path = json['path'];
  }
  String? _name;
  String? _path;
AmenitiesIcon copyWith({  String? name,
  String? path,
}) => AmenitiesIcon(  name: name ?? _name,
  path: path ?? _path,
);
  String? get name => _name;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['path'] = _path;
    return map;
  }

}

class Rooms {
  Rooms({
      String? id, 
      String? roomType, 
      String? hotelId, 
      String? roomName, 
      String? photos, 
      String? inclusions, 
      String? exclusions, 
      String? checkinTime, 
      String? checkoutTime, 
      String? mrp, 
      String? offerPrice, 
      String? roomSize, 
      String? washroomSize, 
      String? bedType, 
      String? washroom, 
      String? extraBedChargeable, 
      String? amenities, 
      String? createdAt, 
      dynamic updatedAt, 
      String? status, 
      String? cpMealPrice, 
      String? mapMealPrice, 
      String? apMealPrice, 
      String? roomQuantity, 
      String? roomBooked, 
      bool? allRoomsBooked, 
      List<AmenitiesIcons>? amenitiesIcons, 
      List<Pictures>? pictures, 
      num? roomsAvailable,}){
    _id = id;
    _roomType = roomType;
    _hotelId = hotelId;
    _roomName = roomName;
    _photos = photos;
    _inclusions = inclusions;
    _exclusions = exclusions;
    _checkinTime = checkinTime;
    _checkoutTime = checkoutTime;
    _mrp = mrp;
    _offerPrice = offerPrice;
    _roomSize = roomSize;
    _washroomSize = washroomSize;
    _bedType = bedType;
    _washroom = washroom;
    _extraBedChargeable = extraBedChargeable;
    _amenities = amenities;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _status = status;
    _cpMealPrice = cpMealPrice;
    _mapMealPrice = mapMealPrice;
    _apMealPrice = apMealPrice;
    _roomQuantity = roomQuantity;
    _roomBooked = roomBooked;
    _allRoomsBooked = allRoomsBooked;
    _amenitiesIcons = amenitiesIcons;
    _pictures = pictures;
    _roomsAvailable = roomsAvailable;
}

  Rooms.fromJson(dynamic json) {
    _id = json['id'];
    _roomType = json['room_type'];
    _hotelId = json['hotel_id'];
    _roomName = json['room_name'];
    _photos = json['photos'];
    _inclusions = json['inclusions'];
    _exclusions = json['exclusions'];
    _checkinTime = json['checkin_time'];
    _checkoutTime = json['checkout_time'];
    _mrp = json['mrp'];
    _offerPrice = json['offer_price'];
    _roomSize = json['room_size'];
    _washroomSize = json['washroom_size'];
    _bedType = json['bed_type'];
    _washroom = json['washroom'];
    _extraBedChargeable = json['extra_bed_chargeable'];
    _amenities = json['amenities'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _status = json['status'];
    _cpMealPrice = json['cp_meal_price'];
    _mapMealPrice = json['map_meal_price'];
    _apMealPrice = json['ap_meal_price'];
    _roomQuantity = json['room_quantity'];
    _roomBooked = json['room_booked'];
    _allRoomsBooked = json['all_rooms_booked'];
    if (json['amenities_icons'] != null) {
      _amenitiesIcons = [];
      json['amenities_icons'].forEach((v) {
        _amenitiesIcons?.add(AmenitiesIcons.fromJson(v));
      });
    }
    if (json['pictures'] != null) {
      _pictures = [];
      json['pictures'].forEach((v) {
        _pictures?.add(Pictures.fromJson(v));
      });
    }
    _roomsAvailable = 
    json['rooms_available'];
  // int.parse(json['rooms_available']);
  }
  String? _id;
  String? _roomType;
  String? _hotelId;
  String? _roomName;
  String? _photos;
  String? _inclusions;
  String? _exclusions;
  String? _checkinTime;
  String? _checkoutTime;
  String? _mrp;
  String? _offerPrice;
  String? _roomSize;
  String? _washroomSize;
  String? _bedType;
  String? _washroom;
  String? _extraBedChargeable;
  String? _amenities;
  String? _createdAt;
  dynamic _updatedAt;
  String? _status;
  String? _cpMealPrice;
  String? _mapMealPrice;
  String? _apMealPrice;
  String? _roomQuantity;
  String? _roomBooked;
  bool? _allRoomsBooked;
  List<AmenitiesIcons>? _amenitiesIcons;
  List<Pictures>? _pictures;
  num? _roomsAvailable;
Rooms copyWith({  String? id,
  String? roomType,
  String? hotelId,
  String? roomName,
  String? photos,
  String? inclusions,
  String? exclusions,
  String? checkinTime,
  String? checkoutTime,
  String? mrp,
  String? offerPrice,
  String? roomSize,
  String? washroomSize,
  String? bedType,
  String? washroom,
  String? extraBedChargeable,
  String? amenities,
  String? createdAt,
  dynamic updatedAt,
  String? status,
  String? cpMealPrice,
  String? mapMealPrice,
  String? apMealPrice,
  String? roomQuantity,
  String? roomBooked,
  bool? allRoomsBooked,
  List<AmenitiesIcons>? amenitiesIcons,
  List<Pictures>? pictures,
  num? roomsAvailable,
}) => Rooms(  id: id ?? _id,
  roomType: roomType ?? _roomType,
  hotelId: hotelId ?? _hotelId,
  roomName: roomName ?? _roomName,
  photos: photos ?? _photos,
  inclusions: inclusions ?? _inclusions,
  exclusions: exclusions ?? _exclusions,
  checkinTime: checkinTime ?? _checkinTime,
  checkoutTime: checkoutTime ?? _checkoutTime,
  mrp: mrp ?? _mrp,
  offerPrice: offerPrice ?? _offerPrice,
  roomSize: roomSize ?? _roomSize,
  washroomSize: washroomSize ?? _washroomSize,
  bedType: bedType ?? _bedType,
  washroom: washroom ?? _washroom,
  extraBedChargeable: extraBedChargeable ?? _extraBedChargeable,
  amenities: amenities ?? _amenities,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  status: status ?? _status,
  cpMealPrice: cpMealPrice ?? _cpMealPrice,
  mapMealPrice: mapMealPrice ?? _mapMealPrice,
  apMealPrice: apMealPrice ?? _apMealPrice,
  roomQuantity: roomQuantity ?? _roomQuantity,
  roomBooked: roomBooked ?? _roomBooked,
  allRoomsBooked: allRoomsBooked ?? _allRoomsBooked,
  amenitiesIcons: amenitiesIcons ?? _amenitiesIcons,
  pictures: pictures ?? _pictures,
  roomsAvailable: roomsAvailable ?? _roomsAvailable,
);
  String? get id => _id;
  String? get roomType => _roomType;
  String? get hotelId => _hotelId;
  String? get roomName => _roomName;
  String? get photos => _photos;
  String? get inclusions => _inclusions;
  String? get exclusions => _exclusions;
  String? get checkinTime => _checkinTime;
  String? get checkoutTime => _checkoutTime;
  String? get mrp => _mrp;
  String? get offerPrice => _offerPrice;
  String? get roomSize => _roomSize;
  String? get washroomSize => _washroomSize;
  String? get bedType => _bedType;
  String? get washroom => _washroom;
  String? get extraBedChargeable => _extraBedChargeable;
  String? get amenities => _amenities;
  String? get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  String? get status => _status;
  String? get cpMealPrice => _cpMealPrice;
  String? get mapMealPrice => _mapMealPrice;
  String? get apMealPrice => _apMealPrice;
  String? get roomQuantity => _roomQuantity;
  String? get roomBooked => _roomBooked;
  bool? get allRoomsBooked => _allRoomsBooked;
  List<AmenitiesIcons>? get amenitiesIcons => _amenitiesIcons;
  List<Pictures>? get pictures => _pictures;
  num? get roomsAvailable => _roomsAvailable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['room_type'] = _roomType;
    map['hotel_id'] = _hotelId;
    map['room_name'] = _roomName;
    map['photos'] = _photos;
    map['inclusions'] = _inclusions;
    map['exclusions'] = _exclusions;
    map['checkin_time'] = _checkinTime;
    map['checkout_time'] = _checkoutTime;
    map['mrp'] = _mrp;
    map['offer_price'] = _offerPrice;
    map['room_size'] = _roomSize;
    map['washroom_size'] = _washroomSize;
    map['bed_type'] = _bedType;
    map['washroom'] = _washroom;
    map['extra_bed_chargeable'] = _extraBedChargeable;
    map['amenities'] = _amenities;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['status'] = _status;
    map['cp_meal_price'] = _cpMealPrice;
    map['map_meal_price'] = _mapMealPrice;
    map['ap_meal_price'] = _apMealPrice;
    map['room_quantity'] = _roomQuantity;
    map['room_booked'] = _roomBooked;
    map['all_rooms_booked'] = _allRoomsBooked;
    if (_amenitiesIcons != null) {
      map['amenities_icons'] = _amenitiesIcons?.map((v) => v.toJson()).toList();
    }
    if (_pictures != null) {
      map['pictures'] = _pictures?.map((v) => v.toJson()).toList();
    }
    map['rooms_available'] = _roomsAvailable;
    return map;
  }

}

class Pictures {
  Pictures({
      String? path, 
      String? isPrimary, 
      String? imgName,}){
    _path = path;
    _isPrimary = isPrimary;
    _imgName = imgName;
}

  Pictures.fromJson(dynamic json) {
    _path = json['path'];
    _isPrimary = json['is_primary'];
    _imgName = json['img_name'];
  }
  String? _path;
  String? _isPrimary;
  String? _imgName;
Pictures copyWith({  String? path,
  String? isPrimary,
  String? imgName,
}) => Pictures(  path: path ?? _path,
  isPrimary: isPrimary ?? _isPrimary,
  imgName: imgName ?? _imgName,
);
  String? get path => _path;
  String? get isPrimary => _isPrimary;
  String? get imgName => _imgName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['path'] = _path;
    map['is_primary'] = _isPrimary;
    map['img_name'] = _imgName;
    return map;
  }

}

class AmenitiesIcons {
  AmenitiesIcons({
      String? name, 
      String? path,}){
    _name = name;
    _path = path;
}

  AmenitiesIcons.fromJson(dynamic json) {
    _name = json['name'];
    _path = json['path'];
  }
  String? _name;
  String? _path;
AmenitiesIcons copyWith({  String? name,
  String? path,
}) => AmenitiesIcons(  name: name ?? _name,
  path: path ?? _path,
);
  String? get name => _name;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['path'] = _path;
    return map;
  }

}