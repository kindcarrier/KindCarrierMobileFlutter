import 'package:http/http.dart' as http;
import 'package:kind_carrier/consts.dart';

Future<http.Response> logIn({String email, String password}) {
  return http.post('$BASE_URL/session', body: {
    'email': email,
    'password': password,
  });
}

Future<http.Response> signUp({String firstName, String lastName, String email, String password}) {
  return http.post('$BASE_URL/users', body: {
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'password': password,
  });
}
