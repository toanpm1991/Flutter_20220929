import 'dart:async';

import 'package:appp_sale_29092022/data/datasources/remote/api_request.dart';
import 'package:appp_sale_29092022/data/datasources/remote/dto/app_resource.dart';
import 'package:appp_sale_29092022/data/datasources/remote/dto/cart_dto.dart';
import 'package:dio/dio.dart';

class CartRepository {
  late ApiRequest _apiRequest;

  void updateApiRequest(ApiRequest apiRequest) {
    _apiRequest = apiRequest;
  }

  Future<AppResource<CartDTO>> getCart() async{
    Completer<AppResource<CartDTO>> completer = Completer();
    try {
      Response<dynamic> response =  await _apiRequest.getCart();
      // TODO: Improve use Isolate
      AppResource<CartDTO> resourceCartDTO = AppResource.fromJson(response.data, CartDTO.fromJson);
      completer.complete(resourceCartDTO);
    } on DioError catch (dioError) {
      completer.completeError(dioError.response?.data["message"]);
    } catch(e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<AppResource<CartDTO>> updateCart(String idProduct, String idCart, int quantity) async{
    Completer<AppResource<CartDTO>> completer = Completer();
    try {
      Response<dynamic> response =  await _apiRequest.updateCart(idProduct,idCart,quantity);
      // TODO: Improve use Isolate
      AppResource<CartDTO> resourceCartDTO = AppResource.fromJson(response.data, CartDTO.fromJson);
      completer.complete(resourceCartDTO);
    } on DioError catch (dioError) {
      completer.completeError(dioError.response?.data["message"]);
    } catch(e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future confirmCart(String idCart) async{
    Completer completer = Completer();
    try {
      Response<dynamic> response =  await _apiRequest.confirmCart(idCart);
      // TODO: Improve use Isolate
      completer.complete(AppResource<dynamic>());
    } on DioError catch (dioError) {
      completer.completeError(dioError.response?.data["message"]);
    } catch(e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}