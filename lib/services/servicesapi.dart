import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:vtutemplate/model/datamodel.dart';

class VtuService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  final String apiKey = dotenv.env['API_KEY'] ?? '';      
  final String secretKey = dotenv.env['SECRET_KEY'] ?? '';
  final String publicKey = dotenv.env['PUBLIC_KEY'] ?? '';

Future<Map<String, dynamic>> buyAirtime({
    required String network,
    required String phone,
    required double amount,
  }) async {
    final url = Uri.parse("$baseUrl/pay");

    final headers = {
      "api-key": apiKey,
      "secret-key": secretKey,
      "Content-Type": "application/json",
    };

    final body = jsonEncode({
      "request_id": DateTime.now().millisecondsSinceEpoch.toString(),
      "serviceID": network, 
      "amount": amount,
      "phone": phone,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["code"] == "000") {
        return data;
      } else {
        throw Exception(data["response_description"] ?? "Transaction failed");
      }
    } else {
      throw Exception("Server error: ${response.statusCode}");
    }
  }
Map<String, String> get headers => {
        "Content-Type": "application/json",
        "api-key": apiKey,
        "public-key": publicKey,
      };

Future<List<DataVariation>> getDataBundles(String serviceID) async {
  final response = await http.get(
    Uri.parse("$baseUrl/service-variations?serviceID=$serviceID"),
    headers: headers,
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    if (data["code"] == "000" && data["content"]?["variations"] != null) {
      final List variations = data["content"]["variations"];
      return variations.map((e) => DataVariation.fromJson(e)).toList();
    } else {
      throw Exception("Invalid response format or no variations found");
    }
  } else {
    throw Exception("Failed to fetch bundles: ${response.body}");
  }
}

  /// Purchase data
  Future<Map<String, dynamic>> buyData({
    required String serviceID,
    required String variationCode,
    required String phone,
    required String requestId,
  }) async {
    final body = jsonEncode({
      "request_id": requestId,
      "serviceID": serviceID,
      "billersCode": phone,
      "variation_code": variationCode,
      "amount": "0", // VTU handles amount from variation
      "phone": phone,
    });

    final response = await http.post(
      Uri.parse("$baseUrl/pay"),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Data purchase failed");
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
      "Authorization": "Bearer ${apiKey}",
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

  Future<Map<String, dynamic>> verifyTvDecoder({
    required String serviceID, // e.g. "dstv", "gotv", "startimes"
    required String smartCardNumber,
  }) async {
    final url = Uri.parse("$baseUrl/tv/verify");
    final headers = {
      "Authorization": "Bearer $apiKey",
      "Content-Type": "application/json",
    };
    final body = jsonEncode({
      "serviceID": serviceID,
      "smartcard_number": smartCardNumber,
    });

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Decoder verification failed: ${response.body}");
    }
  }

  Future<Map<String, dynamic>> getTvVariations(String serviceID) async {
    final url = Uri.parse("$baseUrl/tv/variations?serviceID=$serviceID");
    final headers = {
      "Authorization": "Bearer ${apiKey}",
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load TV variations: ${response.body}");
    }
  }

  Future<Map<String, dynamic>> payTvSubscription({
    required String serviceID,
    required String smartCardNumber,
    required String variationCode,
    required double amount,
    required String phoneNumber,
  }) async {
    final url = Uri.parse("$baseUrl/tv/pay");
    final headers = {
      "Authorization": "Bearer $apiKey",
      "Content-Type": "application/json",
    };

    final body = jsonEncode({
      "serviceID": serviceID,
      "smartcard_number": smartCardNumber,
      "variation_code": variationCode,
      "amount": amount,
      "phone": phoneNumber,
    });

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("TV subscription payment failed: ${response.body}");
    }
  }
}
