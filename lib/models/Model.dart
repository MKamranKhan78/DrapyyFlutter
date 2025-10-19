
// guest_response_model.dart

//-----------------------------------Guest api------------------------
import 'dart:convert';

class GuestResponsee {
  int? status;
  String? message;
  Dataa? data;

  GuestResponsee({this.status, this.message, this.data});

  factory GuestResponsee.fromJson(Map<String, dynamic> json) {
    return GuestResponsee(
      status: json['status'] is String
          ? int.tryParse(json['status'])
          : json['status'],
      message: json['message'],
      data: json['data'] != null ? Dataa.fromJson(json['data']) : null,
    );
  }
}

class Dataa {
  Userr? user;
  String? accessToken;

  Dataa({this.user, this.accessToken});

  factory Dataa.fromJson(Map<String, dynamic> json) {
    return Dataa(
      user: json['user'] != null ? Userr.fromJson(json['user']) : null,
      accessToken: json['access_token'],
    );
  }
}

class Userr {
  int? id;
  String? name;
  String? email;
  String? username;
  String? emailVerifiedAt;
  int? type;
  String? image;
  String? phoneNo;
  String? postalCode;
  String? address;
  String? city;
  String? dateOfBirth;
  int? newsletter;
  int? status;
  int? official;
  int? isApproved;
  String? guestToken;
  int? isGuest;
  String? createdAt;
  String? updatedAt;

  Userr({
    this.id,
    this.name,
    this.email,
    this.username,
    this.emailVerifiedAt,
    this.type,
    this.image,
    this.phoneNo,
    this.postalCode,
    this.address,
    this.city,
    this.dateOfBirth,
    this.newsletter,
    this.status,
    this.official,
    this.isApproved,
    this.guestToken,
    this.isGuest,
    this.createdAt,
    this.updatedAt,
  });

