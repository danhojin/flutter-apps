import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider1/pages/cart.dart';
import 'package:provider1/providers.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final words = Provider.of<Words>(context, listen: true);
    final favorites = Provider.of<Favorites>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider sample'),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cart()),
                  );
                },
              ),
              favorites.length > 0
                  ? Positioned(
                      right: 10,
                      top: 10,
                      child: Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: Center(
                          child: Text(
                            favorites.length.toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final word = words[index];

          return Dismissible(
            key: Key(word.asPascalCase),
            onDismissed: (direction) {
              words.removeAt(index);
              if (favorites.isSaved(word)) {
                favorites.toggle(word);
              }
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('${word.asPascalCase} dismissed')));
            },
            child: ListTile(
              title: Text(word.asPascalCase),
              trailing: favorites.isSaved(word)
                  ? Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite_border),
              onTap: () => favorites.toggle(word),
            ),
          );
        },
      ),
    );
  }
}
