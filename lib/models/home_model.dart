import 'dart:convert';

class HomeModel {
  bool status;
  HomeDataModel dataModel;

  HomeModel.fromJSON(Map<String, dynamic> json) {
    status = json['status'];
    dataModel = HomeDataModel.fromMap(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  HomeDataModel({
    this.banners,
    this.products,
  });

  Map<String, dynamic> toMap() {
    return {
      'banners': banners?.map((x) => x.toMap())?.toList(),
      'products': products?.map((x) => x.toMap())?.toList(),
    };
  }

  factory HomeDataModel.fromMap(Map<String, dynamic> map) {
    return HomeDataModel(
      banners: List<BannerModel>.from(
          map['banners']?.map((x) => BannerModel.fromMap(x))),
      products: List<ProductModel>.from(
          map['products']?.map((x) => ProductModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeDataModel.fromJson(String source) =>
      HomeDataModel.fromMap(json.decode(source));
}

class BannerModel {
  int id;
  String image;
  BannerModel({
    this.id,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source));
}

class ProductModel {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  bool inFavorite;
  bool inCart;
  ProductModel({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.inFavorite,
    this.inCart,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'old_price': oldPrice,
      'discount': discount,
      'image': image,
      'name': name,
      'in_favorites': inFavorite,
      'in_cart': inCart,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      price: map['price'],
      oldPrice: map['old_price'],
      discount: map['discount'],
      image: map['image'],
      name: map['name'],
      inFavorite: map['in_favorites'],
      inCart: map['in_cart'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
