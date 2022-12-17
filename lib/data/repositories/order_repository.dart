import 'dart:async';

import 'package:appp_sale_29092022/data/datasources/remote/api_request.dart';
import 'package:appp_sale_29092022/data/datasources/remote/dto/app_resource.dart';
import 'package:appp_sale_29092022/data/datasources/remote/dto/cart_dto.dart';
import 'package:dio/dio.dart';

class OrderRepository {
  late ApiRequest _apiRequest;

  void updateApiRequest(ApiRequest apiRequest) {
    _apiRequest = apiRequest;
  }

  Future<AppResource<List<CartDTO>>> getOrders() async{
    Completer<AppResource<List<CartDTO>>> completer = Completer();
    try {
      Response<dynamic> response =  await _apiRequest.getOrder();
      // TODO: Improve use Isolate
      AppResource<List<CartDTO>> resourceOrderDTO = AppResource.fromJson(response.data, (listData){
        return (listData as List).map((e) => CartDTO.fromJson(e)).toList();
      });
      completer.complete(resourceOrderDTO);
    } on DioError catch (dioError) {
      completer.completeError(dioError.response?.data["message"]);
    } catch(e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}