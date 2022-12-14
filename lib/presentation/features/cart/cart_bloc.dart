import 'dart:async';

import 'package:appp_sale_29092022/common/bases/base_bloc.dart';
import 'package:appp_sale_29092022/common/bases/base_event.dart';
import 'package:appp_sale_29092022/data/datasources/remote/dto/app_resource.dart';
import 'package:appp_sale_29092022/data/datasources/remote/dto/cart_dto.dart';
import 'package:appp_sale_29092022/data/model/cart.dart';
import 'package:appp_sale_29092022/data/model/product.dart';
import 'package:appp_sale_29092022/data/repositories/cart_repository.dart';
import 'package:appp_sale_29092022/presentation/features/cart/cart_event.dart';

class CartBloc extends BaseBloc {
  StreamController<Cart> _cartController = StreamController();
  Stream<Cart> get cart => _cartController.stream;

  late CartRepository _cartRepository;

  void updateCartRepo(CartRepository cartRepository) {
    _cartRepository = cartRepository;
  }


  @override
  void dispatch(BaseEvent event) {
    switch (event.runtimeType) {
      case FetchCartEvent:
        _executeGetCartProducts(event as FetchCartEvent);
        break;
    }
  }

  void _executeGetCartProducts(FetchCartEvent event) async{
    loadingSink.add(true);
    try {
      AppResource<CartDTO> resourceCartDTO = await _cartRepository.getCart();
      if (resourceCartDTO.data == null) return;
      CartDTO cartDTO = resourceCartDTO.data?? CartDTO() ;
      Cart listCart = Cart(
          cartDTO.id,
          cartDTO.products?.map<Product>((dto){
            return Product(dto.id, dto.name, dto.address, dto.price, dto.img, dto.quantity, dto.gallery);
          }).toList(),
          cartDTO.idUser,
          cartDTO.price
      );
      _cartController.sink.add(listCart);
      loadingSink.add(false);
    } catch (e) {
      messageSink.add(e.toString());
      loadingSink.add(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _cartController.close();
  }
}