import 'package:appp_sale_29092022/common/bases/base_event.dart';

class FetchProductEvent extends BaseEvent {
  @override
  List<Object?> get props => [];

}

class AddCartEvent extends BaseEvent {
  String idProduct;

  AddCartEvent({required this.idProduct});

  @override
  List<Object?> get props => [];

}