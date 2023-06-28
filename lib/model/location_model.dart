class GetPlaceById {
  List<AddressComponents>? addressComponents;
  String? adrAddress;
  String? businessStatus;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  String? placeId;
  double? rating;
  String? reference;
  List<Reviews>? reviews;
  List<String>? types;
  String? url;
  int? userRatingsTotal;
  int? utcOffset;
  String? vicinity;

  GetPlaceById(
      {this.addressComponents,
      this.adrAddress,
      this.businessStatus,
      this.formattedAddress,
      this.geometry,
      this.icon,
      this.iconBackgroundColor,
      this.iconMaskBaseUri,
      this.name,
      this.placeId,
      this.rating,
      this.reference,
      this.reviews,
      this.types,
      this.url,
      this.userRatingsTotal,
      this.utcOffset,
      this.vicinity});

  GetPlaceById.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = <AddressComponents>[];
      json['address_components'].forEach((v) {
        addressComponents!.add(AddressComponents.fromJson(v));
      });
    }
    adrAddress = json['adr_address'];
    businessStatus = json['business_status'];
    formattedAddress = json['formatted_address'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    icon = json['icon'];
    iconBackgroundColor = json['icon_background_color'];
    iconMaskBaseUri = json['icon_mask_base_uri'];
    name = json['name'];
    placeId = json['place_id'];
    rating =
        json['rating'] != null ? double.parse(json['rating'].toString()) : 0;
    reference = json['reference'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    types = json['types'].cast<String>();
    url = json['url'];
    userRatingsTotal = json['user_ratings_total'];
    utcOffset = json['utc_offset'];
    vicinity = json['vicinity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addressComponents != null) {
      data['address_components'] =
          addressComponents!.map((v) => v.toJson()).toList();
    }
    data['adr_address'] = adrAddress;
    data['business_status'] = businessStatus;
    data['formatted_address'] = formattedAddress;
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    data['icon'] = icon;
    data['icon_background_color'] = iconBackgroundColor;
    data['icon_mask_base_uri'] = iconMaskBaseUri;
    data['name'] = name;
    data['place_id'] = placeId;
    data['rating'] = rating;
    data['reference'] = reference;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    data['types'] = types;
    data['url'] = url;
    data['user_ratings_total'] = userRatingsTotal;
    data['utc_offset'] = utcOffset;
    data['vicinity'] = vicinity;
    return data;
  }
}

class AddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponents({this.longName, this.shortName, this.types});

  AddressComponents.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['long_name'] = longName;
    data['short_name'] = shortName;
    data['types'] = types;
    return data;
  }
}

class Geometry {
  LocationModel? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? LocationModel.fromJson(json['location'])
        : null;
    viewport =
        json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (viewport != null) {
      data['viewport'] = viewport!.toJson();
    }
    return data;
  }
}

class LocationModel {
  double? latitude;
  double? longitude;

  LocationModel({this.latitude, this.longitude});

  LocationModel.fromJson(Map<String, dynamic> json) {
    latitude = json['lat'];
    longitude = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = latitude;
    data['lng'] = longitude;
    return data;
  }
}

class Viewport {
  LocationModel? northeast;
  LocationModel? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? LocationModel.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? LocationModel.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (northeast != null) {
      data['northeast'] = northeast!.toJson();
    }
    if (southwest != null) {
      data['southwest'] = southwest!.toJson();
    }
    return data;
  }
}

class Reviews {
  String? authorName;
  String? authorUrl;
  String? language;
  String? profilePhotoUrl;
  int? rating;
  String? relativeTimeDescription;
  String? text;
  int? time;

  Reviews(
      {this.authorName,
      this.authorUrl,
      this.language,
      this.profilePhotoUrl,
      this.rating,
      this.relativeTimeDescription,
      this.text,
      this.time});

  Reviews.fromJson(Map<String, dynamic> json) {
    authorName = json['author_name'];
    authorUrl = json['author_url'];
    language = json['language'];
    profilePhotoUrl = json['profile_photo_url'];
    rating = json['rating'];
    relativeTimeDescription = json['relative_time_description'];
    text = json['text'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author_name'] = authorName;
    data['author_url'] = authorUrl;
    data['language'] = language;
    data['profile_photo_url'] = profilePhotoUrl;
    data['rating'] = rating;
    data['relative_time_description'] = relativeTimeDescription;
    data['text'] = text;
    data['time'] = time;
    return data;
  }
}
