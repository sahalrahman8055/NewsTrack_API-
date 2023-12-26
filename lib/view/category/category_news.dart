import 'package:flutter/material.dart';
import 'package:newstrack/controller/category_provider.dart';
import 'package:newstrack/helper/color.dart';
import 'package:newstrack/view/article/article_view.dart';
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
    final provider = Provider.of<CategoryController>(context, listen: false);
    provider.getCategoryNews(widget.category);
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
              style: TextStyle(color: kredColor),
            ),
          ],
        ),
      ),
      body: Consumer<CategoryController>(
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
                            itemCount: newsProvider.articlnews.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BlogTile(
                                imageUrl:
                                    newsProvider.articlnews[index].urlToImage,
                                title: newsProvider.articlnews[index].title,
                                desc:
                                    newsProvider.articlnews[index].description,
                                url: newsProvider.articlnews[index].url,
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
                child: Image.network(imageUrl ??
                    "https://www.smaroadsafety.com/wp-content/uploads/2022/06/no-pic.png")),
            Text(
              title ?? "Text Note Found",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              desc ?? "Text Note Found",
              style: TextStyle(color: kGreyColor, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
