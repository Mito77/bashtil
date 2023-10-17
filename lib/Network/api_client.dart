 import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:bashtil/models/header_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;


}
