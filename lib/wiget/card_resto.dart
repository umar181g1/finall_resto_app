import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/model/Res_List_Respon.dart';
import '../provider/db_provider.dart';
import '../ui/detail_page_scren.dart';

class ListResto extends StatelessWidget {
  final Restaurant restaurant;

  const ListResto({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isFavorit(restaurant.id),
        builder: (context, snapshot) {
          var isFav = snapshot.data ?? false;
          return Material(
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, DetailPageList.routeName,
                        arguments: restaurant.id);
                  },
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(children: [
                      Hero(
                        tag: restaurant.pictureId,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                            height: 150,
                            width: 125,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          width: 200,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              color: Colors.white70),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurant.name,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        restaurant.city,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(restaurant.rating.toString())
                                    ],
                                  ),
                                  const Expanded(
                                    child: SizedBox(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: IconButton(
                                      icon: isFav
                                          ? IconButton(
                                              onPressed: () =>
                                                  provider.removeFavorite(
                                                      restaurant.id),
                                              icon: const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              ),
                                            )
                                          : IconButton(
                                              onPressed: () => provider
                                                  .addFavorite(restaurant),
                                              icon: const Icon(
                                                Icons.favorite_border,
                                                color: Colors.black,
                                              ),
                                            ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ]),
                  ))));
        },
      );
    });
  }
}
