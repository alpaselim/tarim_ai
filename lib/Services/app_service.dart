import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:tarim_ai/Data/api_constant.dart';

class AppService {
  final Dio _dio = Dio();

  Future<String> encodeImage(File image) async {
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }

  Future<String> sendMessageGPT({required String diseaseName}) async {
    try {
      final response = await _dio.post(
        "$BASE_URL/chat/completions",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $API_KEY',
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: {
          "model": 'gpt-3.5-turbo',
          "messages": [
            {
              "role": "user",
              "content":
                  "GPT, upon receiving the name of a plant disease, provide three precautionary measures to prevent or manage the disease. These measures should be concise, clear, and limited to one sentence each. No additional information or context is needed—only the three precautions in bullet-point format. The disease is $diseaseName",
            }
          ],
        },
      );

      final jsonResponse = response.data;

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }

      return jsonResponse["choices"][0]["message"]["content"];
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<Map<String, dynamic>> sendRequestForWeed(String weedName) async {
    const String apiURL = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(apiURL),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $API_KEY',
      },
      body: jsonEncode({
        'model': 'ft:gpt-3.5-turbo-0125:personal:weed-detect:94FFQf3c',
        'messages': [
          {
            "role": "system",
            "content":
                "Sana verilen yabancı ot isimleri için mücadele tavsiyeleri veren bir uzmansın."
          },
          {"role": "user", "content": weedName},
        ],
      }),
    );

    if (response.statusCode == 200) {
      String decodedResponse = utf8.decode(response.bodyBytes);
      return json.decode(decodedResponse);
    } else {
      throw Exception(
          'API isteği başarısız oldu: HTTP Status ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> sendRequestForInsect(String insectName) async {
    const String apiURL = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(apiURL),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $API_KEY',
      },
      body: jsonEncode({
        'model': 'ft:gpt-3.5-turbo-0125:personal:insect-detection:9CmOwzMh',
        'messages': [
          {
            "role": "system",
            "content":
                "Sana verilen haşere isimleri için mücadele tavsiyeleri veren bir uzmansın."
          },
          {"role": "user", "content": insectName},
        ],
      }),
    );

    if (response.statusCode == 200) {
      String decodedResponse = utf8.decode(response.bodyBytes);
      return json.decode(decodedResponse);
    } else {
      throw Exception(
          'API isteği başarısız oldu: HTTP Status ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> sendRequestForIrrigation(
      String fieldInfo) async {
    const String apiURL = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(apiURL),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $API_KEY',
      },
      body: jsonEncode({
        'model': 'ft:gpt-3.5-turbo-0125:personal:irrigation-helper:9CeYdpvh',
        'messages': [
          {
            "role": "system",
            "content":
                "Bitki ve tarla koşulları hakkında sulama tavsiyeleri sağlamak."
          },
          {"role": "user", "content": fieldInfo},
        ],
      }),
    );

    if (response.statusCode == 200) {
      String decodedResponse = utf8.decode(response.bodyBytes);
      return json.decode(decodedResponse);
    } else {
      throw Exception(
          'API isteği başarısız oldu: HTTP Status ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> sendRequestForSoilAnalysis(
      String soilInfo) async {
    const String apiURL = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(apiURL),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $API_KEY',
      },
      body: jsonEncode({
        'model': 'ft:gpt-3.5-turbo-0125:personal:soil-analysis:9ClA0U9v',
        'messages': [
          {
            "role": "system",
            "content":
                "Tarla verilerine göre ekilecek uygun bitki türünü öneren bir uzmansın."
          },
          {"role": "user", "content": soilInfo},
        ],
      }),
    );

    if (response.statusCode == 200) {
      String decodedResponse = utf8.decode(response.bodyBytes);
      return json.decode(decodedResponse);
    } else {
      throw Exception(
          'API isteği başarısız oldu: HTTP Status ${response.statusCode}');
    }
  }

  Future<String> sendImageToGPT4VisionForWeed({
    required File image,
    int maxTokens = 50,
    String model = "gpt-4-vision-preview",
  }) async {
    final String base64Image = await encodeImage(image);

    try {
      final response = await _dio.post(
        "$BASE_URL/chat/completions",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $API_KEY',
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode({
          'model': model,
          'messages': [
            {
              'role': 'system',
              'content': 'You have to give concise and short answers'
            },
            {
              'role': 'user',
              'content': [
                {
                  'type': 'text',
                  'text':
                      'GPT, your task is to identify weeds. Analyze any image of a plant or leaf I provide to identify which weed it is. Respond only with the scientific name of the weed identified and the corresponding Turkish name of the weed in parentheses, do nothing else; no explanation, no additional text. If the image is not plant-related, say \'Please pick another image\'',
                },
                {
                  'type': 'image_url',
                  'image_url': {
                    'url': 'data:image/jpeg;base64,$base64Image',
                  },
                },
              ],
            },
          ],
          'max_tokens': maxTokens,
        }),
      );

      final jsonResponse = response.data;

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }
      return jsonResponse["choices"][0]["message"]["content"];
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> sendImageToGPT4VisionForInsect({
    required File image,
    int maxTokens = 50,
    String model = "gpt-4-vision-preview",
  }) async {
    final String base64Image = await encodeImage(image);

    try {
      final response = await _dio.post(
        "$BASE_URL/chat/completions",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $API_KEY',
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: jsonEncode({
          'model': model,
          'messages': [
            {
              'role': 'system',
              'content': 'You have to give concise and short answers'
            },
            {
              'role': 'user',
              'content': [
                {
                  'type': 'text',
                  'text':
                      'GPT, your task is to identify pests. Analyze any image of a insect I provide to identify which insect it is. Respond only with the scientific name of the insect identified and the corresponding Turkish name of the insect in parentheses, do nothing else; no explanation, no additional text. If the image is not insect-related, say \'Please pick another image\'',
                },
                {
                  'type': 'image_url',
                  'image_url': {
                    'url': 'data:image/jpeg;base64,$base64Image',
                  },
                },
              ],
            },
          ],
          'max_tokens': maxTokens,
        }),
      );

      final jsonResponse = response.data;

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }
      return jsonResponse["choices"][0]["message"]["content"];
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
