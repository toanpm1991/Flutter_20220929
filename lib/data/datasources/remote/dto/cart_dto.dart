import 'package:appp_sale_29092022/data/datasources/remote/dto/product_dto.dart';

class CartDTO {
  CartDTO({
    this.id,
    this.products,
    this.idUser,
    this.price,
    this.date_created
  });

  CartDTO.fromJson(dynamic json) {
    id = json['_id'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(ProductDTO.fromJson(v));
      });
    }
    idUser = json['id_user'];
    price = json['price'];
    date_created = json['date_created'];
  }

  String? id;
  List<ProductDTO>? products;
  String? idUser;
  num? price;
  String? date_created;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['id_user'] = idUser;
    map['price'] = price;
    map['date_created'] = date_created;
    return map;
  }

  static CartDTO convertJson(dynamic json) => CartDTO.fromJson(json);
}