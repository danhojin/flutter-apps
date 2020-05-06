import 'package:badges/badges.dart';
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
      appBar: AppBar(title: Text('Provider sample'), actions: <Widget>[
        _shoppingCartBadge(context, favorites.length),
      ]),
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
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('${word.asPascalCase} dismissed')));
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

  Widget _shoppingCartBadge(BuildContext context, int nItems) {
    return nItems > 0
        ? Badge(
            position: BadgePosition.topRight(top: 5, right: 5),
            // animationDuration: 0.3.seconds,
            animationDuration: Duration(milliseconds: 300),
            animationType: BadgeAnimationType.scale,
            badgeContent: Text(
              nItems.toString(),
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cart()),
                );
              },
            ),
          )
        : IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          );
  }
}
