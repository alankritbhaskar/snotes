import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snotes/components/product_details.dart';

class Books extends StatefulWidget {
  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<Books> {
  var bookList = [
    {
      "name": "Signposts to God",
      "picture": "images/books/phy1.png",
      "price": "400 Rs.",
      "genre": "Physics",
      "author": "xyz",
    },
    {
      "name": "Harry Potter",
      "picture": "images/books/harr.png",
      "price": "700 Rs.",
      "genre": "Fiction",
      "author": "JK Rowling",
    },
    {
      "name": "chem1",
      "picture": "images/books/chem1.png",
      "price": "500 Rs.",
      "genre": "Chemistry",
      "author": "xyz",
    },
    {
      "name": "chem2",
      "picture": "images/books/chem.png",
      "price": "500 Rs.",
      "genre": "Chem",
      "author": "xyzq",
    },
    {
      "name": "phy",
      "picture": "images/books/phy2.png",
      "price": "300 Rs.",
      "genre": "Physics",
      "author": "xcyz",
    },
    {
      "name": "Electricity-1",
      "picture": "images/books/elec1.png",
      "price": "400 Rs.",
      "genre": "Physics",
      "author": "xyz",
    },
    {
      "name": "Electricity-2",
      "picture": "images/books/elect2.png",
      "price": "900 Rs.",
      "genre": "Electrical Engg.",
      "author": "UKS",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: bookList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Single_book(
              book_name: bookList[index]['name'],
              book_picture: bookList[index]['picture'],
              book_price: bookList[index]['price'],
              book_genre: bookList[index]['genre'],
              book_author: bookList[index]['author'],
            ),
          );
        });
  }
}

class Single_book extends StatelessWidget {
  final book_name;
  final book_picture;
  final book_price;
  final book_genre;
  final book_author;

  Single_book({
    this.book_name,
    this.book_picture,
    this.book_price,
    this.book_genre,
    this.book_author,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: book_name,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => BookDetails())),
              child: GridTile(
                footer: Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: Text(
                      book_name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      book_price,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.redAccent, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      book_author,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                child: Image.asset(
                  book_picture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )),
    );
  }
}
