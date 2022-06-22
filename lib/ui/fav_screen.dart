import 'package:finall_resto_app/provider/db_provider.dart';
import 'package:finall_resto_app/until/result_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../wiget/card_resto.dart';

class ResFavoritePage extends StatelessWidget {
  const ResFavoritePage({Key? key}) : super(key: key);
  static const routeName = '/favorite_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          'Favorite Page',
          style: (TextStyle(fontFamily: 'RockWell')),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.favorite.length,
            itemBuilder: (context, index) {
              return ListResto(
                restaurant: provider.favorite[index],
              );
            },
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }
}