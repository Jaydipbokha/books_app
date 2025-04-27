import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';

class BookService {
  static Future<List<Datum>> fetchBooks() async {
    final response = await http.get(Uri.parse('https://admin.pustakam.co.in/books/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final Book bookResponse = Book.fromJson(jsonData);
      print("Fetched ${bookResponse.data.length} books");
      return bookResponse.data;
    } else {
      throw Exception('Failed to load books');
    }
  }
}