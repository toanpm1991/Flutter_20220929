class ProductDTO {
  String? id;
  String? name;
  String? address;
  int? price;
  String? img;
  int? quantity;
  List<String>? gallery;

  ProductDTO(
      {this.id,
      this.name,
      this.address,
      this.price,
      this.img,
      this.quantity,
      this.gallery});

  ProductDTO.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    address = json['address'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    gallery = json['gallery'].cast<String>();
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['address'] = address;
    map['price'] = price;
    map['img'] = img;
    map['quantity'] = quantity;
    map['gallery'] = gallery;
    return map;
  }

  @override
  String toString() {
    return 'ProductDTO{id: $id, name: $name, address: $address, price: $price, img: $img, quantity: $quantity, gallery: $gallery}';
  }
}
