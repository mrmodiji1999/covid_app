import 'package:covid_app/services/retrofit.dart';
import 'package:dio/dio.dart';

void main() async {
  // Create a Dio instance
  final dio = Dio();

  final apiService = ApiService(dio);

  try {
    final response = await apiService.getCovidStates();

    print(response);
  } catch (e) {
    // Handle error
    print(e);
  }
}
