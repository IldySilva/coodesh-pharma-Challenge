import 'package:http/http.dart' as http;

abstract class IRepository  {
  @override
  Future<http.Response> fetchData(endpoint);


}

class HttpNetwork implements IRepository{


Future<http.Response> fetchData(endpoint) async {
  var response=await http.get(Uri.parse(endpoint));
  return response;
}

}