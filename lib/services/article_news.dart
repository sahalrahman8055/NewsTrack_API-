
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newstrack/model/article_model.dart';

class ArticleNewsServices {
  List<ArticleModel> news = [];

  Future<void> fetchArticleNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=de7769d82fcf4555b9d6c72889a1ed1b';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['context'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
