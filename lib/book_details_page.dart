import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class BookDetailsPage extends StatefulWidget {
  final int bookNo;
  final String image;
  final String name;
  final String discription;
  final String price;
  const BookDetailsPage({
    Key? key,
    required this.image,
    required this.name,
    required this.discription,
    required this.price,
    required this.bookNo,
  }) : super(key: key);

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'Book details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 250,
              width: double.maxFinite,
              child: Image.asset(
                widget.image,
                fit: BoxFit.fitWidth,
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.name,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.discription,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: () {}, child: Text('Buy ${widget.price}')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: () async {
              final dynamicLinkParams = DynamicLinkParameters(
                link:
                    Uri.parse("https://your.website.page/book${widget.bookNo}"),
                uriPrefix: "https://coffeecrew.page.link",
                androidParameters: AndroidParameters(
                    packageName: "com.arApps.pim",
                    fallbackUrl: Uri.parse('https://myandroidapp.link')),
                iosParameters: IOSParameters(
                    bundleId: "com.example.app.ios",
                    fallbackUrl: Uri.parse('https://myiosapp.link')),
              );

              //for long url
              // final link = await FirebaseDynamicLinks.instance
              //     .buildLink(dynamicLinkParams);
              //for short url
              final dynamicLink = await FirebaseDynamicLinks.instance
                  .buildShortLink(dynamicLinkParams);

              await Share.share(dynamicLink.shortUrl.toString());
            },
            child: Text('Share With Friends'),
          ),
        ],
      ),
    );
  }
}
