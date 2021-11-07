import 'package:flutter/material.dart';
import 'package:flutter_test3/quotes/quote.dart';

class QuoteCard extends StatelessWidget {

  final Quote quote;
  final VoidCallback onDelete;

  const QuoteCard({
    Key? key,
    required this.quote,
    required this.onDelete
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quote.text,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    quote.author,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              alignment: Alignment.topRight,
              color: const Color(0xFF424242),
              constraints: const BoxConstraints(maxHeight: 16.0),
              icon: const Icon(Icons.close),
              iconSize: 16.0,
              onPressed: onDelete,
              padding: const EdgeInsets.all(0)
            ),
          ],
        ),
      ),
    );
  }
}