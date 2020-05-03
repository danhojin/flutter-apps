import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider1/providers.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<Favorites>(context, listen: true);

    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text(favorites[index].asPascalCase),
          trailing: favorites.isSaved(favorites[index])
              ? Icon(Icons.favorite, color: Colors.red)
              : Icon(Icons.favorite_border),
          onTap: () => favorites.toggle(favorites[index]),
        ),
        itemCount: favorites.length,
      ),
    );
  }
}
