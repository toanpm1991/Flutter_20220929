import 'package:appp_sale_29092022/data/datasources/remote/dto/product_dto.dart';

class CartDTO {
  CartDTO({
    this.id,
    this.products,
    this.idUser,
    this.price
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
  }

  String? id;
  List<ProductDTO>? products;
  String? idUser;
  num? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['id_user'] = idUser;
    map['price'] = price;
    return map;
  }

  static CartDTO convertJson(dynamic json) => CartDTO.fromJson(json);
}