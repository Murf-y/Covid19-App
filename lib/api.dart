import "package:http/http.dart" as http;

// make a request to a specific uri with specific headers and param
Future<http.StreamedResponse> requestAllTimeInfoByCountry(
    String country) async {
  var uri = "https://api.covid19api.com/total/country/$country";

  // create a new http client
  http.Client client = http.Client();
  // create a new http request
  http.Request request = http.Request("GET", Uri.parse(uri));
  // set the headers
  http.StreamedResponse response = await client.send(request);
  // return the response
  return response;
}

Future<http.StreamedResponse> requestWorldInfo() async {
  var uri = "https://api.covid19api.com/world/total";
  // create a new http client
  http.Client client = http.Client();
  // create a new http request
  http.Request request = http.Request("GET", Uri.parse(uri));
  // set the headers
  http.StreamedResponse response = await client.send(request);
  // return the response
  return response;
}
