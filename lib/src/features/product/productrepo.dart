import 'package:dio/dio.dart';
import 'package:tgh_test/src/service/dioclient.dart';

class Productrepo {
  Future<Response?> productAPi() async {
    DioClient dioClient = DioClient();
    final response = await dioClient.performCall(
      url: 'https://fakestoreapi.com/products',
      requestType: RequestType.get,
      basicAuth: '',
    );
    return response;
  }
}
