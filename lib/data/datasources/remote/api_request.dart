import 'package:appp_sale_29092022/common/constants/api_constant.dart';
import 'package:appp_sale_29092022/data/datasources/local/cache/app_cache.dart';
import 'package:appp_sale_29092022/data/datasources/remote/dio_client.dart';
import 'package:dio/dio.dart';

class ApiRequest {
  late Dio _dio;

  late String token = AppCache.getString("token");

  ApiRequest() {
    _dio = DioClient.instance.dio;
  }

  Future signInRequest(String email, String password) {
    return _dio.post(ApiConstant.SIGN_IN, data: {
      "email": email,
      "password": password
    });
  }

  Future signUpRequest(
      String name,
      String email,
      String phone,
      String password,
      String address
  ) {
    return _dio.post(ApiConstant.SIGN_UP, data: {
      "name": name,
      "phone": phone,
      "address": address,
      "email": email,
      "password": password
    });
  }

  Future getProducts() {
    return _dio.get(ApiConstant.PRODUCTS);
  }
  Future getCart() {
    return _dio.get(ApiConstant.GET_CART,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Bearer $token",
        }));
  }
  Future addCart(String idProduct) {
    return _dio.post(ApiConstant.ADD_CART,
        data:{
          "id_product":idProduct
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Bearer $token",
        }));
  }
  Future updateCart(String idProduct, String idCard, int quantity) {
    return _dio.post(ApiConstant.UPDATE_CART,
        data:{
          "id_product":idProduct,
          "id_cart":idCard,
          "quantity":quantity,
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Bearer $token",
        }));
  }
  Future confirmCart(String idCard) {
    return _dio.post(ApiConstant.CONFIRM_CART,
        data:{
          "id_cart":idCard,
          "status":"false",
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Bearer $token",
        }));
  }

  Future getOrder() {
    return _dio.post(ApiConstant.ORDER_HISTORY,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Bearer $token",
        }));
  }
}