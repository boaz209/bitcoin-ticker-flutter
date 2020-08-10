import 'package:http/http.dart' as http;
import 'dart:convert';

//https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=7648975C-86B0-4A09-BCB8-8039F424D470

class NetworkHelper {
  Future getStatus(var url) async {
//    var url = 'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=$kAPIkey';

    var response = await http.get(url);

    if (response.statusCode == 200) {
//      print('Response status: ${response.statusCode}');
//      print('Response body: ${response.body}');

      var data = response.body;
      var jasonData = jsonDecode(data);

//      print('rate ${jasonData['rate']}');

      return jasonData;
    } else {
      print(response.statusCode);
      print('No netWork');
    }
  }
}
