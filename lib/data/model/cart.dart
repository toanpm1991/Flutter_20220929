



import 'package:appp_sale_29092022/data/datasources/remote/dto/product_dto.dart';
import 'package:appp_sale_29092022/data/model/product.dart';

class Cart {
  late String id;
  late List<Product> products;
  late String idUser;
  late num price;

  Cart([String? id, List<Product>? products, String? idUser, num? price]) {
    this.id = id ?? "";
    this.products = products ?? [];
    this.idUser = idUser ?? "";
    this.price = price ?? 0;
  }
}