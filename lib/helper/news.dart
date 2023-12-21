import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newstrack/model/article_model.dart';

class News {
  List<ArticleModel> news = [];

  Future<List<ArticleModel>> getNews() async {
    try {
      String url =
          "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=de7769d82fcf4555b9d6c72889a1ed1b";

      var response = await http.get(Uri.parse(url));

      var jsonData = jsonDecode(response.body);
      final articleList = (jsonData["articles"] as List).map((e) {
        return ArticleModel.fromJson(e as Map<String, dynamic>);
      }).toList();
      news = articleList;
      return news;
    } catch (e) {
      return [];
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];
  Future<List<ArticleModel>> getCategoryNews(String category) async {
    try {
      String url =
          'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=9a922478bde34c1298d3aba0b7a4f66d';

      var response = await http.get(Uri.parse(url));

      var jsonData = jsonDecode(response.body);
      final articleList = (jsonData["articles"] as List).map((e) {
        return ArticleModel.fromJson(e as Map<String, dynamic>);
      }).toList();
      news = articleList;
      return news;
    } catch (e) {
      return [];
    }
  }
}

