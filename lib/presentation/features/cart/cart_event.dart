import 'package:appp_sale_29092022/common/bases/base_event.dart';

class FetchCartEvent extends BaseEvent {
  @override
  List<Object?> get props => [];

}


class UpdateCartEvent extends BaseEvent {
  String idProduct;
  String idCart;
  int quantity;

  UpdateCartEvent({required this.idProduct, required this.idCart, required this.quantity});

  @override
  List<Object?> get props => [];

}
class ConfirmCartEvent extends BaseEvent {
  String idCart;

  ConfirmCartEvent({required this.idCart});

  @override
  List<Object?> get props => [];

}

class UpdateCartSuccessEvent extends BaseEvent {
  @override
  List<Object?> get props => [];

}

class UpdateCartFailEvent extends BaseEvent {
  String message;

  UpdateCartFailEvent({required this.message});
  @override
  List<Object?> get props => [];

}

class ConfirmCartSuccessEvent extends BaseEvent {
  @override
  List<Object?> get props => [];

}

class ConfirmCartFailEvent extends BaseEvent {
  String message;

  ConfirmCartFailEvent({required this.message});
  @override
  List<Object?> get props => [];

}