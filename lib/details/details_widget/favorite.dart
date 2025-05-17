import 'package:flutter/material.dart';
import 'package:mobileproj/add_item/item_model.dart';
import 'package:mobileproj/favorite/favorite_model.dart';
import 'package:provider/provider.dart';

class FavoriteWidget extends StatelessWidget {
  final int index;

  const FavoriteWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemModel>(
      builder: (context, item, child) {
        final fav = Provider.of<FavoriteModel>(context, listen: true);
        final currentItem = item.items[index];

        return IconButton(
          onPressed: () {
            fav.isFavorite(currentItem);
          },
          icon: Icon(
            Icons.favorite,
            color: item.items[index].favorite ? Colors.red : Colors.grey,
          ),
        );
      },
    );
  }
}
