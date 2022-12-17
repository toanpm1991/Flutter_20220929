import 'dart:async';

import 'package:appp_sale_29092022/common/bases/base_bloc.dart';
import 'package:appp_sale_29092022/common/bases/base_event.dart';
import 'package:appp_sale_29092022/data/datasources/remote/dto/app_resource.dart';
import 'package:appp_sale_29092022/data/datasources/remote/dto/cart_dto.dart';
import 'package:appp_sale_29092022/data/datasources/remote/dto/product_dto.dart';
import 'package:appp_sale_29092022/data/model/cart.dart';
import 'package:appp_sale_29092022/data/model/product.dart';
import 'package:appp_sale_29092022/data/repositories/order_repository.dart';
import 'package:appp_sale_29092022/presentation/features/order/order_event.dart';

class OrderBloc extends BaseBloc {
  StreamController<List<Cart>> _listOrdersController = StreamController();
  Stream<List<Cart>> get orders => _listOrdersController.stream;

  late OrderRepository _orderRepository;

  void updateOrderRepo(OrderRepository orderRepository) {
    _orderRepository = orderRepository;
  }


  @override
  void dispatch(BaseEvent event) {
    switch (event.runtimeType) {
      case FetchOrderEvent:
        _executeGetOrders(event as FetchOrderEvent);
        break;
    }
  }

  void _executeGetOrders(FetchOrderEvent event) async{
    loadingSink.add(true);
    try {
      AppResource<List<CartDTO>> resourceCartDTO = await _orderRepository.getOrders();
      if (resourceCartDTO.data == null) return;
      List<CartDTO> listCartDTO = resourceCartDTO.data ?? List.empty();

      List<Cart> listCart = listCartDTO.map((e){

        List<ProductDTO> productDTO = e.products?? [] ;
        return  Cart(
            e.id,
            productDTO.map<Product>((dto){
              return Product(dto.id, dto.name, dto.address, dto.price, dto.img, dto.quantity, dto.gallery);
            }).toList(),
            e.idUser,
            e.price,
            e.date_created
        );
      }).toList();
      _listOrdersController.sink.add(listCart);
      loadingSink.add(false);
    } catch (e) {
      messageSink.add(e.toString());
      loadingSink.add(false);
    }
  }
}