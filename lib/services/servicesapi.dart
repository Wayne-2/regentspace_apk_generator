import 'dart:convert';
import 'package:http/http.dart' as http;

class VtuService {
  final String baseUrl = "https://api.yourvtu.com";
  final String apiKey = "YOUR_API_KEY";

  Future<Map<String, dynamic>> buyAirtime({
    required String network,
    required String phone,
    required double amount,
  }) async {
    final url = Uri.parse("$baseUrl/airtime");
    final headers = {
      "Authorization": "Bearer $apiKey",
      "Content-Type": "application/json",
    };
    final body = jsonEncode({
      "network": network,
      "phone": phone,
      "amount": amount,
    });

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Airtime error: ${response.body}");
    }
  }

  Future<Map<String, dynamic>> buyData({
    required String network,
    required String phone,
    required String planId,
  }) async {
    final url = Uri.parse("$baseUrl/data");
    final headers = {
      "Authorization": "Bearer $apiKey",
      "Content-Type": "application/json",
    };
    final body = jsonEncode({
      "network": network,
      "mobile_number": phone,
      "plan_id": planId,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Data purchase error: ${response.body}");
    }
  }

  Future<Map<String, dynamic>> payElectricityBill({
    required String disco,   
    required String meterNumber, 
    required double amount,     
    required String meterType,   
  }) async {
    final url = Uri.parse("$baseUrl/electricity");
    final headers = {
      "Authorization": "Bearer $apiKey",
      "Content-Type": "application/json",
    };

    final body = jsonEncode({
      "disco": disco,
      "meter_number": meterNumber,
      "amount": amount,
      "meter_type": meterType,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Electricity bill payment failed: ${response.body}");
    }
  }
}
