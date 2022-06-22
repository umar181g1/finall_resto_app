import 'package:flutter/material.dart';

import '../data/model/res_search_respon.dart';
import '../ui/detail_page_scren.dart';

class SearchPage extends StatelessWidget {
  final Restaurant restaurant;

  const SearchPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPageList.routeName,
            arguments: restaurant.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Hero(
            tag: restaurant.pictureId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/small/" +
                    restaurant.pictureId,
                width: 90,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            restaurant.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Column(
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color.fromARGB(255, 203, 44, 49),
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  Text(restaurant.city),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Color.fromARGB(255, 230, 149, 152),
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  Text('${restaurant.rating}')
                ],
              ),
              const SizedBox(height: 12),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}