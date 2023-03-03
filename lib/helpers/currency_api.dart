import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();

  Future<Map?> CurrencyApi({
    required String From,
    required String To,
    required int amount,
  }) async {
    String api =
        "https://currency-converter-by-api-ninjas.p.rapidapi.com/v1/convertcurrency?have=${From}&want=${To}&amount=${amount}";
    Uri myUrl = Uri.parse(api);
    http.Response res = await http.get(myUrl, headers: {
      "X-RapidAPI-Key": "791ef41f82mshe13d5276cb7121cp1b8e6cjsnb12fdff84b39",
      "X-RapidAPI-Host": "currency-converter-by-api-ninjas.p.rapidapi.com"
    });

    if (res.statusCode == 200) {
      Map data = jsonDecode(res.body);
      // Post P = Post.fromMap(data: data);
      return data;
    }
    return null;
  }
}
