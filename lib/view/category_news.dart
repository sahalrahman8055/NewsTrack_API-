import 'package:flutter/material.dart';
import 'package:newstrack/controller/news_provider.dart';
import 'package:newstrack/view/article_view.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // List<ArticleModel> article = <ArticleModel>[];

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    newsProvider.getAllCategoryNews(widget.category);

    newsProvider.changeLoading;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("News"),
            Text(
              "Track",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          return newsProvider.loading
              ? Center(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 16),
                          child: ListView.builder(
                            itemCount: newsProvider.articles.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BlogTile(
                          imageUrl: newsProvider.articles[index].urlToImage,
                                  title: newsProvider.articles[index].title,
                                  desc: newsProvider.articles[index].description,
                                  url: newsProvider.articles[index].url,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final imageUrl, title, desc, url;

  const BlogTile(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleView(blogUrl: url),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl ?? "https://www.smaroadsafety.com/wp-content/uploads/2022/06/no-pic.png")),
            Text(
              title ?? "Text Note Found",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              desc ?? "Text Note Found",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
