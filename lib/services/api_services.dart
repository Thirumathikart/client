import 'package:get/get_connect/connect.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:thirumathikart_app/constants/api_constants.dart';
import 'package:thirumathikart_app/models/login_request.dart';
import 'package:thirumathikart_app/models/login_response.dart';
import 'package:thirumathikart_app/services/storage_services.dart';

class ApiServices extends GetxService {
  late ApiManager api;

  Future<ApiServices> initApi() async {
    api = ApiManager();
    return this;
  }
}

class ApiManager extends GetConnect {
  final headers = {
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': '*',
  };

  Future<LoginResponse> loginCutomer(
      LoginRequest request, StorageServices storageServices) async {
    try {
      final response =
          await post(ApiConstants.login, request.toJson(), headers: headers);

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        if (response.statusCode == 200 && response.bodyString != null) {
          var loginResponse = loginResponseFromJson(response.bodyString!);
          if (loginResponse.code == 200 && loginResponse.user != null) {
            await storageServices.storeUser(response.bodyString!);
            return loginResponse;
          }
        }
        return Future.error('Unable To Login User');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
