import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stripe/book_details_page.dart';

class HomePage extends StatefulWidget {
  final String? path;
  const HomePage({Key? key, required this.path}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> bookImgs = [
    "assets/img_01.webp",
    "assets/img_02.webp",
    "assets/img_03.jpeg",
    "assets/img_04.webp",
    "assets/img_05.webp",
    "assets/img_06.webp",
  ];
  List<String> bookPrice = [
    "\$20.00",
    "\$23.00",
    "\$14.00",
    "\$50.00",
    "\$24.00",
    "\$40.00",
  ];
  List<String> bookNames = [
    "Fahrenheit 451 by Ray Bradbury",
    "1984 by George Orwell",
    "The Lord of the Rings by J.R.R. Tolkien",
    "The Kite Runner by Khaled Hosseini",
    "Frankenstein by Mary Shelley",
    "Harry Potter and the Philosopher’s Stone by J.K. Rowling"
  ];
  List<String> bookDescription = [
    "Ray Bradbury’s dystopian world shines a light on Western societies’ dependence on the media. The main character’s job is to find and burn any books he can find – until he begins to question everything. Considering the state of current politics and world affairs, this is one of the absolute must-read books in life.",
    "1984 tells the futuristic story of a dystopian, totalitarian world where free will and love are forbidden. Although the year 1984 has long since passed, the prophecy of a society controlled by fear and lies is arguably more relevant now than ever.",
    "Tolkien’s fantasy epic is one of the top must-read books out there. Set in Middle Earth – a world full of hobbits, elves, orcs, goblins, and wizards – The Lord of the Rings will take you on an unbelievable adventure.",
    "The Kite Runner is a moving story of an unlikely friendship between a wealthy boy and the son of his father’s servant. Set in Afghanistan during a time of tragedy and destruction, this unforgettable novel will have you hooked from start to finish.",
    "English author Mary Shelley tells the story of Victor Frankenstein, a young scientist who creates a monster and brings it to life. This gripping novel evokes questions about what makes us human and what love and kindness truly mean.",
    "This global bestseller took the world by storm. So, if you haven’t read J.K. Rowling’s Harry Potter, now may be the time. Join Harry Potter and his schoolmates as this must-read book transports you deep into a world of magic and monsters.",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => openTheBook());
  }

  openTheBook() {
    if (widget.path != null) {
      int bookNo = -1;
      if (widget.path == '/book0') {
        bookNo = 0;
      } else if (widget.path == '/book1') {
        bookNo = 1;
      } else if (widget.path == '/book2') {
        bookNo = 2;
      } else if (widget.path == '/book3') {
        bookNo = 3;
      } else if (widget.path == '/book4') {
        bookNo = 4;
      } else if (widget.path == '/book5') {
        bookNo = 5;
      }
      print(bookNo);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookDetailsPage(
                    bookNo: bookNo,
                    discription: bookDescription.elementAt(bookNo),
                    image: bookImgs.elementAt(bookNo),
                    price: bookPrice.elementAt(bookNo),
                    name: bookNames.elementAt(bookNo),
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          widget.path.toString() + 'testing2',
          // 'Book Store',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await Share.share(
                    'Hey, checkout this awesome app https://arapps.page.link/download');
              },
              child: Row(
                children: [
                  Icon(Icons.share),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Share with Friends'),
                ],
              ))
        ],
      ),
      body: GridView.builder(
          itemCount: bookImgs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookDetailsPage(
                              bookNo: index,
                              discription: bookDescription.elementAt(index),
                              image: bookImgs.elementAt(index),
                              price: bookPrice.elementAt(index),
                              name: bookNames.elementAt(index),
                            )));
              },
              child: Card(
                child: Image.asset(
                  bookImgs.elementAt(index),
                  fit: BoxFit.fill,
                ),
              ),
            );
          }),
    );
  }
}
