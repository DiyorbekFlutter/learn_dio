import 'dart:convert';
import 'dart:io';

Future<String?> getData() async {
  Uri url = Uri.https("jsonplaceholder.typicode.com", "/posts");

  HttpClientRequest request = await HttpClient().getUrl(url);
  HttpClientResponse response = await request.close();

  if(response.statusCode == HttpStatus.ok) return await response.transform(utf8.decoder).join();
  return null;
}