  factory Userr.fromJson(Map<String, dynamic> json) {
    return Userr(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      emailVerifiedAt: json['email_verified_at'],
      type: json['type'] is String ? int.tryParse(json['type']) : json['type'],
      image: json['image'],
      phoneNo: json['phone_no'],
      postalCode: json['postal_code'],
      address: json['address'],
      city: json['city'],
      dateOfBirth: json['date_of_birth'],
      newsletter: json['newsletter'] is String
          ? int.tryParse(json['newsletter'])
          : json['newsletter'],
      status: json['status'] is String
          ? int.tryParse(json['status'])
          : json['status'],
      official: json['official'] is String
          ? int.tryParse(json['official'])
          : json['official'],
      isApproved: json['is_approved'] is String
          ? int.tryParse(json['is_approved'])
          : json['is_approved'],
      guestToken: json['guest_token'],
      isGuest: json['is_guest'] is String
          ? int.tryParse(json['is_guest'])
          : json['is_guest'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}



//-----------------------------------Login api------------------------

class LoginResponseModel {
  int? status;
  String? message;
  Data? data;

  LoginResponseModel({this.status, this.message, this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'] is int
          ? json['status']
          : int.tryParse(json['status']?.toString() ?? ''),
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class Data {
  User? user;
  String? accessToken;

  Data({this.user, this.accessToken});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      accessToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'access_token': accessToken,
    };
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? username;
  String? emailVerifiedAt;
  int? type;
  String? image;
  String? phoneNo;
  String? postalCode;
  String? address;
  String? city;
  String? dateOfBirth;
  int? newsletter;
  int? status;
  int? official;
  int? isApproved;
  String? guestToken;
  int? isGuest;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.username,
    this.emailVerifiedAt,
    this.type,
    this.image,
    this.phoneNo,
    this.postalCode,
    this.address,
    this.city,
    this.dateOfBirth,
    this.newsletter,
    this.status,
    this.official,
    this.isApproved,
    this.guestToken,
    this.isGuest,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? ''),
      name: json['name'],
      email: json['email'],
      username: json['username'],
      emailVerifiedAt: json['email_verified_at'],
      type: json['type'] is int ? json['type'] : int.tryParse(json['type']?.toString() ?? ''),
      image: json['image'],
      phoneNo: json['phone_no'],
      postalCode: json['postal_code'],
      address: json['address'],
      city: json['city'],
      dateOfBirth: json['date_of_birth'],
      newsletter: json['newsletter'] is int
          ? json['newsletter']
          : int.tryParse(json['newsletter']?.toString() ?? ''),
      status: json['status'] is int
          ? json['status']
          : int.tryParse(json['status']?.toString() ?? ''),
      official: json['official'] is int
          ? json['official']
          : int.tryParse(json['official']?.toString() ?? ''),
      isApproved: json['is_approved'] is int
          ? json['is_approved']
          : int.tryParse(json['is_approved']?.toString() ?? ''),
      guestToken: json['guest_token'],
      isGuest: json['is_guest'] is int
          ? json['is_guest']
          : int.tryParse(json['is_guest']?.toString() ?? ''),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'email_verified_at': emailVerifiedAt,
      'type': type,
      'image': image,
      'phone_no': phoneNo,
      'postal_code': postalCode,
      'address': address,
      'city': city,
      'date_of_birth': dateOfBirth,
      'newsletter': newsletter,
      'status': status,
      'official': official,
      'is_approved': isApproved,
      'guest_token': guestToken,
      'is_guest': isGuest,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

//-----------------------------------Registration api------------------------

class RegistrationModel {
  int? status;
  String? message;
  DataReg? data;

  RegistrationModel({this.status, this.message, this.data});

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      status: json['status'] is String
          ? int.tryParse(json['status'])
          : json['status'],
      message: json['message'],
      data: json['data'] != null ? DataReg.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }

  static RegistrationModel fromJsonString(String str) =>
      RegistrationModel.fromJson(json.decode(str));

  String toJsonString() => json.encode(toJson());
}

class DataReg {
  UserReg? user;
  String? accessToken;

  DataReg({this.user, this.accessToken});

  factory DataReg.fromJson(Map<String, dynamic> json) {
    return DataReg(
      user: json['user'] != null ? UserReg.fromJson(json['user']) : null,
      accessToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'access_token': accessToken,
    };
  }
}

class UserReg {
  String? name;
  String? email;
  String? username;
  String? phoneNo;
  String? address;
  String? dateOfBirth;
  String? city;
  String? postalCode;
  int? newsletter;
  String? updatedAt;
  String? createdAt;
  int? id;

  UserReg({
    this.name,
    this.email,
    this.username,
    this.phoneNo,
    this.address,
    this.dateOfBirth,
    this.city,
    this.postalCode,
    this.newsletter,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory UserReg.fromJson(Map<String, dynamic> json) {
    return UserReg(
      name: json['name'],
      email: json['email'],
      username: json['username'],
      phoneNo: json['phone_no'],
      address: json['address'],
      dateOfBirth: json['date_of_birth'],
      city: json['city'],
      postalCode: json['postal_code'],
      newsletter: json['newsletter'] is String
          ? int.tryParse(json['newsletter'])
          : json['newsletter'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'username': username,
      'phone_no': phoneNo,
      'address': address,
      'date_of_birth': dateOfBirth,
      'city': city,
      'postal_code': postalCode,
      'newsletter': newsletter,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}


//-----------------------------------Home Response---------------------------
class GetHomeModelResponsee {
  int? status;
  String? message;
  DataHomee? data;

  GetHomeModelResponsee({this.status, this.message, this.data});

  GetHomeModelResponsee.fromJson(Map<String, dynamic> json) {
    status = _toInt(json['status']);
    message = json['message']?.toString();
    data = json['data'] != null ? DataHomee.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class DataHomee {
  List<CategoryHomee>? categories;
  List<BannerHomee>? banners;
  List<PartnerHomee>? partners;
  List<CategoryProductHomee>? categoryProducts;
  List<ProductHomee>? products;

  DataHomee(
      {this.categories,
        this.banners,
        this.partners,
        this.categoryProducts,
        this.products});

  DataHomee.fromJson(Map<String, dynamic> json) {
    categories = _toList(json['categories'], (v) => CategoryHomee.fromJson(v));
    banners = _toList(json['banners'], (v) => BannerHomee.fromJson(v));
    partners = _toList(json['partners'], (v) => PartnerHomee.fromJson(v));
    categoryProducts =
        _toList(json['category_products'], (v) => CategoryProductHomee.fromJson(v));
    products = _toList(json['products'], (v) => ProductHomee.fromJson(v));
  }

  Map<String, dynamic> toJson() => {
    'categories': categories?.map((v) => v.toJson()).toList(),
    'banners': banners?.map((v) => v.toJson()).toList(),
    'partners': partners?.map((v) => v.toJson()).toList(),
    'category_products': categoryProducts?.map((v) => v.toJson()).toList(),
    'products': products?.map((v) => v.toJson()).toList(),
  };
}

class CategoryHomee {
  int? id;
  String? name;
  String? image;
  String? imagePath;

  CategoryHomee({this.id, this.name, this.image, this.imagePath});

  CategoryHomee.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    name = json['name']?.toString();
    image = json['image']?.toString();
    imagePath = json['imagePath']?.toString();
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'imagePath': imagePath,
  };
}

class BannerHomee {
  int? id;
  String? image;
  String? imagePath;
  String? imageMobilePath;

  BannerHomee({this.id, this.image, this.imagePath, this.imageMobilePath});

  BannerHomee.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    image = json['image']?.toString();
    imagePath = json['image_path']?.toString();
    imageMobilePath = json['image_mobile_path']?.toString();
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'image_path': imagePath,
    'image_mobile_path': imageMobilePath,
  };
}

class PartnerHomee {
  int? id;
  String? name;
  String? email;
  String? username;
  String? emailVerifiedAt;
  int? type;
  String? image;
  String? phoneNo;
  String? address;
  String? city;
  String? dateOfBirth;
  String? postalCode;
  int? merchantId;
  String? cnic;
  String? bankName;
  String? bankAccountTitle;
  String? bankAccountNumber;
  String? facebookLink;
  String? instagramLink;
  String? tiktokLink;
  int? newsletter;
  int? official;
  int? status;
  int? isApproved;
  String? guestToken;
  int? isGuest;
  String? createdAt;
  String? updatedAt;
  String? gUserId;
  String? imagePath;
  String? imageUrl;
  int? walletAmount;
  String? wallet;

  PartnerHomee({
    this.id,
    this.name,
    this.email,
    this.username,
    this.emailVerifiedAt,
    this.type,
    this.image,
    this.phoneNo,
    this.address,
    this.city,
    this.dateOfBirth,
    this.postalCode,
    this.merchantId,
    this.cnic,
    this.bankName,
    this.bankAccountTitle,
    this.bankAccountNumber,
    this.facebookLink,
    this.instagramLink,
    this.tiktokLink,
    this.newsletter,
    this.official,
    this.status,
    this.isApproved,
    this.guestToken,
    this.isGuest,
    this.createdAt,
    this.updatedAt,
    this.gUserId,
    this.imagePath,
    this.imageUrl,
    this.walletAmount,
    this.wallet,
  });

  PartnerHomee.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    name = json['name']?.toString();
    email = json['email']?.toString();
    username = json['username']?.toString();
    emailVerifiedAt = json['emailVerifiedAt']?.toString();
    type = _toInt(json['type']);
    image = json['image']?.toString();
    phoneNo = json['phoneNo']?.toString();
    address = json['address']?.toString();
    city = json['city']?.toString();
    dateOfBirth = json['dateOfBirth']?.toString();
    postalCode = json['postalCode']?.toString();
    merchantId = _toInt(json['merchantId']);
    cnic = json['cnic']?.toString();
    bankName = json['bankName']?.toString();
    bankAccountTitle = json['bankAccountTitle']?.toString();
    bankAccountNumber = json['bankAccountNumber']?.toString();
    facebookLink = json['facebookLink']?.toString();
    instagramLink = json['instagramLink']?.toString();
    tiktokLink = json['tiktokLink']?.toString();
    newsletter = _toInt(json['newsletter']);
    official = _toInt(json['official']);
    status = _toInt(json['status']);
    isApproved = _toInt(json['isApproved']);
    guestToken = json['guestToken']?.toString();
    isGuest = _toInt(json['isGuest']);
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    gUserId = json['gUserId']?.toString();
    imagePath = json['image_path']?.toString();
    imageUrl = json['imageUrl']?.toString();
    walletAmount = _toInt(json['walletAmount']);
    wallet = json['wallet']?.toString();
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'username': username,
    'emailVerifiedAt': emailVerifiedAt,
    'type': type,
    'image': image,
    'phoneNo': phoneNo,
    'address': address,
    'city': city,
    'dateOfBirth': dateOfBirth,
    'postalCode': postalCode,
    'merchantId': merchantId,
    'cnic': cnic,
    'bankName': bankName,
    'bankAccountTitle': bankAccountTitle,
    'bankAccountNumber': bankAccountNumber,
    'facebookLink': facebookLink,
    'instagramLink': instagramLink,
    'tiktokLink': tiktokLink,
    'newsletter': newsletter,
    'official': official,
    'status': status,
    'isApproved': isApproved,
    'guestToken': guestToken,
    'isGuest': isGuest,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'gUserId': gUserId,
    'image_path': imagePath,
    'imageUrl': imageUrl,
    'walletAmount': walletAmount,
    'wallet': wallet,
  };
}

class CategoryProductHomee {
  int? id;
  String? barcode;
  int? merchantId;
  String? name;
  String? slug;
  String? brand;
  String? productType;
  int? isVariant;
  String? keyWords;
  String? description;
  String? summary;
  String? sizes;
  String? colors;
  String? type;
  int? isFeatured;
  int? price;
  int? offerPrice;
  int? quantity;
  String? image;
  String? sizeGuide;
  double? weight;
  List<String>? images;
  int? brandId;
  int? categoryLevel1Id;
  int? categoryLevel2Id;
  int? categoryLevel3Id;
  int? categoryLevel4Id;
  String? updatedBy;
  String? deletedBy;
  String? brandName;
  int? isApproved;
  int? isWishlist;
  int? noOfOrders;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  VariantHomee? variant;
  String? imageUrl;
  List<String>? imagesUrl;

  CategoryProductHomee.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    barcode = json['barcode']?.toString();
    merchantId = _toInt(json['merchantId']);
    name = json['name']?.toString();
    slug = json['slug']?.toString();
    brand = json['brand']?.toString();
    productType = json['productType']?.toString();
    isVariant = _toInt(json['isVariant']);
    keyWords = json['keyWords']?.toString();
    description = json['description']?.toString();
    summary = json['summary']?.toString();
    sizes = json['sizes']?.toString();
    colors = json['colors']?.toString();
    type = json['type']?.toString();
    isFeatured = _toInt(json['isFeatured']);
    price = _toInt(json['price']);
    offerPrice = _toInt(json['offer_price']);
    quantity = _toInt(json['quantity']);
    image = json['image']?.toString();
    sizeGuide = json['sizeGuide']?.toString();
    weight = _toDouble(json['weight']);
    images = _toStringList(json['images']);
    brandId = _toInt(json['brandId']);
    categoryLevel1Id = _toInt(json['categoryLevel1Id']);
    categoryLevel2Id = _toInt(json['categoryLevel2Id']);
    categoryLevel3Id = _toInt(json['categoryLevel3Id']);
    categoryLevel4Id = _toInt(json['categoryLevel4Id']);
    updatedBy = json['updatedBy']?.toString();
    deletedBy = json['deletedBy']?.toString();
    brandName = json['brand_name']?.toString();
    isApproved = _toInt(json['isApproved']);
    isWishlist = _toInt(json['is_wishlist']);
    noOfOrders = _toInt(json['noOfOrders']);
    deletedAt = json['deletedAt']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    variant = json['variant'] != null ? VariantHomee.fromJson(json['variant']) : null;
    imageUrl = json['image_url']?.toString();
    imagesUrl = _toStringList(json['imagesUrl']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'barcode': barcode,
    'merchantId': merchantId,
    'name': name,
    'slug': slug,
    'brand': brand,
    'productType': productType,
    'isVariant': isVariant,
    'keyWords': keyWords,
    'description': description,
    'summary': summary,
    'sizes': sizes,
    'colors': colors,
    'type': type,
    'isFeatured': isFeatured,
    'price': price,
    'offer_price': offerPrice,
    'quantity': quantity,
    'image': image,
    'sizeGuide': sizeGuide,
    'weight': weight,
    'images': images,
    'brandId': brandId,
    'categoryLevel1Id': categoryLevel1Id,
    'categoryLevel2Id': categoryLevel2Id,
    'categoryLevel3Id': categoryLevel3Id,
    'categoryLevel4Id': categoryLevel4Id,
    'updatedBy': updatedBy,
    'deletedBy': deletedBy,
    'brand_name': brandName,
    'isApproved': isApproved,
    'is_wishlist': isWishlist,
    'noOfOrders': noOfOrders,
    'deletedAt': deletedAt,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'variant': variant?.toJson(),
    'image_url': imageUrl,
    'imagesUrl': imagesUrl,
  };
}


class ProductHomee {
  int? id;
  String? barcode;
  int? merchantId;
  String? name;
  String? slug;
  String? brand;
  String? productType;
  int? isVariant;
  String? keyWords;
  String? description;
  String? summary;
  String? sizes;
  String? colors;
  String? type;
  int? isFeatured;
  int? price;
  int? offerPrice;
  int? quantity;
  String? image;
  String? sizeGuide;
  double? weight;
  List<String>? images;
  int? brandId;
  int? categoryLevel1Id;
  int? categoryLevel2Id;
  int? categoryLevel3Id;
  int? categoryLevel4Id;
  String? updatedBy;
  String? deletedBy;
  String? brandName;
  int? isApproved;
  int? isWishlist;
  int? noOfOrders;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  VariantHomee? variant;
  String? imageUrl;
  List<String>? imagesUrl;

  ProductHomee.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    barcode = json['barcode']?.toString();
    merchantId = _toInt(json['merchantId']);
    name = json['name']?.toString();
    slug = json['slug']?.toString();
    brand = json['brand']?.toString();
    productType = json['productType']?.toString();
    isVariant = _toInt(json['isVariant']);
    keyWords = json['keyWords']?.toString();
    description = json['description']?.toString();
    summary = json['summary']?.toString();
    sizes = json['sizes']?.toString();
    colors = json['colors']?.toString();
    type = json['type']?.toString();
    isFeatured = _toInt(json['isFeatured']);
    price = _toInt(json['price']);
    offerPrice = _toInt(json['offer_price']);
    quantity = _toInt(json['quantity']);
    image = json['image']?.toString();
    sizeGuide = json['sizeGuide']?.toString();
    weight = _toDouble(json['weight']);
    images = _toStringList(json['images']);
    brandId = _toInt(json['brandId']);
    categoryLevel1Id = _toInt(json['categoryLevel1Id']);
    categoryLevel2Id = _toInt(json['categoryLevel2Id']);
    categoryLevel3Id = _toInt(json['categoryLevel3Id']);
    categoryLevel4Id = _toInt(json['categoryLevel4Id']);
    updatedBy = json['updatedBy']?.toString();
    deletedBy = json['deletedBy']?.toString();
    brandName = json['brand_name']?.toString();
    isApproved = _toInt(json['isApproved']);
    isWishlist = _toInt(json['is_wishlist']);
    noOfOrders = _toInt(json['noOfOrders']);
    deletedAt = json['deletedAt']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    variant = json['variant'] != null ? VariantHomee.fromJson(json['variant']) : null;
    imageUrl = json['image_url']?.toString();
    imagesUrl = _toStringList(json['imagesUrl']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'barcode': barcode,
    'merchantId': merchantId,
    'name': name,
    'slug': slug,
    'brand': brand,
    'productType': productType,
    'isVariant': isVariant,
    'keyWords': keyWords,
    'description': description,
    'summary': summary,
    'sizes': sizes,
    'colors': colors,
    'type': type,
    'isFeatured': isFeatured,
    'price': price,
    'offer_price': offerPrice,
    'quantity': quantity,
    'image': image,
    'sizeGuide': sizeGuide,
    'weight': weight,
    'images': images,
    'brandId': brandId,
    'categoryLevel1Id': categoryLevel1Id,
    'categoryLevel2Id': categoryLevel2Id,
    'categoryLevel3Id': categoryLevel3Id,
    'categoryLevel4Id': categoryLevel4Id,
    'updatedBy': updatedBy,
    'deletedBy': deletedBy,
    'brand_name': brandName,
    'isApproved': isApproved,
    'is_wishlist': isWishlist,
    'noOfOrders': noOfOrders,
    'deletedAt': deletedAt,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'variant': variant?.toJson(),
    'image_url': imageUrl,
    'imagesUrl': imagesUrl,
  };
}



class VariantHomee {
  int? id;
  int? size;
  int? color;
  int? price;
  int? offerPrice;
  int? isAvailable;
  int? quantity;

  VariantHomee(
      {this.id,
        this.size,
        this.color,
        this.price,
        this.offerPrice,
        this.isAvailable,
        this.quantity});

  VariantHomee.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']);
    size = _toInt(json['size']);
    color = _toInt(json['color']);
    price = _toInt(json['price']);
    offerPrice = _toInt(json['offer_price']);
    isAvailable = _toInt(json['isAvailable']);
    quantity = _toInt(json['quantity']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'size': size,
    'color': color,
    'price': price,
    'offer_price': offerPrice,
    'isAvailable': isAvailable,
    'quantity': quantity,
  };
}




//-------------------------Home Cat Product----------------------------

class GetCategoryHomeModelResponse {
  int? status;
  String? message;
  DataCat? data;

  GetCategoryHomeModelResponse({
    this.status,
    this.message,
    this.data,
  });

  factory GetCategoryHomeModelResponse.fromJson(Map<String, dynamic> json) {
    return GetCategoryHomeModelResponse(
      status: json['status'] is String
          ? int.tryParse(json['status'])
          : json['status'],
      message: json['message'],
      data: json['data'] != null ? DataCat.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class DataCat {
  List<CategoryProductHomee>? categoryProducts;

  DataCat({
    this.categoryProducts,
  });

  factory DataCat.fromJson(Map<String, dynamic> json) {
    return DataCat(
      categoryProducts: json['category_products'] != null
          ? List<CategoryProductHomee>.from(
          json['category_products'].map((x) => CategoryProductHomee.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_products':
      categoryProducts?.map((x) => x.toJson()).toList() ?? [],
    };
  }
}


/// ---------- Helper Functions ----------
int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

List<T>? _toList<T>(dynamic list, T Function(dynamic) fromJson) {
  if (list is List) {
    return list.map((e) => fromJson(e)).toList();
  }
  return null;
}

List<String>? _toStringList(dynamic list) {
  if (list is List) {
    return list.map((e) => e.toString()).toList();
  }
  return null;
}


//-------------------------------------Get All Carts--------------------------

class GetAllCartsResponsee {
  int? status;
  String? message;
  DataGetCartt? data;

  GetAllCartsResponsee({this.status, this.message, this.data});

  factory GetAllCartsResponsee.fromJson(Map<String, dynamic> json) {
    return GetAllCartsResponsee(
      status: json['status'] is String ? int.tryParse(json['status']) : json['status'],
      message: json['message'],
      data: json['data'] != null ? DataGetCartt.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class DataGetCartt {
  List<Cartt>? carts;
  Calculationss? calculations;

  DataGetCartt({this.carts, this.calculations});

  factory DataGetCartt.fromJson(Map<String, dynamic> json) {
    return DataGetCartt(
      carts: (json['carts'] as List?)
          ?.map((e) => Cartt.fromJson(e as Map<String, dynamic>))
          .toList(),
      calculations: json['calculations'] != null
          ? Calculationss.fromJson(json['calculations'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'carts': carts?.map((e) => e.toJson()).toList(),
    'calculations': calculations?.toJson(),
  };
}

class Cartt {
  int? id;
  int? userId;
  int? productId;
  int? variationId;
  int? merchantId;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  String? affiliateCode;
  ProductCartt? product;
  Variationn? variation;

  Cartt({
    this.id,
    this.userId,
    this.productId,
    this.variationId,
    this.merchantId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.affiliateCode,
    this.product,
    this.variation,
  });

  factory Cartt.fromJson(Map<String, dynamic> json) {
    return Cartt(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      userId: json['user_id'] is String ? int.tryParse(json['user_id']) : json['user_id'],
      productId: json['product_id'] is String ? int.tryParse(json['product_id']) : json['product_id'],
      variationId: json['variation_id'] is String ? int.tryParse(json['variation_id']) : json['variation_id'],
      merchantId: json['merchant_id'] is String ? int.tryParse(json['merchant_id']) : json['merchant_id'],
      quantity: json['quantity'] is String ? int.tryParse(json['quantity']) : json['quantity'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      affiliateCode: json['affiliate_code'],
      product: json['product'] != null ? ProductCartt.fromJson(json['product']) : null,
      variation: json['variation'] != null ? Variationn.fromJson(json['variation']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'product_id': productId,
    'variation_id': variationId,
    'merchant_id': merchantId,
    'quantity': quantity,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'affiliate_code': affiliateCode,
    'product': product?.toJson(),
    'variation': variation?.toJson(),
  };
}

class ProductCartt {
  int? id;
  String? name;
  int? merchantId;
  String? image;
  List<String>? images;
  VariantCartt? variant;
  String? imageUrl;
  List<String>? imagesUrl;
  int? isWishlist;
  String? brandName;

  ProductCartt({
    this.id,
    this.name,
    this.merchantId,
    this.image,
    this.images,
    this.variant,
    this.imageUrl,
    this.imagesUrl,
    this.isWishlist,
    this.brandName,
  });

  factory ProductCartt.fromJson(Map<String, dynamic> json) {
    return ProductCartt(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      name: json['name'],
      merchantId: json['merchant_id'] is String ? int.tryParse(json['merchant_id']) : json['merchant_id'],
      image: json['image'],
      images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      variant: json['variant'] != null ? VariantCartt.fromJson(json['variant']) : null,
      imageUrl: json['image_url'],
      imagesUrl: (json['images_url'] as List?)?.map((e) => e.toString()).toList(),
      isWishlist: json['is_wishlist'] is String ? int.tryParse(json['is_wishlist']) : json['is_wishlist'],
      brandName: json['brand_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'merchant_id': merchantId,
    'image': image,
    'images': images,
    'variant': variant?.toJson(),
    'image_url': imageUrl,
    'images_url': imagesUrl,
    'is_wishlist': isWishlist,
    'brand_name': brandName,
  };
}

class VariantCartt {
  int? id;
  int? size;
  String? sizeName;
  int? color;
  String? colorName;
  String? price;
  String? offerPrice;
  int? isAvailable;
  int? quantity;

  VariantCartt({
    this.id,
    this.size,
    this.sizeName,
    this.color,
    this.colorName,
    this.price,
    this.offerPrice,
    this.isAvailable,
    this.quantity,
  });

  factory VariantCartt.fromJson(Map<String, dynamic> json) {
    return VariantCartt(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      size: json['size'] is String ? int.tryParse(json['size']) : json['size'],
      sizeName: json['size_name'],
      color: json['color'] is String ? int.tryParse(json['color']) : json['color'],
      colorName: json['color_name'],
      price: json['price']?.toString(),
      offerPrice: json['offer_price']?.toString(),
      isAvailable: json['is_available'] is String ? int.tryParse(json['is_available']) : json['is_available'],
      quantity: json['quantity'] is String ? int.tryParse(json['quantity']) : json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'size': size,
    'size_name': sizeName,
    'color': color,
    'color_name': colorName,
    'price': price,
    'offer_price': offerPrice,
    'is_available': isAvailable,
    'quantity': quantity,
  };
}

class Variationn {
  int? id;
  int? productId;
  int? size;
  int? color;
  int? price;
  int? offerPrice;
  int? quantity;
  int? isAvailable;
  String? createdAt;
  String? updatedAt;
  String? colorName;
  String? hexCode;
  String? sizeName;

  Variationn({
    this.id,
    this.productId,
    this.size,
    this.color,
    this.price,
    this.offerPrice,
    this.quantity,
    this.isAvailable,
    this.createdAt,
    this.updatedAt,
    this.colorName,
    this.hexCode,
    this.sizeName,
  });

  factory Variationn.fromJson(Map<String, dynamic> json) {
    return Variationn(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      productId: json['product_id'] is String ? int.tryParse(json['product_id']) : json['product_id'],
      size: json['size'] is String ? int.tryParse(json['size']) : json['size'],
      color: json['color'] is String ? int.tryParse(json['color']) : json['color'],
      price: json['price'] is String ? int.tryParse(json['price']) : json['price'],
      offerPrice: json['offer_price'] is String ? int.tryParse(json['offer_price']) : json['offer_price'],
      quantity: json['quantity'] is String ? int.tryParse(json['quantity']) : json['quantity'],
      isAvailable: json['is_available'] is String ? int.tryParse(json['is_available']) : json['is_available'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      colorName: json['color_name'],
      hexCode: json['hex_code'],
      sizeName: json['size_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_id': productId,
    'size': size,
    'color': color,
    'price': price,
    'offer_price': offerPrice,
    'quantity': quantity,
    'is_available': isAvailable,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'color_name': colorName,
    'hex_code': hexCode,
    'size_name': sizeName,
  };
}

class Calculationss {
  String? grossTotal;
  String? discountt;
  String? shippingAmount;
  String? grandTotal;

  Calculationss({
    this.grossTotal,
    this.discountt,
    this.shippingAmount,
    this.grandTotal,
  });

  factory Calculationss.fromJson(Map<String, dynamic> json) {
    return Calculationss(
      grossTotal: json['gross_total']?.toString(),
      discountt: json['discountt']?.toString(),
      shippingAmount: json['shipping_amount']?.toString(),
      grandTotal: json['grand_total']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'gross_total': grossTotal,
    'discountt': discountt,
    'shipping_amount': shippingAmount,
    'grand_total': grandTotal,
  };
}

//------------------------------------Wishlist Model---------------------------

class GetWishlistResponse {
  int? status;
  String? message;
  DataWishlist? data;

  GetWishlistResponse({this.status, this.message, this.data});

  // ✅ Factory constructor — must start with 'factory'
  factory GetWishlistResponse.fromJson(Map<String, dynamic> json) {
    return GetWishlistResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? DataWishlist.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class DataWishlist {
  List<ProductHomee>? products;

  DataWishlist({this.products});

  factory DataWishlist.fromJson(Map<String, dynamic> json) => DataWishlist(
    products: (json['products'] as List?)
        ?.map((e) => ProductHomee.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'products': products?.map((e) => e.toJson()).toList(),
  };
}


class GetVoucherlistResponse {
  int? status;
  String? message;
  VoucherData? data;

  GetVoucherlistResponse({this.status, this.message, this.data});

  factory GetVoucherlistResponse.fromJson(Map<String, dynamic> json) =>
      GetVoucherlistResponse(
        status: json['status'] as int?,
        message: json['message'] as String?,
        data: json['data'] != null
            ? VoucherData.fromJson(json['data'])
            : null,
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class VoucherData {
  List<Voucher>? vouchers;

  VoucherData({this.vouchers});

  factory VoucherData.fromJson(Map<String, dynamic> json) => VoucherData(
    vouchers: (json['vouchers'] as List?)
        ?.map((e) => Voucher.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'vouchers': vouchers?.map((e) => e.toJson()).toList(),
  };
}

class Voucher {
  int? id;
  String? title;
  String? code;
  int? discount;
  int? maxAmount;
  String? startAt;
  String? endAt;
  int? customerId;
  int? status;
  String? createdAt;
  String? updatedAt;

  Voucher({
    this.id,
    this.title,
    this.code,
    this.discount,
    this.maxAmount,
    this.startAt,
    this.endAt,
    this.customerId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
    id: json['id'] as int?,
    title: json['title'] as String?,
    code: json['code'] as String?,
    discount: json['discount'] as int?,
    maxAmount: json['maxAmount'] as int?,
    startAt: json['startAt'] as String?,
    endAt: json['endAt'] as String?,
    customerId: json['customerId'] as int?,
    status: json['status'] as int?,
    createdAt: json['createdAt'] as String?,
    updatedAt: json['updatedAt'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'code': code,
    'discount': discount,
    'maxAmount': maxAmount,
    'startAt': startAt,
    'endAt': endAt,
    'customerId': customerId,
    'status': status,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}

class AvailPointsListResponse {
  int? status;
  String? message;
  VoucherPointsData? data;

  AvailPointsListResponse({this.status, this.message, this.data});

  factory AvailPointsListResponse.fromJson(Map<String, dynamic> json) =>
      AvailPointsListResponse(
        status: json['status'] as int?,
        message: json['message'] as String?,
        data: json['data'] != null
            ? VoucherPointsData.fromJson(json['data'])
            : null,
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class VoucherPointsData {
  List<AvailPoint>? availPoints;

  VoucherPointsData({this.availPoints});

  factory VoucherPointsData.fromJson(Map<String, dynamic> json) =>
      VoucherPointsData(
        availPoints: (json['avail_points'] as List?)
            ?.map((e) => AvailPoint.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'avail_points': availPoints?.map((e) => e.toJson()).toList(),
  };
}

class AvailPoint {
  int? amount;
  int? points;

  AvailPoint({this.amount, this.points});

  factory AvailPoint.fromJson(Map<String, dynamic> json) => AvailPoint(
    amount: json['amount'] as int?,
    points: json['points'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'points': points,
  };
}

class MyFollowersResponse {
  int? status;
  String? message;
  DataaWish? data;

  MyFollowersResponse({this.status, this.message, this.data});

  factory MyFollowersResponse.fromJson(Map<String, dynamic> json) =>
      MyFollowersResponse(
        status: json['status'] as int?,
        message: json['message'] as String?,
        data: json['data'] != null ? DataaWish.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class DataaWish {
  List<MyFollower>? myFollowes;

  DataaWish({this.myFollowes});

  factory DataaWish.fromJson(Map<String, dynamic> json) => DataaWish(
    myFollowes: (json['my_followes'] as List?)
        ?.map((e) => MyFollower.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'my_followes': myFollowes?.map((e) => e.toJson()).toList(),
  };
}

class MyFollower {
  int? id;
  int? merchantId;
  int? followerId;
  String? createdAt;
  String? updatedAt;
  Merchantt? merchant;

  MyFollower({
    this.id,
    this.merchantId,
    this.followerId,
    this.createdAt,
    this.updatedAt,
    this.merchant,
  });

  factory MyFollower.fromJson(Map<String, dynamic> json) => MyFollower(
    id: json['id'] as int?,
    merchantId: json['merchant_id'] as int?,
    followerId: json['follower_id'] as int?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    merchant: json['merchant'] != null
        ? Merchantt.fromJson(json['merchant'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'merchant_id': merchantId,
    'follower_id': followerId,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'merchant': merchant?.toJson(),
  };
}

class Merchantt {
  int? id;
  String? name;
  String? email;
  String? username;
  String? emailVerifiedAt;
  int? type;
  String? image;
  String? phoneNo;
  String? address;
  String? city;
  String? dateOfBirth;
  String? postalCode;
  int? merchantId;
  String? cnic;
  String? bankName;
  String? bankAccountTitle;
  String? bankAccountNumber;
  String? facebookLink;
  String? instagramLink;
  String? tiktokLink;
  int? newsletter;
  int? official;
  int? status;
  int? isApproved;
  String? guestToken;
  int? isGuest;
  String? createdAt;
  String? updatedAt;
  String? gUserId;
  String? imagePath;
  int? walletAmount;
  MerchantProfile? merchantProfile;
  dynamic wallet;

  Merchantt({
    this.id,
    this.name,
    this.email,
    this.username,
    this.emailVerifiedAt,
    this.type,
    this.image,
    this.phoneNo,
    this.address,
    this.city,
    this.dateOfBirth,
    this.postalCode,
    this.merchantId,
    this.cnic,
    this.bankName,
    this.bankAccountTitle,
    this.bankAccountNumber,
    this.facebookLink,
    this.instagramLink,
    this.tiktokLink,
    this.newsletter,
    this.official,
    this.status,
    this.isApproved,
    this.guestToken,
    this.isGuest,
    this.createdAt,
    this.updatedAt,
    this.gUserId,
    this.imagePath,
    this.walletAmount,
    this.merchantProfile,
    this.wallet,
  });

  factory Merchantt.fromJson(Map<String, dynamic> json) => Merchantt(
    id: json['id'] as int?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    username: json['username'] as String?,
    emailVerifiedAt: json['email_verified_at'] as String?,
    type: json['type'] as int?,
    image: json['image'] as String?,
    phoneNo: json['phone_no'] as String?,
    address: json['address'] as String?,
    city: json['city'] as String?,
    dateOfBirth: json['date_of_birth'] as String?,
    postalCode: json['postal_code'] as String?,
    merchantId: json['merchant_id'] as int?,
    cnic: json['cnic'] as String?,
    bankName: json['bank_name'] as String?,
    bankAccountTitle: json['bank_account_title'] as String?,
    bankAccountNumber: json['bank_account_number'] as String?,
    facebookLink: json['facebook_link'] as String?,
    instagramLink: json['instagram_link'] as String?,
    tiktokLink: json['tiktok_link'] as String?,
    newsletter: json['newsletter'] as int?,
    official: json['official'] as int?,
    status: json['status'] as int?,
    isApproved: json['is_approved'] as int?,
    guestToken: json['guest_token'] as String?,
    isGuest: json['is_guest'] as int?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    gUserId: json['g_user_id'] as String?,
    imagePath: json['image_path'] as String?,
    walletAmount: json['wallet_amount'] as int?,
    merchantProfile: json['merchant_profile'] != null
        ? MerchantProfile.fromJson(json['merchant_profile'])
        : null,
    wallet: json['wallet'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'username': username,
    'email_verified_at': emailVerifiedAt,
    'type': type,
    'image': image,
    'phone_no': phoneNo,
    'address': address,
    'city': city,
    'date_of_birth': dateOfBirth,
    'postal_code': postalCode,
    'merchant_id': merchantId,
    'cnic': cnic,
    'bank_name': bankName,
    'bank_account_title': bankAccountTitle,
    'bank_account_number': bankAccountNumber,
    'facebook_link': facebookLink,
    'instagram_link': instagramLink,
    'tiktok_link': tiktokLink,
    'newsletter': newsletter,
    'official': official,
    'status': status,
    'is_approved': isApproved,
    'guest_token': guestToken,
    'is_guest': isGuest,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'g_user_id': gUserId,
    'image_path': imagePath,
    'wallet_amount': walletAmount,
    'merchant_profile': merchantProfile?.toJson(),
    'wallet': wallet,
  };
}

class MerchantProfile {
  int? id;
  int? userId;
  String? brandName;
  String? sellerType;
  String? tax;
  String? code;
  String? city;
  String? hasWebsite;
  String? businessOperation;
  String? catalogueSize;
  String? supplyChain;
  String? productionInventory;
  String? rating;
  String? feedback;
  String? websiteUrl;
  String? socialUrl;
  int? commission;
  String? warehouseAddress;
  String? businessAddress;
  int? isAffiliate;
  String? affiliateCode;
  int? affiliateRegistrationCommission;
  int? registrationFees;
  String? createdAt;
  String? updatedAt;
  int? tPickupId;
  int? cityId;

  MerchantProfile({
    this.id,
    this.userId,
    this.brandName,
    this.sellerType,
    this.tax,
    this.code,
    this.city,
    this.hasWebsite,
    this.businessOperation,
    this.catalogueSize,
    this.supplyChain,
    this.productionInventory,
    this.rating,
    this.feedback,
    this.websiteUrl,
    this.socialUrl,
    this.commission,
    this.warehouseAddress,
    this.businessAddress,
    this.isAffiliate,
    this.affiliateCode,
    this.affiliateRegistrationCommission,
    this.registrationFees,
    this.createdAt,
    this.updatedAt,
    this.tPickupId,
    this.cityId,
  });

  factory MerchantProfile.fromJson(Map<String, dynamic> json) => MerchantProfile(
    id: json['id'] as int?,
    userId: json['user_id'] as int?,
    brandName: json['brand_name'] as String?,
    sellerType: json['seller_type'] as String?,
    tax: json['tax'] as String?,
    code: json['code'] as String?,
    city: json['city'] as String?,
    hasWebsite: json['has_website'] as String?,
    businessOperation: json['business_operation'] as String?,
    catalogueSize: json['catalogue_size'] as String?,
    supplyChain: json['supply_chain'] as String?,
    productionInventory: json['production_inventory'] as String?,
    rating: json['rating'] as String?,
    feedback: json['feedback'] as String?,
    websiteUrl: json['website_url'] as String?,
    socialUrl: json['social_url'] as String?,
    commission: json['commission'] as int?,
    warehouseAddress: json['warehouse_address'] as String?,
    businessAddress: json['business_address'] as String?,
    isAffiliate: json['is_affiliate'] as int?,
    affiliateCode: json['affiliate_code'] as String?,
    affiliateRegistrationCommission:
    json['affiliate_registration_commission'] as int?,
    registrationFees: json['registration_fees'] as int?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    tPickupId: json['t_pickup_id'] as int?,
    cityId: json['city_id'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'brand_name': brandName,
    'seller_type': sellerType,
    'tax': tax,
    'code': code,
    'city': city,
    'has_website': hasWebsite,
    'business_operation': businessOperation,
    'catalogue_size': catalogueSize,
    'supply_chain': supplyChain,
    'production_inventory': productionInventory,
    'rating': rating,
    'feedback': feedback,
    'website_url': websiteUrl,
    'social_url': socialUrl,
    'commission': commission,
    'warehouse_address': warehouseAddress,
    'business_address': businessAddress,
    'is_affiliate': isAffiliate,
    'affiliate_code': affiliateCode,
    'affiliate_registration_commission':
    affiliateRegistrationCommission,
    'registration_fees': registrationFees,
    'created_at': createdAt,
    'updated_at': updatedAt,
    't_pickup_id': tPickupId,
    'city_id': cityId,
  };
}

//-------------------------- Safe Get Checkout Model --------------------------

class GetCheckoutResponse {
  int? status;
  String? message;
  DataCheckout? data;

  GetCheckoutResponse({this.status, this.message, this.data});

  factory GetCheckoutResponse.fromJson(Map<String, dynamic> json) {
    return GetCheckoutResponse(
      status: _toInt(json['status']),
      message: json['message']?.toString(),
      data: json['data'] != null
          ? DataCheckout.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class DataCheckout {
  String? total;
  List<Cities>? cities;
  Address? address;
  List<Addresses>? addresses;
  List<ShippingMethod>? shippingMethod;
  Points? points;
  List<String>? paymentMethods;

  DataCheckout({
    this.total,
    this.cities,
    this.address,
    this.addresses,
    this.shippingMethod,
    this.points,
    this.paymentMethods,
  });

  factory DataCheckout.fromJson(Map<String, dynamic> json) {
    return DataCheckout(
      total: json['total']?.toString(),
      cities: (json['cities'] as List?)
          ?.map((e) => Cities.fromJson(e))
          .toList(),
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : null,
      addresses: (json['addresses'] as List?)
          ?.map((e) => Addresses.fromJson(e))
          .toList(),
      shippingMethod: (json['shipping_method'] as List?)
          ?.map((e) => ShippingMethod.fromJson(e))
          .toList(),
      points: json['points'] != null
          ? Points.fromJson(json['points'])
          : null,
      paymentMethods:
      (json['paymentMethods'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'total': total,
    'cities': cities?.map((e) => e.toJson()).toList(),
    'address': address?.toJson(),
    'addresses': addresses?.map((e) => e.toJson()).toList(),
    'shipping_method': shippingMethod?.map((e) => e.toJson()).toList(),
    'points': points?.toJson(),
    'paymentMethods': paymentMethods,
  };
}

class Cities {
  int? id;
  String? name;
  int? tHubId;
  String? tHubName;
  int? tId;
  int? tZoneId;
  String? tZoneName;
  int? tPickup;
  String? createdAt;
  String? updatedAt;

  Cities({
    this.id,
    this.name,
    this.tHubId,
    this.tHubName,
    this.tId,
    this.tZoneId,
    this.tZoneName,
    this.tPickup,
    this.createdAt,
    this.updatedAt,
  });

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      id: _toInt(json['id']),
      name: json['name']?.toString(),
      tHubId: _toInt(json['t_hub_id']),
      tHubName: json['t_hub_name']?.toString(),
      tId: _toInt(json['t_id']),
      tZoneId: _toInt(json['t_zone_id']),
      tZoneName: json['t_zone_name']?.toString(),
      tPickup: _toInt(json['t_pickup']),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    't_hub_id': tHubId,
    't_hub_name': tHubName,
    't_id': tId,
    't_zone_id': tZoneId,
    't_zone_name': tZoneName,
    't_pickup': tPickup,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class Address {
  int? id;
  int? userId;
  String? name;
  String? email;
  String? phoneNo;
  String? address;
  String? billingAddress;
  String? city;
  int? status;
  int? isDefault;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? cityName;

  Address({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.phoneNo,
    this.address,
    this.billingAddress,
    this.city,
    this.status,
    this.isDefault,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.cityName,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: _toInt(json['id']),
      userId: _toInt(json['user_id']),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phoneNo: json['phone_no']?.toString(),
      address: json['address']?.toString(),
      billingAddress: json['billing_address']?.toString(),
      city: json['city']?.toString(),
      status: _toInt(json['status']),
      isDefault: _toInt(json['is_default']),
      deletedAt: json['deleted_at']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      cityName: json['city_name']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'name': name,
    'email': email,
    'phone_no': phoneNo,
    'address': address,
    'billing_address': billingAddress,
    'city': city,
    'status': status,
    'is_default': isDefault,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'city_name': cityName,
  };
}

class Addresses {
  int? id;
  int? userId;
  String? name;
  String? email;
  String? phoneNo;
  String? address;
  String? billingAddress;
  String? city;
  int? status;
  int? isDefault;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? cityName;

  Addresses({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.phoneNo,
    this.address,
    this.billingAddress,
    this.city,
    this.status,
    this.isDefault,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.cityName,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) {
    return Addresses(
      id: _toInt(json['id']),
      userId: _toInt(json['user_id']),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phoneNo: json['phone_no']?.toString(),
      address: json['address']?.toString(),
      billingAddress: json['billing_address']?.toString(),
      city: json['city']?.toString(),
      status: _toInt(json['status']),
      isDefault: _toInt(json['is_default']),
      deletedAt: json['deleted_at']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      cityName: json['city_name']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'name': name,
    'email': email,
    'phone_no': phoneNo,
    'address': address,
    'billing_address': billingAddress,
    'city': city,
    'status': status,
    'is_default': isDefault,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'city_name': cityName,
  };
}

class ShippingMethod {
  int? id;
  String? name;
  int? isFree;
  int? amount;

  ShippingMethod({this.id, this.name, this.isFree, this.amount});

  factory ShippingMethod.fromJson(Map<String, dynamic> json) {
    return ShippingMethod(
      id: _toInt(json['id']),
      name: json['name']?.toString(),
      isFree: _toInt(json['is_free']),
      amount: _toInt(json['amount']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'is_free': isFree,
    'amount': amount,
  };
}

class Points {
  int? id;
  int? userId;
  int? points;
  int? tempPoints;
  String? createdAt;
  String? updatedAt;

  Points({
    this.id,
    this.userId,
    this.points,
    this.tempPoints,
    this.createdAt,
    this.updatedAt,
  });

  factory Points.fromJson(Map<String, dynamic> json) {
    return Points(
      id: _toInt(json['id']),
      userId: _toInt(json['user_id']),
      points: _toInt(json['points']),
      tempPoints: _toInt(json['temp_points']),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'points': points,
    'temp_points': tempPoints,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}



//------------------------ Get Notifications --------------------------------

class GetNotificationsResponse {
  int? status;
  String? message;
  DataParentNoti? data;

  GetNotificationsResponse({this.status, this.message, this.data});

  factory GetNotificationsResponse.fromJson(Map<String, dynamic> json) {
    return GetNotificationsResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? DataParentNoti.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final dataMap = <String, dynamic>{};
    dataMap['status'] = status;
    dataMap['message'] = message;
    if (data != null) {
      dataMap['data'] = data!.toJson();
    }
    return dataMap;
  }
}

class DataParentNoti {
  List<Notifications>? notifications;

  DataParentNoti({this.notifications});

  factory DataParentNoti.fromJson(Map<String, dynamic> json) {
    return DataParentNoti(
      notifications: (json['notifications'] as List?)
          ?.map((e) => Notifications.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final dataMap = <String, dynamic>{};
    if (notifications != null) {
      dataMap['notifications'] =
          notifications!.map((e) => e.toJson()).toList();
    }
    return dataMap;
  }
}

class Notifications {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  DataChildNoti? data;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  Notifications({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      type: json['type'],
      notifiableType: json['notifiable_type'],
      notifiableId: json['notifiable_id'],
      data: json['data'] != null ? DataChildNoti.fromJson(json['data']) : null,
      readAt: json['read_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final dataMap = <String, dynamic>{};
    dataMap['id'] = id;
    dataMap['type'] = type;
    dataMap['notifiable_type'] = notifiableType;
    dataMap['notifiable_id'] = notifiableId;
    if (data != null) {
      dataMap['data'] = data!.toJson();
    }
    dataMap['read_at'] = readAt;
    dataMap['created_at'] = createdAt;
    dataMap['updated_at'] = updatedAt;
    return dataMap;
  }
}

class DataChildNoti {
  String? title;
  String? body;
  String? type;
  String? image;
  String? url;

  DataChildNoti({this.title, this.body, this.type, this.image, this.url});

  factory DataChildNoti.fromJson(Map<String, dynamic> json) {
    return DataChildNoti(
      title: json['title'],
      body: json['body'],
      type: json['type'],
      image: json['image'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final dataMap = <String, dynamic>{};
    dataMap['title'] = title;
    dataMap['body'] = body;
    dataMap['type'] = type;
    dataMap['image'] = image;
    dataMap['url'] = url;
    return dataMap;
  }
}

//------------------------ Become Seller -------------------------------------

class GetBecomeSellerResponse {
  int? status;
  String? message;
  DataBecomeSeller? data;

  GetBecomeSellerResponse({this.status, this.message, this.data});

  factory GetBecomeSellerResponse.fromJson(Map<String, dynamic> json) {
    return GetBecomeSellerResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? DataBecomeSeller.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final dataMap = <String, dynamic>{};
    dataMap['status'] = status;
    dataMap['message'] = message;
    if (data != null) dataMap['data'] = data!.toJson();
    return dataMap;
  }
}

class DataBecomeSeller {
  List<StoreType>? store_type;
  List<String>? catalogue_size;
  List<String>? supply_chain;
  List<String>? production_inventory;
  List<String>? has_website;

  DataBecomeSeller({
    this.store_type,
    this.catalogue_size,
    this.supply_chain,
    this.production_inventory,
    this.has_website,
  });

  factory DataBecomeSeller.fromJson(Map<String, dynamic> json) {
    return DataBecomeSeller(
      store_type: (json['store_type'] as List?)
          ?.map((e) => StoreType.fromJson(e))
          .toList(),
      catalogue_size:
      (json['catalogue_size'] as List?)?.map((e) => e.toString()).toList(),
      supply_chain:
      (json['supply_chain'] as List?)?.map((e) => e.toString()).toList(),
      production_inventory: (json['production_inventory'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      has_website:
      (json['has_website'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final dataMap = <String, dynamic>{};
    if (store_type != null) {
      dataMap['store_type'] = store_type!.map((e) => e.toJson()).toList();
    }
    dataMap['catalogue_size'] = catalogue_size;
    dataMap['supply_chain'] = supply_chain;
    dataMap['production_inventory'] = production_inventory;
    dataMap['has_website'] = has_website;
    return dataMap;
  }
}

class StoreType {
  String? name;
  String? value;

  StoreType({this.name, this.value});

  factory StoreType.fromJson(Map<String, dynamic> json) {
    return StoreType(
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final dataMap = <String, dynamic>{};
    dataMap['name'] = name;
    dataMap['value'] = value;
    return dataMap;
  }
}

//------------------------Products by Brand-----------------------------------

class BrandGetProductByBrand {
  int? status;
  String? message;
  BrandData? data;

  BrandGetProductByBrand({this.status, this.message, this.data});

  factory BrandGetProductByBrand.fromJson(Map<String, dynamic> json) {
    return BrandGetProductByBrand(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? BrandData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class BrandData {
  List<BrandProducts>? products;
  bool? hasMorePage;
  int? currentPage;
  int? followers;
  String? brandName;
  int? totalPages;
  BrandBrand? brand;
  List<BrandCategoryLevel1>? categoryLevel1;
  List<BrandSizes>? sizes;
  List<BrandColors>? colors;

  BrandData({
    this.products,
    this.hasMorePage,
    this.currentPage,
    this.followers,
    this.brandName,
    this.totalPages,
    this.brand,
    this.categoryLevel1,
    this.sizes,
    this.colors,
  });

  factory BrandData.fromJson(Map<String, dynamic> json) {
    return BrandData(
      products: (json['products'] as List?)
          ?.map((e) => BrandProducts.fromJson(e))
          .toList(),
      hasMorePage: json['has_more_page'],
      currentPage: json['current_page'],
      followers: json['followers'],
      brandName: json['brand_name'],
      totalPages: json['totalPages'],
      brand: json['brand'] != null ? BrandBrand.fromJson(json['brand']) : null,
      categoryLevel1: (json['category_level1'] as List?)
          ?.map((e) => BrandCategoryLevel1.fromJson(e))
          .toList(),
      sizes: (json['sizes'] as List?)?.map((e) => BrandSizes.fromJson(e)).toList(),
      colors: (json['colors'] as List?)?.map((e) => BrandColors.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products?.map((e) => e.toJson()).toList(),
      'has_more_page': hasMorePage,
      'current_page': currentPage,
      'followers': followers,
      'brand_name': brandName,
      'totalPages': totalPages,
      'brand': brand?.toJson(),
      'category_level1': categoryLevel1?.map((e) => e.toJson()).toList(),
      'sizes': sizes?.map((e) => e.toJson()).toList(),
      'colors': colors?.map((e) => e.toJson()).toList(),
    };
  }
}

class BrandProducts {
  int? id;
  String? barcode;
  int? merchantId;
  String? name;
  String? slug;
  String? brand;
  String? productType;
  int? isVariant;
  String? keyWords;
  String? description;
  String? summary;
  String? sizes;
  String? colors;
  String? type;
  int? isFeatured;
  double? price;
  double? offerPrice;
  double? quantity;
  String? image;
  String? sizeGuide;
  double? weight;
  List<String>? images;
  String? brandId;
  int? categoryLevel1Id;
  int? categoryLevel2Id;
  int? categoryLevel3Id;
  String? categoryLevel4Id;
  String? updatedBy;
  String? deletedBy;
  int? isApproved;
  int? noOfOrders;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  BrandVariant? variant;
  String? imageUrl;
  List<String>? imagesUrl;
  int? isWishlist;
  String? brandName;

  BrandProducts({
    this.id,
    this.barcode,
    this.merchantId,
    this.name,
    this.slug,
    this.brand,
    this.productType,
    this.isVariant,
    this.keyWords,
    this.description,
    this.summary,
    this.sizes,
    this.colors,
    this.type,
    this.isFeatured,
    this.price,
    this.offerPrice,
    this.quantity,
    this.image,
    this.sizeGuide,
    this.weight,
    this.images,
    this.brandId,
    this.categoryLevel1Id,
    this.categoryLevel2Id,
    this.categoryLevel3Id,
    this.categoryLevel4Id,
    this.updatedBy,
    this.deletedBy,
    this.isApproved,
    this.noOfOrders,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.variant,
    this.imageUrl,
    this.imagesUrl,
    this.isWishlist,
    this.brandName,
  });

  factory BrandProducts.fromJson(Map<String, dynamic> json) {
    return BrandProducts(
      id: json['id'],
      barcode: json['barcode'],
      merchantId: json['merchant_id'],
      name: json['name'],
      slug: json['slug'],
      brand: json['brand'],
      productType: json['product_type'],
      isVariant: json['is_variant'],
      keyWords: json['key_words'],
      description: json['description'],
      summary: json['summary'],
      sizes: json['sizes'],
      colors: json['colors'],
      type: json['type'],
      isFeatured: json['is_featured'],
      price: (json['price'] as num?)?.toDouble(),
      offerPrice: (json['offer_price'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      image: json['image'],
      sizeGuide: json['size_guide'],
      weight: (json['weight'] as num?)?.toDouble(),
      images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      brandId: json['brand_id'],
      categoryLevel1Id: json['category_level1_id'],
      categoryLevel2Id: json['category_level2_id'],
      categoryLevel3Id: json['category_level3_id'],
      categoryLevel4Id: json['category_level4_id'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      isApproved: json['is_approved'],
      noOfOrders: json['no_of_orders'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      variant:
      json['variant'] != null ? BrandVariant.fromJson(json['variant']) : null,
      imageUrl: json['image_url'],
      imagesUrl:
      (json['images_url'] as List?)?.map((e) => e.toString()).toList(),
      isWishlist: json['is_wishlist'],
      brandName: json['brand_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'barcode': barcode,
      'merchant_id': merchantId,
      'name': name,
      'slug': slug,
      'brand': brand,
      'product_type': productType,
      'is_variant': isVariant,
      'key_words': keyWords,
      'description': description,
      'summary': summary,
      'sizes': sizes,
      'colors': colors,
      'type': type,
      'is_featured': isFeatured,
      'price': price,
      'offer_price': offerPrice,
      'quantity': quantity,
      'image': image,
      'size_guide': sizeGuide,
      'weight': weight,
      'images': images,
      'brand_id': brandId,
      'category_level1_id': categoryLevel1Id,
      'category_level2_id': categoryLevel2Id,
      'category_level3_id': categoryLevel3Id,
      'category_level4_id': categoryLevel4Id,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'is_approved': isApproved,
      'no_of_orders': noOfOrders,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'variant': variant?.toJson(),
      'image_url': imageUrl,
      'images_url': imagesUrl,
      'is_wishlist': isWishlist,
      'brand_name': brandName,
    };
  }
}

class BrandVariant {
  int? id;
  int? size;
  int? color;
  double? price;
  double? offerPrice;
  int? isAvailable;
  int? quantity;

  BrandVariant({
    this.id,
    this.size,
    this.color,
    this.price,
    this.offerPrice,
    this.isAvailable,
    this.quantity,
  });

  factory BrandVariant.fromJson(Map<String, dynamic> json) {
    return BrandVariant(
      id: json['id'],
      size: json['size'],
      color: json['color'],
      price: (json['price'] as num?)?.toDouble(),
      offerPrice: (json['offer_price'] as num?)?.toDouble(),
      isAvailable: json['is_available'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'size': size,
      'color': color,
      'price': price,
      'offer_price': offerPrice,
      'is_available': isAvailable,
      'quantity': quantity,
    };
  }
}

class BrandBrand {
  int? id;
  String? name;
  String? email;
  String? username;
  String? emailVerifiedAt;
  int? type;
  String? image;
  String? phoneNo;
  String? address;
  String? city;
  String? dateOfBirth;
  String? postalCode;
  int? merchantId;
  String? cnic;
  String? bankName;
  String? bankAccountTitle;
  String? bankAccountNumber;
  String? facebookLink;
  String? instagramLink;
  String? tiktokLink;
  int? newsletter;
  int? official;
  int? status;
  int? isApproved;
  String? guestToken;
  int? isGuest;
  String? createdAt;
  String? updatedAt;
  String? gUserId;
  String? imagePath;
  double? walletAmount;
  String? wallet;

  BrandBrand({
    this.id,
    this.name,
    this.email,
    this.username,
    this.emailVerifiedAt,
    this.type,
    this.image,
    this.phoneNo,
    this.address,
    this.city,
    this.dateOfBirth,
    this.postalCode,
    this.merchantId,
    this.cnic,
    this.bankName,
    this.bankAccountTitle,
    this.bankAccountNumber,
    this.facebookLink,
    this.instagramLink,
    this.tiktokLink,
    this.newsletter,
    this.official,
    this.status,
    this.isApproved,
    this.guestToken,
    this.isGuest,
    this.createdAt,
    this.updatedAt,
    this.gUserId,
    this.imagePath,
    this.walletAmount,
    this.wallet,
  });

  factory BrandBrand.fromJson(Map<String, dynamic> json) {
    return BrandBrand(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      emailVerifiedAt: json['email_verified_at'],
      type: json['type'],
      image: json['image'],
      phoneNo: json['phone_no'],
      address: json['address'],
      city: json['city'],
      dateOfBirth: json['date_of_birth'],
      postalCode: json['postal_code'],
      merchantId: json['merchant_id'],
      cnic: json['cnic'],
      bankName: json['bank_name'],
      bankAccountTitle: json['bank_account_title'],
      bankAccountNumber: json['bank_account_number'],
      facebookLink: json['facebook_link'],
      instagramLink: json['instagram_link'],
      tiktokLink: json['tiktok_link'],
      newsletter: json['newsletter'],
      official: json['official'],
      status: json['status'],
      isApproved: json['is_approved'],
      guestToken: json['guest_token'],
      isGuest: json['is_guest'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      gUserId: json['g_user_id'],
      imagePath: json['image_path'],
      walletAmount: (json['wallet_amount'] as num?)?.toDouble(),
      wallet: json['wallet'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'email_verified_at': emailVerifiedAt,
      'type': type,
      'image': image,
      'phone_no': phoneNo,
      'address': address,
      'city': city,
      'date_of_birth': dateOfBirth,
      'postal_code': postalCode,
      'merchant_id': merchantId,
      'cnic': cnic,
      'bank_name': bankName,
      'bank_account_title': bankAccountTitle,
      'bank_account_number': bankAccountNumber,
      'facebook_link': facebookLink,
      'instagram_link': instagramLink,
      'tiktok_link': tiktokLink,
      'newsletter': newsletter,
      'official': official,
      'status': status,
      'is_approved': isApproved,
      'guest_token': guestToken,
      'is_guest': isGuest,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'g_user_id': gUserId,
      'image_path': imagePath,
      'wallet_amount': walletAmount,
      'wallet': wallet,
    };
  }
}

class BrandCategoryLevel1 {
  int? id;
  String? name;
  String? slug;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? imagePath;

  BrandCategoryLevel1({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.imagePath,
  });

  factory BrandCategoryLevel1.fromJson(Map<String, dynamic> json) {
    return BrandCategoryLevel1(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      imagePath: json['image_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'image': image,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image_path': imagePath,
    };
  }
}

class BrandSizes {
  int? id;
  String? size;
  String? type;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  BrandSizes({
    this.id,
    this.size,
    this.type,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory BrandSizes.fromJson(Map<String, dynamic> json) {
    return BrandSizes(
      id: json['id'],
      size: json['size'],
      type: json['type'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'size': size,
      'type': type,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class BrandColors {
  int? id;
  String? color;
  String? hexCode;
  String? type;
  int? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  BrandColors({
    this.id,
    this.color,
    this.hexCode,
    this.type,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory BrandColors.fromJson(Map<String, dynamic> json) {
    return BrandColors(
      id: json['id'],
      color: json['color'],
      hexCode: json['hex_code'],
      type: json['type'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'color': color,
      'hex_code': hexCode,
      'type': type,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() => color ?? "Unknown";
}


//-----------------------------Update Cart-----------------------------


class UpdateCartResponse {
  int? status;
  String? message;
  List<String>? data;

  UpdateCartResponse({this.status, this.message, this.data});

  factory UpdateCartResponse.fromJson(Map<String, dynamic> json) {
    return UpdateCartResponse(
      status: json['status'] is int
          ? json['status']
          : int.tryParse(json['status']?.toString() ?? ''),
      message: json['message']?.toString(),
      data: json['data'] != null
          ? List<String>.from(
          (json['data'] as List).map((item) => item.toString()))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data,
    };
  }
}


//--------------------------------Add Remove Wishlist-----------------------------

class AddWishlistModell {
  int? status;
  String? message;
  List<String>? data;

  AddWishlistModell({this.status, this.message, this.data});

  factory AddWishlistModell.fromJson(Map<String, dynamic> json) {
    return AddWishlistModell(
      status: json['status'] is int
          ? json['status']
          : int.tryParse(json['status']?.toString() ?? ''),
      message: json['message']?.toString(),
      data: json['data'] != null
          ? List<String>.from(
          (json['data'] as List).map((item) => item.toString()))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data,
    };
  }
}


//-------------------General Model--------------------------------


class GeneralModel {
  int? status;
  String? message;

  GeneralModel({this.status, this.message});

  factory GeneralModel.fromJson(Map<String, dynamic> json) {
    return GeneralModel(
      status: json['status'] is int
          ? json['status']
          : int.tryParse(json['status']?.toString() ?? ''),
      message: json['message']?.toString(),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
     };
  }
}



//----------------------------Get Config -----------------------------------


class GetConfigResponsee {
  int? status;
  String? message;
  SocialLinkss? data;

  GetConfigResponsee({this.status, this.message, this.data});

  factory GetConfigResponsee.fromJson(Map<String, dynamic> json) {
    return GetConfigResponsee(
      status: json['status'] is int
          ? json['status']
          : int.tryParse(json['status']?.toString() ?? ''),
      message: json['message']?.toString(),
      data: json['data'] != null
          ? SocialLinkss.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class SocialLinkss {
  String? facebook;
  String? twitter;
  String? instagram;
  String? linkedin;
  String? youtube;
  String? tiktok;

  SocialLinkss({
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedin,
    this.youtube,
    this.tiktok,
  });

  factory SocialLinkss.fromJson(Map<String, dynamic> json) {
    return SocialLinkss(
      facebook: json['facebook']?.toString(),
      twitter: json['twitter']?.toString(),
      instagram: json['instagram']?.toString(),
      linkedin: json['linkedin']?.toString(),
      youtube: json['youtube']?.toString(),
      tiktok: json['tiktok']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'facebook': facebook,
      'twitter': twitter,
      'instagram': instagram,
      'linkedin': linkedin,
      'youtube': youtube,
      'tiktok': tiktok,
    };
  }
}


//------------------------------Get Orders--------------------------------
class GetOrderResponsee {
  int? status;
  String? message;
  DataOrderr? data;

  GetOrderResponsee({this.status, this.message, this.data});

  factory GetOrderResponsee.fromJson(Map<String, dynamic> json) {
    return GetOrderResponsee(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? DataOrderr.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class DataOrderr {
  List<Orderss>? orders;

  DataOrderr({this.orders});

  factory DataOrderr.fromJson(Map<String, dynamic> json) {
    return DataOrderr(
      orders: (json['orders'] as List?)
          ?.map((e) => Orderss.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orders': orders?.map((e) => e.toJson()).toList(),
    };
  }
}

class Orderss {
  int? id;
  String? invoiceNo;
  int? customerId;
  int? merchantId;
  int? grossTotal;
  double? subTotal;
  int? discount;
  int? redeemDiscount;
  String? redeemedPoints;
  double? taxAmount;
  int? shippingCost;
  int? netTotal;
  double? commission;
  int? taxPercentage;
  int? walletAmount;
  int? pointsAttained;
  String? shippingAddressId;
  String? shippingAddress;
  String? billingAddressId;
  String? billingAddress;
  String? paymentMethod;
  String? shippingMethod;
  String? customerNotes;
  String? orderStatus;
  String? deliveredAt;
  String? createdAt;
  String? updatedAt;
  String? trackingPartner;
  String? trackingNumber;
  String? orderType;
  String? trackingBill;
  List<OrderItemsStackk>? orderItemsStack;

  Orderss({
    this.id,
    this.invoiceNo,
    this.customerId,
    this.merchantId,
    this.grossTotal,
    this.subTotal,
    this.discount,
    this.redeemDiscount,
    this.redeemedPoints,
    this.taxAmount,
    this.shippingCost,
    this.netTotal,
    this.commission,
    this.taxPercentage,
    this.walletAmount,
    this.pointsAttained,
    this.shippingAddressId,
    this.shippingAddress,
    this.billingAddressId,
    this.billingAddress,
    this.paymentMethod,
    this.shippingMethod,
    this.customerNotes,
    this.orderStatus,
    this.deliveredAt,
    this.createdAt,
    this.updatedAt,
    this.trackingPartner,
    this.trackingNumber,
    this.orderType,
    this.trackingBill,
    this.orderItemsStack,
  });

  factory Orderss.fromJson(Map<String, dynamic> json) {
    return Orderss(
      id: json['id'],
      invoiceNo: json['invoice_no'],
      customerId: json['customer_id'],
      merchantId: json['merchant_id'],
      grossTotal: _toInt(json['gross_total']),
      subTotal: _toDouble(json['sub_total']),
      discount: _toInt(json['discount']),
      redeemDiscount: _toInt(json['redeem_discount']),
      redeemedPoints: json['redeemed_points']?.toString(),
      taxAmount: _toDouble(json['tax_amount']),
      shippingCost: _toInt(json['shipping_cost']),
      netTotal: _toInt(json['net_total']),
      commission: _toDouble(json['commission']),
      taxPercentage: _toInt(json['tax_percentage']),
      walletAmount: _toInt(json['wallet_amount']),
      pointsAttained: _toInt(json['points_attained']),
      shippingAddressId: json['shipping_address_id']?.toString(),
      shippingAddress: json['shipping_address'],
      billingAddressId: json['billing_address_id']?.toString(),
      billingAddress: json['billing_address'],
      paymentMethod: json['payment_method'],
      shippingMethod: json['shipping_method'],
      customerNotes: json['customer_notes'],
      orderStatus: json['order_status'],
      deliveredAt: json['delivered_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      trackingPartner: json['tracking_partner'],
      trackingNumber: json['tracking_number'],
      orderType: json['order_type'],
      trackingBill: json['tracking_bill'],
      orderItemsStack: (json['order_items_stack'] as List?)
          ?.map((e) => OrderItemsStackk.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoice_no': invoiceNo,
      'customer_id': customerId,
      'merchant_id': merchantId,
      'gross_total': grossTotal,
      'sub_total': subTotal,
      'discount': discount,
      'redeem_discount': redeemDiscount,
      'redeemed_points': redeemedPoints,
      'tax_amount': taxAmount,
      'shipping_cost': shippingCost,
      'net_total': netTotal,
      'commission': commission,
      'tax_percentage': taxPercentage,
      'wallet_amount': walletAmount,
      'points_attained': pointsAttained,
      'shipping_address_id': shippingAddressId,
      'shipping_address': shippingAddress,
      'billing_address_id': billingAddressId,
      'billing_address': billingAddress,
      'payment_method': paymentMethod,
      'shipping_method': shippingMethod,
      'customer_notes': customerNotes,
      'order_status': orderStatus,
      'delivered_at': deliveredAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'tracking_partner': trackingPartner,
      'tracking_number': trackingNumber,
      'order_type': orderType,
      'tracking_bill': trackingBill,
      'order_items_stack':
      orderItemsStack?.map((e) => e.toJson()).toList(),
    };
  }
}

class OrderItemsStackk {
  int? id;
  int? productId;
  int? quantity;
  String? productName;
  String? productImage;
  String? productDescription;
  int? productVariantId;

  OrderItemsStackk({
    this.id,
    this.productId,
    this.quantity,
    this.productName,
    this.productImage,
    this.productDescription,
    this.productVariantId,
  });

  factory OrderItemsStackk.fromJson(Map<String, dynamic> json) {
    return OrderItemsStackk(
      id: json['id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      productName: json['product_name'],
      productImage: json['product_image'],
      productDescription: json['product_description'],
      productVariantId: json['product_variant_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'quantity': quantity,
      'product_name': productName,
      'product_image': productImage,
      'product_description': productDescription,
      'product_variant_id': productVariantId,
    };
  }
}

/// Safe conversion helpers to handle string/int/double type mismatches.

//------------------------------Get Profile------------------------------

class GetProfileResponsee {
  int? status;
  String? message;
  DataProfilee? data;

  GetProfileResponsee({this.status, this.message, this.data});

  factory GetProfileResponsee.fromJson(Map<String, dynamic> json) {
    return GetProfileResponsee(
      status: json['status'] is String
          ? int.tryParse(json['status'])
          : json['status'],
      message: json['message'],
      data: json['data'] != null
          ? DataProfilee.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class DataProfilee {
  UserProfile? user;
  int? wallet;
  int? points;
  int? orders;
  int? following;

  DataProfilee({this.user, this.wallet, this.points, this.orders, this.following});

  factory DataProfilee.fromJson(Map<String, dynamic> json) {
    return DataProfilee(
      user: json['user'] != null ? UserProfile.fromJson(json['user']) : null,
      wallet: json['wallet'] is String
          ? int.tryParse(json['wallet'])
          : json['wallet'],
      points: json['points'] is String
          ? int.tryParse(json['points'])
          : json['points'],
      orders: json['orders'] is String
          ? int.tryParse(json['orders'])
          : json['orders'],
      following: json['following'] is String
          ? int.tryParse(json['following'])
          : json['following'],
    );
  }

  Map<String, dynamic> toJson() => {
    'user': user?.toJson(),
    'wallet': wallet,
    'points': points,
    'orders': orders,
    'following': following,
  };
}

class UserProfile {
  int? id;
  String? name;
  String? email;
  String? phoneNo;
  String? address;
  String? city;
  String? dateOfBirth;
  String? image;

  UserProfile({
    this.id,
    this.name,
    this.email,
    this.phoneNo,
    this.address,
    this.city,
    this.dateOfBirth,
    this.image,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      name: json['name'],
      email: json['email'],
      phoneNo: json['phone_no'],
      address: json['address'],
      city: json['city'],
      dateOfBirth: json['date_of_birth'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone_no': phoneNo,
    'address': address,
    'city': city,
    'date_of_birth': dateOfBirth,
    'image': image,
  };
}

//----------------------------Voucher list-----------------------------

class GetVoucherlistResponsee {
  int? status;
  String? message;
  VoucherDataa? data;

  GetVoucherlistResponsee({this.status, this.message, this.data});

  factory GetVoucherlistResponsee.fromJson(Map<String, dynamic> json) {
    return GetVoucherlistResponsee(
      status: json['status'] is String
          ? int.tryParse(json['status'])
          : json['status'],
      message: json['message'],
      data: json['data'] != null
          ? VoucherDataa.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class VoucherDataa {
  List<Voucherr>? vouchers;

  VoucherDataa({this.vouchers});

  factory VoucherDataa.fromJson(Map<String, dynamic> json) {
    return VoucherDataa(
      vouchers: (json['vouchers'] as List?)
          ?.map((v) => Voucherr.fromJson(v))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'vouchers': vouchers?.map((v) => v.toJson()).toList(),
  };
}

class Voucherr {
  int? id;
  String? title;
  String? code;
  int? discount;
  int? maxAmount;
  String? startAt;
  String? endAt;
  int? customerId;
  int? status;
  String? created_at;
  String? updatedAt;

  Voucherr({
    this.id,
    this.title,
    this.code,
    this.discount,
    this.maxAmount,
    this.startAt,
    this.endAt,
    this.customerId,
    this.status,
    this.created_at,
    this.updatedAt,
  });

  factory Voucherr.fromJson(Map<String, dynamic> json) {
    return Voucherr(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      title: json['title'],
      code: json['code'],
      discount: json['discount'] is String
          ? int.tryParse(json['discount'])
          : json['discount'],
      maxAmount: json['maxAmount'] is String
          ? int.tryParse(json['maxAmount'])
          : json['maxAmount'],
      startAt: json['startAt'],
      endAt: json['endAt'],
      customerId: json['customerId'] is String
          ? int.tryParse(json['customerId'])
          : json['customerId'],
      status: json['status'] is String
          ? int.tryParse(json['status'])
          : json['status'],
      created_at: json['created_at'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'code': code,
    'discount': discount,
    'maxAmount': maxAmount,
    'startAt': startAt,
    'endAt': endAt,
    'customerId': customerId,
    'status': status,
    'createdAt': created_at,
    'updatedAt': updatedAt,
  };
}

//------------------------My Followers---screen missed not used in any screen-----------------------------

class MyFollowersResponsee {
  int? status;
  String? message;
  Dataaa? data;

  MyFollowersResponsee({this.status, this.message, this.data});

  factory MyFollowersResponsee.fromJson(Map<String, dynamic> json) {
    return MyFollowersResponsee(
      status: json['status'] is String ? int.tryParse(json['status']) : json['status'],
      message: json['message'],
      data: json['data'] != null ? Dataaa.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class Dataaa {
  List<MyFollowerr>? myFollowes;

  Dataaa({this.myFollowes});

  factory Dataaa.fromJson(Map<String, dynamic> json) {
    return Dataaa(
      myFollowes: (json['my_followes'] as List?)
          ?.map((v) => MyFollowerr.fromJson(v))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'my_followes': myFollowes?.map((v) => v.toJson()).toList(),
  };
}

class MyFollowerr {
  int? id;
  int? merchantId;
  int? followerId;
  String? createdAt;
  String? updatedAt;
  Merchanttt? merchant;

  MyFollowerr({
    this.id,
    this.merchantId,
    this.followerId,
    this.createdAt,
    this.updatedAt,
    this.merchant,
  });

  factory MyFollowerr.fromJson(Map<String, dynamic> json) {
    return MyFollowerr(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      merchantId: json['merchant_id'] is String ? int.tryParse(json['merchant_id']) : json['merchant_id'],
      followerId: json['follower_id'] is String ? int.tryParse(json['follower_id']) : json['follower_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      merchant: json['merchant'] != null ? Merchanttt.fromJson(json['merchant']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'merchant_id': merchantId,
    'follower_id': followerId,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'merchant': merchant?.toJson(),
  };
}

class Merchanttt {
  int? id;
  String? name;
  String? email;
  String? username;
  String? emailVerifiedAt;
  int? type;
  String? image;
  String? phoneNo;
  String? address;
  String? city;
  String? dateOfBirth;
  String? postalCode;
  int? merchantId;
  String? cnic;
  String? bankName;
  String? bankAccountTitle;
  String? bankAccountNumber;
  String? facebookLink;
  String? instagramLink;
  String? tiktokLink;
  int? newsletter;
  int? official;
  int? status;
  int? isApproved;
  String? guestToken;
  int? isGuest;
  String? createdAt;
  String? updatedAt;
  String? gUserId;
  String? imagePath;
  int? walletAmount;
  MerchantProfilee? merchantProfile;
  dynamic wallet;

  Merchanttt({
    this.id,
    this.name,
    this.email,
    this.username,
    this.emailVerifiedAt,
    this.type,
    this.image,
    this.phoneNo,
    this.address,
    this.city,
    this.dateOfBirth,
    this.postalCode,
    this.merchantId,
    this.cnic,
    this.bankName,
    this.bankAccountTitle,
    this.bankAccountNumber,
    this.facebookLink,
    this.instagramLink,
    this.tiktokLink,
    this.newsletter,
    this.official,
    this.status,
    this.isApproved,
    this.guestToken,
    this.isGuest,
    this.createdAt,
    this.updatedAt,
    this.gUserId,
    this.imagePath,
    this.walletAmount,
    this.merchantProfile,
    this.wallet,
  });

  factory Merchanttt.fromJson(Map<String, dynamic> json) {
    return Merchanttt(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      emailVerifiedAt: json['email_verified_at'],
      type: json['type'] is String ? int.tryParse(json['type']) : json['type'],
      image: json['image'],
      phoneNo: json['phone_no'],
      address: json['address'],
      city: json['city'],
      dateOfBirth: json['date_of_birth'],
      postalCode: json['postal_code'],
      merchantId: json['merchant_id'] is String ? int.tryParse(json['merchant_id']) : json['merchant_id'],
      cnic: json['cnic'],
      bankName: json['bank_name'],
      bankAccountTitle: json['bank_account_title'],
      bankAccountNumber: json['bank_account_number'],
      facebookLink: json['facebook_link'],
      instagramLink: json['instagram_link'],
      tiktokLink: json['tiktok_link'],
      newsletter: json['newsletter'] is String ? int.tryParse(json['newsletter']) : json['newsletter'],
      official: json['official'] is String ? int.tryParse(json['official']) : json['official'],
      status: json['status'] is String ? int.tryParse(json['status']) : json['status'],
      isApproved: json['is_approved'] is String ? int.tryParse(json['is_approved']) : json['is_approved'],
      guestToken: json['guest_token'],
      isGuest: json['is_guest'] is String ? int.tryParse(json['is_guest']) : json['is_guest'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      gUserId: json['g_user_id'],
      imagePath: json['image_path'],
      walletAmount: json['wallet_amount'] is String ? int.tryParse(json['wallet_amount']) : json['wallet_amount'],
      merchantProfile: json['merchant_profile'] != null
          ? MerchantProfilee.fromJson(json['merchant_profile'])
          : null,
      wallet: json['wallet'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'username': username,
    'email_verified_at': emailVerifiedAt,
    'type': type,
    'image': image,
    'phone_no': phoneNo,
    'address': address,
    'city': city,
    'date_of_birth': dateOfBirth,
    'postal_code': postalCode,
    'merchant_id': merchantId,
    'cnic': cnic,
    'bank_name': bankName,
    'bank_account_title': bankAccountTitle,
    'bank_account_number': bankAccountNumber,
    'facebook_link': facebookLink,
    'instagram_link': instagramLink,
    'tiktok_link': tiktokLink,
    'newsletter': newsletter,
    'official': official,
    'status': status,
    'is_approved': isApproved,
    'guest_token': guestToken,
    'is_guest': isGuest,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'g_user_id': gUserId,
    'image_path': imagePath,
    'wallet_amount': walletAmount,
    'merchant_profile': merchantProfile?.toJson(),
    'wallet': wallet,
  };
}

class MerchantProfilee {
  int? id;
  int? userId;
  String? brandName;
  String? sellerType;
  String? tax;
  String? code;
  String? city;
  String? hasWebsite;
  String? businessOperation;
  String? catalogueSize;
  String? supplyChain;
  String? productionInventory;
  String? rating;
  String? feedback;
  String? websiteUrl;
  String? socialUrl;
  int? commission;
  String? warehouseAddress;
  String? businessAddress;
  int? isAffiliate;
  String? affiliateCode;
  int? affiliateRegistrationCommission;
  int? registrationFees;
  String? createdAt;
  String? updatedAt;
  int? tPickupId;
  int? cityId;

  MerchantProfilee({
    this.id,
    this.userId,
    this.brandName,
    this.sellerType,
    this.tax,
    this.code,
    this.city,
    this.hasWebsite,
    this.businessOperation,
    this.catalogueSize,
    this.supplyChain,
    this.productionInventory,
    this.rating,
    this.feedback,
    this.websiteUrl,
    this.socialUrl,
    this.commission,
    this.warehouseAddress,
    this.businessAddress,
    this.isAffiliate,
    this.affiliateCode,
    this.affiliateRegistrationCommission,
    this.registrationFees,
    this.createdAt,
    this.updatedAt,
    this.tPickupId,
    this.cityId,
  });

  factory MerchantProfilee.fromJson(Map<String, dynamic> json) {
    return MerchantProfilee(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      userId: json['user_id'] is String ? int.tryParse(json['user_id']) : json['user_id'],
      brandName: json['brand_name'],
      sellerType: json['seller_type'],
      tax: json['tax'],
      code: json['code'],
      city: json['city'],
      hasWebsite: json['has_website'],
      businessOperation: json['business_operation'],
      catalogueSize: json['catalogue_size'],
      supplyChain: json['supply_chain'],
      productionInventory: json['production_inventory'],
      rating: json['rating'],
      feedback: json['feedback'],
      websiteUrl: json['website_url'],
      socialUrl: json['social_url'],
      commission: json['commission'] is String ? int.tryParse(json['commission']) : json['commission'],
      warehouseAddress: json['warehouse_address'],
      businessAddress: json['business_address'],
      isAffiliate: json['is_affiliate'] is String ? int.tryParse(json['is_affiliate']) : json['is_affiliate'],
      affiliateCode: json['affiliate_code'],
      affiliateRegistrationCommission: json['affiliate_registration_commission'] is String
          ? int.tryParse(json['affiliate_registration_commission'])
          : json['affiliate_registration_commission'],
      registrationFees: json['registration_fees'] is String
          ? int.tryParse(json['registration_fees'])
          : json['registration_fees'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      tPickupId: json['t_pickup_id'] is String ? int.tryParse(json['t_pickup_id']) : json['t_pickup_id'],
      cityId: json['city_id'] is String ? int.tryParse(json['city_id']) : json['city_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'brand_name': brandName,
    'seller_type': sellerType,
    'tax': tax,
    'code': code,
    'city': city,
    'has_website': hasWebsite,
    'business_operation': businessOperation,
    'catalogue_size': catalogueSize,
    'supply_chain': supplyChain,
    'production_inventory': productionInventory,
    'rating': rating,
    'feedback': feedback,
    'website_url': websiteUrl,
    'social_url': socialUrl,
    'commission': commission,
    'warehouse_address': warehouseAddress,
    'business_address': businessAddress,
    'is_affiliate': isAffiliate,
    'affiliate_code': affiliateCode,
    'affiliate_registration_commission': affiliateRegistrationCommission,
    'registration_fees': registrationFees,
    'created_at': createdAt,
    'updated_at': updatedAt,
    't_pickup_id': tPickupId,
    'city_id': cityId,
  };
}


//-------------------------Product Details--------------------------------

class DetailProductDetailsModel {
  int? status;
  String? message;
  DetailDataProductDetail? data;

  DetailProductDetailsModel({this.status, this.message, this.data});

  DetailProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? DetailDataProductDetail.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['status'] = status;
    dataMap['message'] = message;
    if (data != null) {
      dataMap['data'] = data!.toJson();
    }
    return dataMap;
  }
}

class DetailDataProductDetail {
  DetailProductt? product;
  List<ProductHomee>? similarProducts;
  List<ProductHomee>? matchWithProducts;
  List<DetailSizes>? sizes;
  List<DetailColors>? colors;

  DetailDataProductDetail(
      {this.product,
        this.similarProducts,
        this.matchWithProducts,
        this.sizes,
        this.colors});

  DetailDataProductDetail.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null
        ? DetailProductt.fromJson(json['product'])
        : null;
    if (json['similar_products'] != null) {
      similarProducts = List.from(json['similar_products'])
          .map((e) => ProductHomee.fromJson(e))
          .toList();
    }
    if (json['match_with_products'] != null) {
      matchWithProducts = List.from(json['match_with_products'])
          .map((e) => ProductHomee.fromJson(e))
          .toList();
    }
    if (json['sizes'] != null) {
      sizes = List.from(json['sizes'])
          .map((e) => DetailSizes.fromJson(e))
          .toList();
    }
    if (json['colors'] != null) {
      colors = List.from(json['colors'])
          .map((e) => DetailColors.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    if (product != null) dataMap['product'] = product!.toJson();
    if (similarProducts != null) {
      dataMap['similar_products'] =
          similarProducts!.map((v) => v.toJson()).toList();
    }
    if (matchWithProducts != null) {
      dataMap['match_with_products'] =
          matchWithProducts!.map((v) => v.toJson()).toList();
    }
    if (sizes != null) dataMap['sizes'] = sizes!.map((v) => v.toJson()).toList();
    if (colors != null)
      dataMap['colors'] = colors!.map((v) => v.toJson()).toList();
    return dataMap;
  }
}

class DetailProductt {
  int? id;
  String? barcode;
  int? merchantId;
  String? name;
  String? slug;
  String? productType;
  int? isVariant;
  String? keyWords;
  String? description;
  String? summary;
  String? sizes;
  String? colors;
  String? type;
  int? isFeatured;
  String? image;
  String? imageUrl;
  String? sizeGuide;
  String? video;
  double? weight;
  List<String>? images;
  List<String>? imagesUrl;
  String? brandId;
  int? categoryLevel1Id;
  int? categoryLevel2Id;
  int? categoryLevel3Id;
  String? updatedBy;
  String? deletedBy;
  int? isApproved;
  int? noOfOrders;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  VariantHomee? variant;
  String? brandName;
  DetailMerchant? merchant;
  List<String>? reviews;

  DetailProductt(
      {this.id,
        this.barcode,
        this.merchantId,
        this.name,
        this.slug,
        this.productType,
        this.isVariant,
        this.keyWords,
        this.description,
        this.summary,
        this.sizes,
        this.colors,
        this.type,
        this.isFeatured,
        this.image,
        this.imageUrl,
        this.sizeGuide,
        this.video,
        this.weight,
        this.images,
        this.imagesUrl,
        this.brandId,
        this.categoryLevel1Id,
        this.categoryLevel2Id,
        this.categoryLevel3Id,
        this.updatedBy,
        this.deletedBy,
        this.isApproved,
        this.noOfOrders,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.variant,
        this.brandName,
        this.merchant,
        this.reviews});

  DetailProductt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barcode = json['barcode'];
    merchantId = json['merchant_id'];
    name = json['name'];
    slug = json['slug'];
    productType = json['product_type'];
    isVariant = json['is_variant'];
    keyWords = json['key_words'];
    description = json['description'];
    summary = json['summary'];
    sizes = json['sizes'];
    colors = json['colors'];
    type = json['type'];
    isFeatured = json['is_featured'];
    image = json['image'];
    imageUrl = json['image_url'];
    sizeGuide = json['size_guide'];
    video = json['video'];
    weight = (json['weight'] is num) ? (json['weight'] as num).toDouble() : null;
    images = (json['images'] != null)
        ? List<String>.from(json['images'])
        : <String>[];
    imagesUrl = (json['images_url'] != null)
        ? List<String>.from(json['images_url'])
        : <String>[];
    brandId = json['brand_id'];
    categoryLevel1Id = json['category_level1_id'];
    categoryLevel2Id = json['category_level2_id'];
    categoryLevel3Id = json['category_level3_id'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    isApproved = json['is_approved'];
    noOfOrders = json['no_of_orders'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    variant =
    json['variant'] != null ? VariantHomee.fromJson(json['variant']) : null;
    brandName = json['brand_name'];
    merchant = json['merchant'] != null
        ? DetailMerchant.fromJson(json['merchant'])
        : null;
    reviews = (json['reviews'] != null)
        ? List<String>.from(json['reviews'])
        : <String>[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['id'] = id;
    dataMap['barcode'] = barcode;
    dataMap['merchant_id'] = merchantId;
    dataMap['name'] = name;
    dataMap['slug'] = slug;
    dataMap['product_type'] = productType;
    dataMap['is_variant'] = isVariant;
    dataMap['key_words'] = keyWords;
    dataMap['description'] = description;
    dataMap['summary'] = summary;
    dataMap['sizes'] = sizes;
    dataMap['colors'] = colors;
    dataMap['type'] = type;
    dataMap['is_featured'] = isFeatured;
    dataMap['image'] = image;
    dataMap['image_url'] = imageUrl;
    dataMap['size_guide'] = sizeGuide;
    dataMap['video'] = video;
    dataMap['weight'] = weight;
    dataMap['images'] = images;
    dataMap['images_url'] = imagesUrl;
    dataMap['brand_id'] = brandId;
    dataMap['category_level1_id'] = categoryLevel1Id;
    dataMap['category_level2_id'] = categoryLevel2Id;
    dataMap['category_level3_id'] = categoryLevel3Id;
    dataMap['updated_by'] = updatedBy;
    dataMap['deleted_by'] = deletedBy;
    dataMap['is_approved'] = isApproved;
    dataMap['no_of_orders'] = noOfOrders;
    dataMap['deleted_at'] = deletedAt;
    dataMap['created_at'] = createdAt;
    dataMap['updated_at'] = updatedAt;
    if (variant != null) dataMap['variant'] = variant!.toJson();
    dataMap['brand_name'] = brandName;
    if (merchant != null) dataMap['merchant'] = merchant!.toJson();
    dataMap['reviews'] = reviews;
    return dataMap;
  }
}

class DetailMerchant {
  int? id;
  String? name;
  String? email;
  String? username;
  String? phoneNo;
  String? city;
  String? image;

  DetailMerchant(
      {this.id,
        this.name,
        this.email,
        this.username,
        this.phoneNo,
        this.city,
        this.image});

  DetailMerchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    phoneNo = json['phone_no'];
    city = json['city'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['id'] = id;
    dataMap['name'] = name;
    dataMap['email'] = email;
    dataMap['username'] = username;
    dataMap['phone_no'] = phoneNo;
    dataMap['city'] = city;
    dataMap['image'] = image;
    return dataMap;
  }
}

class DetailColors {
  int? id;
  int? productId;
  int? size;
  int? color;
  int? price;
  String? offerPrice;
  int? quantity;
  int? isAvailable;
  String? createdAt;
  String? updatedAt;
  String? hexCode;
  String? colorName;
  String? sizeName;

  DetailColors(
      {this.id,
        this.productId,
        this.size,
        this.color,
        this.price,
        this.offerPrice,
        this.quantity,
        this.isAvailable,
        this.createdAt,
        this.updatedAt,
        this.hexCode,
        this.colorName,
        this.sizeName});

  DetailColors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    size = json['size'];
    color = json['color'];
    price = json['price'];
    offerPrice = json['offer_price'];
    quantity = json['quantity'];
    isAvailable = json['is_available'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hexCode = json['hex_code'];
    colorName = json['color_name'];
    sizeName = json['size_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['id'] = id;
    dataMap['product_id'] = productId;
    dataMap['size'] = size;
    dataMap['color'] = color;
    dataMap['price'] = price;
    dataMap['offer_price'] = offerPrice;
    dataMap['quantity'] = quantity;
    dataMap['is_available'] = isAvailable;
    dataMap['created_at'] = createdAt;
    dataMap['updated_at'] = updatedAt;
    dataMap['hex_code'] = hexCode;
    dataMap['color_name'] = colorName;
    dataMap['size_name'] = sizeName;
    return dataMap;
  }
}

class DetailSizes {
  int? id;
  int? productId;
  int? size;
  int? color;
  int? price;
  String? offerPrice;
  int? quantity;
  int? isAvailable;
  String? createdAt;
  String? updatedAt;
  String? colorName;
  String? sizeName;

  DetailSizes(
      {this.id,
        this.productId,
        this.size,
        this.color,
        this.price,
        this.offerPrice,
        this.quantity,
        this.isAvailable,
        this.createdAt,
        this.updatedAt,
        this.colorName,
        this.sizeName});

  DetailSizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    size = json['size'];
    color = json['color'];
    price = json['price'];
    offerPrice = json['offer_price'];
    quantity = json['quantity'];
    isAvailable = json['is_available'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    colorName = json['color_name'];
    sizeName = json['size_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['id'] = id;
    dataMap['product_id'] = productId;
    dataMap['size'] = size;
    dataMap['color'] = color;
    dataMap['price'] = price;
    dataMap['offer_price'] = offerPrice;
    dataMap['quantity'] = quantity;
    dataMap['is_available'] = isAvailable;
    dataMap['created_at'] = createdAt;
    dataMap['updated_at'] = updatedAt;
    dataMap['color_name'] = colorName;
    dataMap['size_name'] = sizeName;
    return dataMap;
  }
}


// ---------------------- Privacy Policy Models ----------------------

class PrivacyPolicyResponse {
  int? status;
  String? message;
  PrivacyPolicyData? data;

  PrivacyPolicyResponse({this.status, this.message, this.data});

  PrivacyPolicyResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
    json['data'] != null ? PrivacyPolicyData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['status'] = status;
    dataMap['message'] = message;
    if (data != null) dataMap['data'] = data!.toJson();
    return dataMap;
  }
}

class PrivacyPolicyData {
  PrivacyPolicyContent? content;

  PrivacyPolicyData({this.content});

  PrivacyPolicyData.fromJson(Map<String, dynamic> json) {
    content = json['content'] != null
        ? PrivacyPolicyContent.fromJson(json['content'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    if (content != null) dataMap['content'] = content!.toJson();
    return dataMap;
  }
}

class PrivacyPolicyContent {
  int? id;
  String? name;
  String? slug;
  String? keyWords;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;

  PrivacyPolicyContent(
      {this.id,
        this.name,
        this.slug,
        this.keyWords,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt});

  PrivacyPolicyContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    keyWords = json['key_words'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['id'] = id;
    dataMap['name'] = name;
    dataMap['slug'] = slug;
    dataMap['key_words'] = keyWords;
    dataMap['description'] = description;
    dataMap['status'] = status;
    dataMap['created_at'] = createdAt;
    dataMap['updated_at'] = updatedAt;
    return dataMap;
  }
}

//----------------------------Get Address----------------------------

class GetAddressesResponse {
  int? status;
  String? message;
  DataAddd? data;

  GetAddressesResponse({this.status, this.message, this.data});

  GetAddressesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DataAddd.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}

class DataAddd {
  List<Addressesee>? addresses;

  DataAddd({this.addresses});

  DataAddd.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addresses = <Addressesee>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addressesee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (addresses != null) {
      map['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Addressesee {
  int? id;
  int? userId;
  String? name;
  String? email;
  String? phoneNo;
  String? address;
  String? billingAddress;
  String? city;
  int? status;
  int? isDefault;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? cityName;
  TCityy? tCity;

  Addressesee({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.phoneNo,
    this.address,
    this.billingAddress,
    this.city,
    this.status,
    this.isDefault,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.cityName,
    this.tCity,
  });

  Addressesee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    address = json['address'];
    billingAddress = json['billing_address'];
    city = json['city'];
    status = json['status'];
    isDefault = json['is_default'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cityName = json['city_name'];
    tCity = json['t_city'] != null ? TCityy.fromJson(json['t_city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['user_id'] = userId;
    map['name'] = name;
    map['email'] = email;
    map['phone_no'] = phoneNo;
    map['address'] = address;
    map['billing_address'] = billingAddress;
    map['city'] = city;
    map['status'] = status;
    map['is_default'] = isDefault;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['city_name'] = cityName;
    if (tCity != null) {
      map['t_city'] = tCity!.toJson();
    }
    return map;
  }
}

class TCityy {
  int? id;
  String? name;
  int? tHubId;
  String? tHubName;
  int? tId;
  int? tZoneId;
  String? tZoneName;
  int? tPickup;
  String? createdAt;
  String? updatedAt;

  TCityy({
    this.id,
    this.name,
    this.tHubId,
    this.tHubName,
    this.tId,
    this.tZoneId,
    this.tZoneName,
    this.tPickup,
    this.createdAt,
    this.updatedAt,
  });

  TCityy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tHubId = json['t_hub_id'];
    tHubName = json['t_hub_name'];
    tId = json['t_id'];
    tZoneId = json['t_zone_id'];
    tZoneName = json['t_zone_name'];
    tPickup = json['t_pickup'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['t_hub_id'] = tHubId;
    map['t_hub_name'] = tHubName;
    map['t_id'] = tId;
    map['t_zone_id'] = tZoneId;
    map['t_zone_name'] = tZoneName;
    map['t_pickup'] = tPickup;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}


//--------------------------Home category products---------------------

class GetCategoryHomeModelResponsee {
  int? status;
  String? message;
  DataCatt? data;

  GetCategoryHomeModelResponsee({this.status, this.message, this.data});

  GetCategoryHomeModelResponsee.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DataCatt.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}

class DataCatt {
  List<CategoryProductHomee>? categoryProducts;

  DataCatt({this.categoryProducts});

  DataCatt.fromJson(Map<String, dynamic> json) {
    if (json['category_products'] != null) {
      categoryProducts = <CategoryProductHomee>[];
      json['category_products'].forEach((v) {
        categoryProducts!.add(CategoryProductHomee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (categoryProducts != null) {
      map['category_products'] =
          categoryProducts!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

//---------------------------Place order

class PlaceOrderResponsee {
  int? status;
  String? message;
  DataPlaceOrderr? data;

  PlaceOrderResponsee({this.status, this.message, this.data});

  PlaceOrderResponsee.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DataPlaceOrderr.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}

class DataPlaceOrderr {
  List<String>? orderIds;

  DataPlaceOrderr({this.orderIds});

  DataPlaceOrderr.fromJson(Map<String, dynamic> json) {
    orderIds = json['order_ids'] != null
        ? List<String>.from(json['order_ids'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (orderIds != null) {
      map['order_ids'] = orderIds;
    }
    return map;
  }
}

//--------------------------Apply coupon code-----------------------------

class VoucherResponsee {
  int? status;
  String? message;
  VoucherDataaa? data;

  VoucherResponsee({this.status, this.message, this.data});

  VoucherResponsee.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
    json['data'] != null ? VoucherDataaa.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}

class VoucherDataaa {
  String? discountAmount;
  String? total;

  VoucherDataaa({this.discountAmount, this.total});

  VoucherDataaa.fromJson(Map<String, dynamic> json) {
    discountAmount = json['discount_amount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['discount_amount'] = discountAmount;
    map['total'] = total;
    return map;
  }
}

//---------------------------AvailPoints ---------------------------------

class AvailPointsListResponsee {
  int? status;
  String? message;
  VoucherPointsDataa? data;

  AvailPointsListResponsee({this.status, this.message, this.data});

  factory AvailPointsListResponsee.fromJson(Map<String, dynamic> json) {
    return AvailPointsListResponsee(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? VoucherPointsDataa.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class VoucherPointsDataa {
  List<AvailPointt>? availPoints;

  VoucherPointsDataa({this.availPoints});

  factory VoucherPointsDataa.fromJson(Map<String, dynamic> json) {
    return VoucherPointsDataa(
      availPoints: json['avail_points'] != null
          ? List<AvailPointt>.from(
          json['avail_points'].map((x) => AvailPointt.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avail_points': availPoints?.map((x) => x.toJson()).toList(),
    };
  }
}

class AvailPointt {
  int? amount;
  int? points;

  AvailPointt({this.amount, this.points});

  factory AvailPointt.fromJson(Map<String, dynamic> json) {
    return AvailPointt(
      amount: json['amount'] is String
          ? int.tryParse(json['amount'])
          : json['amount'],
      points: json['points'] is String
          ? int.tryParse(json['points'])
          : json['points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'points': points,
    };
  }
}

//--------------------------Menu Models------------------------------------

class CategoryResponsee {
  int? status;
  String? message;
  CategoryDataa? data;

  CategoryResponsee({this.status, this.message, this.data});

  factory CategoryResponsee.fromJson(Map<String, dynamic> json) {
    return CategoryResponsee(
      status: json['status'],
      message: json['message'],
      data:
      json['data'] != null ? CategoryDataa.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class CategoryDataa {
  List<Categoryymeny>? category;

  CategoryDataa({this.category});

  factory CategoryDataa.fromJson(Map<String, dynamic> json) {
    return CategoryDataa(
      category: json['category'] != null
          ? List<Categoryymeny>.from(
          json['category'].map((x) => Categoryymeny.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category?.map((x) => x.toJson()).toList(),
    };
  }
}

class Categoryymeny {
  int? id;
  String? name;
  String? image;
  String? imagePath;

  Categoryymeny({this.id, this.name, this.image, this.imagePath});

  factory Categoryymeny.fromJson(Map<String, dynamic> json) {
    return Categoryymeny(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      name: json['name'],
      image: json['image'],
      imagePath: json['image_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'image_path': imagePath,
    };
  }
}

//----------------------------Color Response-----------------------------

class ColorsResponsee {
  int? status;
  String? message;
  DataSizee? data;

  ColorsResponsee({this.status, this.message, this.data});

  factory ColorsResponsee.fromJson(Map<String, dynamic> json) {
    return ColorsResponsee(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? DataSizee.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class DataSizee {
  List<DetailColors>? colors;

  DataSizee({this.colors});

  factory DataSizee.fromJson(Map<String, dynamic> json) {
    return DataSizee(
      colors: json['colors'] != null
          ? List<DetailColors>.from(json['colors'].map((x) => DetailColors.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'colors': colors?.map((x) => x.toJson()).toList(),
    };
  }
}

//-----------------------Search -----------------------------------------

class ProductResponsee {
  int? status;
  String? message;
  ProductDataa? data;

  ProductResponsee({this.status, this.message, this.data});

  factory ProductResponsee.fromJson(Map<String, dynamic> json) {
    return ProductResponsee(
      status: json['status'] is String
          ? int.tryParse(json['status'])
          : json['status'],
      message: json['message'],
      data:
      json['data'] != null ? ProductDataa.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class ProductDataa {
  List<CategoryProductHomee>? products;
  bool? hasMorePage;
  int? currentPage;
  int? totalPages;

  ProductDataa({
    this.products,
    this.hasMorePage,
    this.currentPage,
    this.totalPages,
  });

  factory ProductDataa.fromJson(Map<String, dynamic> json) {
    return ProductDataa(
      products: json['products'] != null
          ? (json['products'] as List)
          .map((e) => CategoryProductHomee.fromJson(e))
          .toList()
          : [],
      hasMorePage: json['has_more_page'] is String
          ? json['has_more_page'].toString().toLowerCase() == 'true'
          : json['has_more_page'],
      currentPage: json['current_page'] is String
          ? int.tryParse(json['current_page'])
          : json['current_page'],
      totalPages: json['totalPages'] is String
          ? int.tryParse(json['totalPages'])
          : json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products?.map((e) => e.toJson()).toList(),
      'has_more_page': hasMorePage,
      'current_page': currentPage,
      'totalPages': totalPages,
    };
  }
}

//------------Get Followers----------------

class FollowMyFollowersResponse {
  int? status;
  String? message;
  FollowDataa? data;

  FollowMyFollowersResponse({this.status, this.message, this.data});

  FollowMyFollowersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? FollowDataa.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class FollowDataa {
  List<FollowMyFollower>? myFollowes;

  FollowDataa({this.myFollowes});

  FollowDataa.fromJson(Map<String, dynamic> json) {
    if (json['my_followes'] != null) {
      myFollowes = <FollowMyFollower>[];
      json['my_followes'].forEach((v) {
        myFollowes!.add(FollowMyFollower.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (myFollowes != null) {
      data['my_followes'] = myFollowes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FollowMyFollower {
  int? id;
  int? merchantId;
  int? followerId;
  String? createdAt;
  String? updatedAt;
  FollowMerchantt? merchant;

  FollowMyFollower(
      {this.id,
        this.merchantId,
        this.followerId,
        this.createdAt,
        this.updatedAt,
        this.merchant});

  FollowMyFollower.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantId = json['merchant_id'];
    followerId = json['follower_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    merchant =
    json['merchant'] != null ? FollowMerchantt.fromJson(json['merchant']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['merchant_id'] = merchantId;
    data['follower_id'] = followerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (merchant != null) {
      data['merchant'] = merchant!.toJson();
    }
    return data;
  }
}

class FollowMerchantt {
  int? id;
  String? name;
  String? email;
  String? username;
  String? emailVerifiedAt;
  int? type;
  String? image;
  String? phoneNo;
  String? address;
  String? city;
  String? dateOfBirth;
  String? postalCode;
  int? merchantId;
  String? cnic;
  String? bankName;
  String? bankAccountTitle;
  String? bankAccountNumber;
  String? facebookLink;
  String? instagramLink;
  String? tiktokLink;
  int? newsletter;
  int? official;
  int? status;
  int? isApproved;
  String? guestToken;
  int? isGuest;
  String? createdAt;
  String? updatedAt;
  String? gUserId;
  String? imagePath;
  int? walletAmount;
  FollowMerchantProfile? merchantProfile;
  dynamic wallet;

  FollowMerchantt(
      {this.id,
        this.name,
        this.email,
        this.username,
        this.emailVerifiedAt,
        this.type,
        this.image,
        this.phoneNo,
        this.address,
        this.city,
        this.dateOfBirth,
        this.postalCode,
        this.merchantId,
        this.cnic,
        this.bankName,
        this.bankAccountTitle,
        this.bankAccountNumber,
        this.facebookLink,
        this.instagramLink,
        this.tiktokLink,
        this.newsletter,
        this.official,
        this.status,
        this.isApproved,
        this.guestToken,
        this.isGuest,
        this.createdAt,
        this.updatedAt,
        this.gUserId,
        this.imagePath,
        this.walletAmount,
        this.merchantProfile,
        this.wallet});

  FollowMerchantt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    emailVerifiedAt = json['email_verified_at'];
    type = json['type'];
    image = json['image'];
    phoneNo = json['phone_no'];
    address = json['address'];
    city = json['city'];
    dateOfBirth = json['date_of_birth'];
    postalCode = json['postal_code'];
    merchantId = json['merchant_id'];
    cnic = json['cnic'];
    bankName = json['bank_name'];
    bankAccountTitle = json['bank_account_title'];
    bankAccountNumber = json['bank_account_number'];
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    tiktokLink = json['tiktok_link'];
    newsletter = json['newsletter'];
    official = json['official'];
    status = json['status'];
    isApproved = json['is_approved'];
    guestToken = json['guest_token'];
    isGuest = json['is_guest'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    gUserId = json['g_user_id'];
    imagePath = json['image_path'];
    walletAmount = json['wallet_amount'];
    merchantProfile = json['merchant_profile'] != null
        ? FollowMerchantProfile.fromJson(json['merchant_profile'])
        : null;
    wallet = json['wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['username'] = username;
    data['email_verified_at'] = emailVerifiedAt;
    data['type'] = type;
    data['image'] = image;
    data['phone_no'] = phoneNo;
    data['address'] = address;
    data['city'] = city;
    data['date_of_birth'] = dateOfBirth;
    data['postal_code'] = postalCode;
    data['merchant_id'] = merchantId;
    data['cnic'] = cnic;
    data['bank_name'] = bankName;
    data['bank_account_title'] = bankAccountTitle;
    data['bank_account_number'] = bankAccountNumber;
    data['facebook_link'] = facebookLink;
    data['instagram_link'] = instagramLink;
    data['tiktok_link'] = tiktokLink;
    data['newsletter'] = newsletter;
    data['official'] = official;
    data['status'] = status;
    data['is_approved'] = isApproved;
    data['guest_token'] = guestToken;
    data['is_guest'] = isGuest;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['g_user_id'] = gUserId;
    data['image_path'] = imagePath;
    data['wallet_amount'] = walletAmount;
    if (merchantProfile != null) {
      data['merchant_profile'] = merchantProfile!.toJson();
    }
    data['wallet'] = wallet;
    return data;
  }
}

class FollowMerchantProfile {
  int? id;
  int? userId;
  String? brandName;
  String? sellerType;
  String? tax;
  String? code;
  String? city;
  String? hasWebsite;
  String? businessOperation;
  String? catalogueSize;
  String? supplyChain;
  String? productionInventory;
  String? rating;
  String? feedback;
  String? websiteUrl;
  String? socialUrl;
  int? commission;
  String? warehouseAddress;
  String? businessAddress;
  int? isAffiliate;
  String? affiliateCode;
  int? affiliateRegistrationCommission;
  int? registrationFees;
  String? createdAt;
  String? updatedAt;
  int? tPickupId;
  int? cityId;

  FollowMerchantProfile(
      {this.id,
        this.userId,
        this.brandName,
        this.sellerType,
        this.tax,
        this.code,
        this.city,
        this.hasWebsite,
        this.businessOperation,
        this.catalogueSize,
        this.supplyChain,
        this.productionInventory,
        this.rating,
        this.feedback,
        this.websiteUrl,
        this.socialUrl,
        this.commission,
        this.warehouseAddress,
        this.businessAddress,
        this.isAffiliate,
        this.affiliateCode,
        this.affiliateRegistrationCommission,
        this.registrationFees,
        this.createdAt,
        this.updatedAt,
        this.tPickupId,
        this.cityId});

  FollowMerchantProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    brandName = json['brand_name'];
    sellerType = json['seller_type'];
    tax = json['tax'];
    code = json['code'];
    city = json['city'];
    hasWebsite = json['has_website'];
    businessOperation = json['business_operation'];
    catalogueSize = json['catalogue_size'];
    supplyChain = json['supply_chain'];
    productionInventory = json['production_inventory'];
    rating = json['rating'];
    feedback = json['feedback'];
    websiteUrl = json['website_url'];
    socialUrl = json['social_url'];
    commission = json['commission'];
    warehouseAddress = json['warehouse_address'];
    businessAddress = json['business_address'];
    isAffiliate = json['is_affiliate'];
    affiliateCode = json['affiliate_code'];
    affiliateRegistrationCommission = json['affiliate_registration_commission'];
    registrationFees = json['registration_fees'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tPickupId = json['t_pickup_id'];
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['brand_name'] = brandName;
    data['seller_type'] = sellerType;
    data['tax'] = tax;
    data['code'] = code;
    data['city'] = city;
    data['has_website'] = hasWebsite;
    data['business_operation'] = businessOperation;
    data['catalogue_size'] = catalogueSize;
    data['supply_chain'] = supplyChain;
    data['production_inventory'] = productionInventory;
    data['rating'] = rating;
    data['feedback'] = feedback;
    data['website_url'] = websiteUrl;
    data['social_url'] = socialUrl;
    data['commission'] = commission;
    data['warehouse_address'] = warehouseAddress;
    data['business_address'] = businessAddress;
    data['is_affiliate'] = isAffiliate;
    data['affiliate_code'] = affiliateCode;
    data['affiliate_registration_commission'] =
        affiliateRegistrationCommission;
    data['registration_fees'] = registrationFees;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['t_pickup_id'] = tPickupId;
    data['city_id'] = cityId;
    return data;
  }
}



//------------------ProductByBrand for color and size------------------------------

class PBBGetProductByBrand {
  int? status;
  String? message;
  PBBData? data;

  PBBGetProductByBrand({this.status, this.message, this.data});

  factory PBBGetProductByBrand.fromJson(Map<String, dynamic> json) =>
      PBBGetProductByBrand(
        status: json["status"] is String
            ? int.tryParse(json["status"])
            : json["status"],
        message: json["message"]?.toString(),
        data: json["data"] != null ? PBBData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class PBBData {
  bool? hasMorePage;
  int? currentPage;
  int? followers;
  String? brandName;
  int? totalPages;
  List<PBBSizes>? sizes;
  List<PBBColors>? colors;

  PBBData({
    this.hasMorePage,
    this.currentPage,
    this.followers,
    this.brandName,
    this.totalPages,
    this.sizes,
    this.colors,
  });

  factory PBBData.fromJson(Map<String, dynamic> json) => PBBData(
    hasMorePage: json["has_more_page"] == true ||
        json["has_more_page"] == "true",
    currentPage: json["current_page"] is String
        ? int.tryParse(json["current_page"])
        : json["current_page"],
    followers: json["followers"] is String
        ? int.tryParse(json["followers"])
        : json["followers"],
    brandName: json["brand_name"]?.toString(),
    totalPages: json["totalPages"] is String
        ? int.tryParse(json["totalPages"])
        : json["totalPages"],
    sizes: (json["sizes"] as List?)
        ?.map((e) => PBBSizes.fromJson(e))
        .toList(),
    colors: (json["colors"] as List?)
        ?.map((e) => PBBColors.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    "has_more_page": hasMorePage,
    "current_page": currentPage,
    "followers": followers,
    "brand_name": brandName,
    "totalPages": totalPages,
    "sizes": sizes?.map((e) => e.toJson()).toList(),
    "colors": colors?.map((e) => e.toJson()).toList(),
  };
}

class PBBSizes {
  int? id;
  String? size;
  String? type;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  PBBSizes({
    this.id,
    this.size,
    this.type,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory PBBSizes.fromJson(Map<String, dynamic> json) => PBBSizes(
    id: json["id"] is String ? int.tryParse(json["id"]) : json["id"],
    size: json["size"]?.toString(),
    type: json["type"]?.toString(),
    updatedBy: json["updated_by"]?.toString(),
    deletedBy: json["deleted_by"]?.toString(),
    deletedAt: json["deleted_at"]?.toString(),
    createdAt: json["created_at"]?.toString(),
    updatedAt: json["updated_at"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "size": size,
    "type": type,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class PBBColors {
  int? id;
  String? color;
  String? hexCode;
  String? type;
  int? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  PBBColors({
    this.id,
    this.color,
    this.hexCode,
    this.type,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory PBBColors.fromJson(Map<String, dynamic> json) => PBBColors(
    id: json["id"] is String ? int.tryParse(json["id"]) : json["id"],
    color: json["color"]?.toString(),
    hexCode: json["hex_code"]?.toString(),
    type: json["type"]?.toString(),
    updatedBy: json["updated_by"] is String
        ? int.tryParse(json["updated_by"])
        : json["updated_by"],
    deletedBy: json["deleted_by"]?.toString(),
    deletedAt: json["deleted_at"]?.toString(),
    createdAt: json["created_at"]?.toString(),
    updatedAt: json["updated_at"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "color": color,
    "hex_code": hexCode,
    "type": type,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

  @override
  String toString() => color ?? "Unknown";
}

//----------------------Real Products by brand------------------------------------


class BrandGetProductByBrandLast {
  int? status;
  String? message;
  BrandDataLast? data;

  BrandGetProductByBrandLast({this.status, this.message, this.data});

  factory BrandGetProductByBrandLast.fromJson(Map<String, dynamic> json) {
    return BrandGetProductByBrandLast(
      status: int.tryParse(json['status']?.toString() ?? ''),
      message: json['message']?.toString(),
      data:
      json['data'] != null ? BrandDataLast.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class BrandDataLast {
  List<BrandProductsLast>? products;
  bool? hasMorePage;
  int? currentPage;
  int? followers;
  String? brandName;
  int? totalPages;
  BrandBrandLast? brand;
  List<BrandCategoryLevel1Last>? categoryLevel1;
  List<BrandSizesLast>? sizes;
  List<BrandColorsLast>? colors;

  BrandDataLast({
    this.products,
    this.hasMorePage,
    this.currentPage,
    this.followers,
    this.brandName,
    this.totalPages,
    this.brand,
    this.categoryLevel1,
    this.sizes,
    this.colors,
  });

  factory BrandDataLast.fromJson(Map<String, dynamic> json) {
    return BrandDataLast(
      products: (json['products'] as List?)
          ?.map((e) => BrandProductsLast.fromJson(e))
          .toList(),
      hasMorePage: json['has_more_page'] == true ||
          json['has_more_page']?.toString() == "1",
      currentPage: int.tryParse(json['current_page']?.toString() ?? ''),
      followers: int.tryParse(json['followers']?.toString() ?? ''),
      brandName: json['brand_name']?.toString(),
      totalPages: int.tryParse(json['totalPages']?.toString() ?? ''),
      brand: json['brand'] != null
          ? BrandBrandLast.fromJson(json['brand'])
          : null,
      categoryLevel1: (json['category_level1'] as List?)
          ?.map((e) => BrandCategoryLevel1Last.fromJson(e))
          .toList(),
      sizes: (json['sizes'] as List?)
          ?.map((e) => BrandSizesLast.fromJson(e))
          .toList(),
      colors: (json['colors'] as List?)
          ?.map((e) => BrandColorsLast.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'products': products?.map((e) => e.toJson()).toList(),
    'has_more_page': hasMorePage,
    'current_page': currentPage,
    'followers': followers,
    'brand_name': brandName,
    'totalPages': totalPages,
    'brand': brand?.toJson(),
    'category_level1': categoryLevel1?.map((e) => e.toJson()).toList(),
    'sizes': sizes?.map((e) => e.toJson()).toList(),
    'colors': colors?.map((e) => e.toJson()).toList(),
  };
}

class BrandProductsLast {
  int? id;
  String? barcode;
  int? merchantId;
  String? name;
  String? slug;
  String? brand;
  String? productType;
  int? isVariant;
  String? keyWords;
  String? description;
  String? summary;
  String? sizes;
  String? colors;
  String? type;
  int? isFeatured;
  double? price;
  double? offerPrice;
  double? quantity;
  String? image;
  String? sizeGuide;
  double? weight;
  List<String>? images;
  String? brandId;
  int? categoryLevel1Id;
  int? categoryLevel2Id;
  int? categoryLevel3Id;
  String? categoryLevel4Id;
  String? updatedBy;
  String? deletedBy;
  int? isApproved;
  int? noOfOrders;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  BrandVariantLast? variant;
  String? imageUrl;
  List<String>? imagesUrl;
  int? isWishlist;
  String? brandName;

  BrandProductsLast({
    this.id,
    this.barcode,
    this.merchantId,
    this.name,
    this.slug,
    this.brand,
    this.productType,
    this.isVariant,
    this.keyWords,
    this.description,
    this.summary,
    this.sizes,
    this.colors,
    this.type,
    this.isFeatured,
    this.price,
    this.offerPrice,
    this.quantity,
    this.image,
    this.sizeGuide,
    this.weight,
    this.images,
    this.brandId,
    this.categoryLevel1Id,
    this.categoryLevel2Id,
    this.categoryLevel3Id,
    this.categoryLevel4Id,
    this.updatedBy,
    this.deletedBy,
    this.isApproved,
    this.noOfOrders,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.variant,
    this.imageUrl,
    this.imagesUrl,
    this.isWishlist,
    this.brandName,
  });

  factory BrandProductsLast.fromJson(Map<String, dynamic> json) {
    return BrandProductsLast(
      id: int.tryParse(json['id']?.toString() ?? ''),
      barcode: json['barcode']?.toString(),
      merchantId: int.tryParse(json['merchant_id']?.toString() ?? ''),
      name: json['name']?.toString(),
      slug: json['slug']?.toString(),
      brand: json['brand']?.toString(),
      productType: json['product_type']?.toString(),
      isVariant: int.tryParse(json['is_variant']?.toString() ?? ''),
      keyWords: json['key_words']?.toString(),
      description: json['description']?.toString(),
      summary: json['summary']?.toString(),
      sizes: json['sizes']?.toString(),
      colors: json['colors']?.toString(),
      type: json['type']?.toString(),
      isFeatured: int.tryParse(json['is_featured']?.toString() ?? ''),
      price: double.tryParse(json['price']?.toString() ?? ''),
      offerPrice: double.tryParse(json['offer_price']?.toString() ?? ''),
      quantity: double.tryParse(json['quantity']?.toString() ?? ''),
      image: json['image']?.toString(),
      sizeGuide: json['size_guide']?.toString(),
      weight: double.tryParse(json['weight']?.toString() ?? ''),
      images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      brandId: json['brand_id']?.toString(),
      categoryLevel1Id:
      int.tryParse(json['category_level1_id']?.toString() ?? ''),
      categoryLevel2Id:
      int.tryParse(json['category_level2_id']?.toString() ?? ''),
      categoryLevel3Id:
      int.tryParse(json['category_level3_id']?.toString() ?? ''),
      categoryLevel4Id: json['category_level4_id']?.toString(),
      updatedBy: json['updated_by']?.toString(),
      deletedBy: json['deleted_by']?.toString(),
      isApproved: int.tryParse(json['is_approved']?.toString() ?? ''),
      noOfOrders: int.tryParse(json['no_of_orders']?.toString() ?? ''),
      deletedAt: json['deleted_at']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      variant: json['variant'] != null
          ? BrandVariantLast.fromJson(json['variant'])
          : null,
      imageUrl: json['image_url']?.toString(),
      imagesUrl:
      (json['images_url'] as List?)?.map((e) => e.toString()).toList(),
      isWishlist: int.tryParse(json['is_wishlist']?.toString() ?? ''),
      brandName: json['brand_name']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'barcode': barcode,
    'merchant_id': merchantId,
    'name': name,
    'slug': slug,
    'brand': brand,
    'product_type': productType,
    'is_variant': isVariant,
    'key_words': keyWords,
    'description': description,
    'summary': summary,
    'sizes': sizes,
    'colors': colors,
    'type': type,
    'is_featured': isFeatured,
    'price': price,
    'offer_price': offerPrice,
    'quantity': quantity,
    'image': image,
    'size_guide': sizeGuide,
    'weight': weight,
    'images': images,
    'brand_id': brandId,
    'category_level1_id': categoryLevel1Id,
    'category_level2_id': categoryLevel2Id,
    'category_level3_id': categoryLevel3Id,
    'category_level4_id': categoryLevel4Id,
    'updated_by': updatedBy,
    'deleted_by': deletedBy,
    'is_approved': isApproved,
    'no_of_orders': noOfOrders,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'variant': variant?.toJson(),
    'image_url': imageUrl,
    'images_url': imagesUrl,
    'is_wishlist': isWishlist,
    'brand_name': brandName,
  };
}

class BrandVariantLast {
  int? id;
  int? size;
  int? color;
  double? price;
  double? offerPrice;
  int? isAvailable;
  int? quantity;

  BrandVariantLast({
    this.id,
    this.size,
    this.color,
    this.price,
    this.offerPrice,
    this.isAvailable,
    this.quantity,
  });

  factory BrandVariantLast.fromJson(Map<String, dynamic> json) {
    return BrandVariantLast(
      id: int.tryParse(json['id']?.toString() ?? ''),
      size: int.tryParse(json['size']?.toString() ?? ''),
      color: int.tryParse(json['color']?.toString() ?? ''),
      price: double.tryParse(json['price']?.toString() ?? ''),
      offerPrice: double.tryParse(json['offer_price']?.toString() ?? ''),
      isAvailable: int.tryParse(json['is_available']?.toString() ?? ''),
      quantity: int.tryParse(json['quantity']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'size': size,
    'color': color,
    'price': price,
    'offer_price': offerPrice,
    'is_available': isAvailable,
    'quantity': quantity,
  };
}

class BrandBrandLast {
  int? id;
  String? name;
  String? email;
  String? username;
  String? emailVerifiedAt;
  int? type;
  String? image;
  String? phoneNo;
  String? address;
  String? city;
  String? dateOfBirth;
  String? postalCode;
  int? merchantId;
  String? cnic;
  String? bankName;
  String? bankAccountTitle;
  String? bankAccountNumber;
  String? facebookLink;
  String? instagramLink;
  String? tiktokLink;
  int? newsletter;
  int? official;
  int? status;
  int? isApproved;
  String? guestToken;
  int? isGuest;
  String? createdAt;
  String? updatedAt;
  String? gUserId;
  String? imagePath;
  double? walletAmount;
  String? wallet;

  BrandBrandLast({
    this.id,
    this.name,
    this.email,
    this.username,
    this.emailVerifiedAt,
    this.type,
    this.image,
    this.phoneNo,
    this.address,
    this.city,
    this.dateOfBirth,
    this.postalCode,
    this.merchantId,
    this.cnic,
    this.bankName,
    this.bankAccountTitle,
    this.bankAccountNumber,
    this.facebookLink,
    this.instagramLink,
    this.tiktokLink,
    this.newsletter,
    this.official,
    this.status,
    this.isApproved,
    this.guestToken,
    this.isGuest,
    this.createdAt,
    this.updatedAt,
    this.gUserId,
    this.imagePath,
    this.walletAmount,
    this.wallet,
  });

  factory BrandBrandLast.fromJson(Map<String, dynamic> json) {
    return BrandBrandLast(
      id: int.tryParse(json['id']?.toString() ?? ''),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      username: json['username']?.toString(),
      emailVerifiedAt: json['email_verified_at']?.toString(),
      type: int.tryParse(json['type']?.toString() ?? ''),
      image: json['image']?.toString(),
      phoneNo: json['phone_no']?.toString(),
      address: json['address']?.toString(),
      city: json['city']?.toString(),
      dateOfBirth: json['date_of_birth']?.toString(),
      postalCode: json['postal_code']?.toString(),
      merchantId: int.tryParse(json['merchant_id']?.toString() ?? ''),
      cnic: json['cnic']?.toString(),
      bankName: json['bank_name']?.toString(),
      bankAccountTitle: json['bank_account_title']?.toString(),
      bankAccountNumber: json['bank_account_number']?.toString(),
      facebookLink: json['facebook_link']?.toString(),
      instagramLink: json['instagram_link']?.toString(),
      tiktokLink: json['tiktok_link']?.toString(),
      newsletter: int.tryParse(json['newsletter']?.toString() ?? ''),
      official: int.tryParse(json['official']?.toString() ?? ''),
      status: int.tryParse(json['status']?.toString() ?? ''),
      isApproved: int.tryParse(json['is_approved']?.toString() ?? ''),
      guestToken: json['guest_token']?.toString(),
      isGuest: int.tryParse(json['is_guest']?.toString() ?? ''),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      gUserId: json['g_user_id']?.toString(),
      imagePath: json['image_path']?.toString(),
      walletAmount: double.tryParse(json['wallet_amount']?.toString() ?? ''),
      wallet: json['wallet']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'username': username,
    'email_verified_at': emailVerifiedAt,
    'type': type,
    'image': image,
    'phone_no': phoneNo,
    'address': address,
    'city': city,
    'date_of_birth': dateOfBirth,
    'postal_code': postalCode,
    'merchant_id': merchantId,
    'cnic': cnic,
    'bank_name': bankName,
    'bank_account_title': bankAccountTitle,
    'bank_account_number': bankAccountNumber,
    'facebook_link': facebookLink,
    'instagram_link': instagramLink,
    'tiktok_link': tiktokLink,
    'newsletter': newsletter,
    'official': official,
    'status': status,
    'is_approved': isApproved,
    'guest_token': guestToken,
    'is_guest': isGuest,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'g_user_id': gUserId,
    'image_path': imagePath,
    'wallet_amount': walletAmount,
    'wallet': wallet,
  };
}

class BrandCategoryLevel1Last {
  int? id;
  String? name;
  String? slug;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? imagePath;

  BrandCategoryLevel1Last({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.imagePath,
  });

  factory BrandCategoryLevel1Last.fromJson(Map<String, dynamic> json) {
    return BrandCategoryLevel1Last(
      id: int.tryParse(json['id']?.toString() ?? ''),
      name: json['name']?.toString(),
      slug: json['slug']?.toString(),
      image: json['image']?.toString(),
      status: int.tryParse(json['status']?.toString() ?? ''),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      imagePath: json['image_path']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'image': image,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'image_path': imagePath,
  };
}

class BrandSizesLast {
  int? id;
  String? size;
  String? type;
  String? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  BrandSizesLast({
    this.id,
    this.size,
    this.type,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory BrandSizesLast.fromJson(Map<String, dynamic> json) {
    return BrandSizesLast(
      id: int.tryParse(json['id']?.toString() ?? ''),
      size: json['size']?.toString(),
      type: json['type']?.toString(),
      updatedBy: json['updated_by']?.toString(),
      deletedBy: json['deleted_by']?.toString(),
      deletedAt: json['deleted_at']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'size': size,
    'type': type,
    'updated_by': updatedBy,
    'deleted_by': deletedBy,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class BrandColorsLast {
  int? id;
  String? color;
  String? hexCode;
  String? type;
  int? updatedBy;
  String? deletedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  BrandColorsLast({
    this.id,
    this.color,
    this.hexCode,
    this.type,
    this.updatedBy,
    this.deletedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory BrandColorsLast.fromJson(Map<String, dynamic> json) {
    return BrandColorsLast(
      id: int.tryParse(json['id']?.toString() ?? ''),
      color: json['color']?.toString(),
      hexCode: json['hex_code']?.toString(),
      type: json['type']?.toString(),
      updatedBy: int.tryParse(json['updated_by']?.toString() ?? ''),
      deletedBy: json['deleted_by']?.toString(),
      deletedAt: json['deleted_at']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'color': color,
    'hex_code': hexCode,
    'type': type,
    'updated_by': updatedBy,
    'deleted_by': deletedBy,
    'deleted_at': deletedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  @override
  String toString() => color ?? "Unknown";
}


