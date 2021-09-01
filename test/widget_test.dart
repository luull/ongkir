import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
  final response = await http.post(url, headers: {
    "content-type": "application/x-www-form-urlencoded",
    "key": "17d64d0c28207f3e337a5011177545fd",
  }, body: {
    "origin": "501",
    "destination": "114",
    "weight": "1300",
    "courier": "jne"
  });
  print(response.body);
}
