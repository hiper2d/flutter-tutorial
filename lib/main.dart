import 'package:flutter/material.dart';
import 'package:flutter_test3/quote.dart';
import 'package:flutter_test3/quote_card.dart';

void main() => runApp(const MaterialApp(
  home: QuoteList(),
));

class QuoteList extends StatefulWidget {
  const QuoteList({Key? key}) : super(key: key);

  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {

  var quotes = [
    Quote(author: 'Oscar Wilde', text: 'Be yourself; everyone is already taken'),
    Quote(author: 'Oscar Wilde', text: 'I have nothing to declare except my genius'),
    Quote(author: 'Oscar Wilde', text: 'The truth is rarely pure and never simple')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text('Awesome Quotes'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: quotes.map((q) => QuoteCard(
          quote: q,
          onDelete: () {
            setState(() {
              quotes.remove(q);
            });
          }
        )).toList(),
      )
    );
  }
}
