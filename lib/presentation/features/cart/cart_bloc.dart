import 'dart:async';

import 'package:appp_sale_29092022/common/bases/base_bloc.dart';
import 'package:appp_sale_29092022/common/bases/base_event.dart';
import 'package:appp_sale_29092022/data/datasources/remote/dto/app_resource.dart';
import 'package:appp_sale_29092022/data/datasources/remote/dto/product_dto.dart';
import 'package:appp_sale_29092022/data/model/product.dart';
import 'package:appp_sale_29092022/data/repositories/cart_repository.dart';
import 'package:appp_sale_29092022/presentation/features/cart/cart_event.dart';

class CartBloc extends BaseBloc {
  StreamController<List<Product>> _listProductsController = StreamController();
  Stream<List<Product>> get products => _listProductsController.stream;

  late CartRepository _cartRepository;

  void updateCartRepo(CartRepository cartRepository) {
    _cartRepository = cartRepository;
  }


  @override
  void dispatch(BaseEvent event) {
    switch (event.runtimeType) {
      case FetchCartEvent:
        _executeGetProducts(event as FetchCartEvent);
        break;
    }
  }

  void _executeGetProducts(FetchCartEvent event) async{
    loadingSink.add(true);
    try {
      AppResource<List<ProductDTO>> resourceProductDTO = await _cartRepository.getCart();
      if (resourceProductDTO.data == null) return;
      List<ProductDTO> listProductDTO = resourceProductDTO.data ?? List.empty();
      List<Product> listProduct = listProductDTO.map((e){
        return Product(e.id, e.name, e.address, e.price, e.img, e.quantity, e.gallery);
      }).toList();
      _listProductsController.sink.add(listProduct);
      loadingSink.add(false);
    } catch (e) {
      messageSink.add(e.toString());
      loadingSink.add(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _listProductsController.close();
  }
}