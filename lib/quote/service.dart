//r7 nt3ml m3 api f had 4e2 mn mostkbl lsa (files , db , things coming from network (api)) use future fn

import 'dart:convert';

import 'package:mobileproj/quote/quote.dart';
import 'package:http/http.dart' as http;

Future <List <Quote>> fetchQuote() async {
  //34an a3ml get data ht3ml m3 http package flutter
  final response = await http.get(
    Uri.parse("https://api.api-ninjas.com/v1/quotes"),
     headers: {
    'X-Api-Key': '2RjHnNLO4NWqjY9fPDrT3w==QJ1GeYjkX1a2ATbs'
  },
  );
  if (response.statusCode == 200) {
    //el data 3bara 3n list gowaha
    List<dynamic> data = jsonDecode(response.body);

    return data.map((json) => Quote.fromJson(json)).toList();
  }

  throw Exception('Failed to load quotes');
}
