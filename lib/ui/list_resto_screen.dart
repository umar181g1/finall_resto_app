

import 'package:finall_resto_app/ui/search_resto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/api_call.dart';
import '../provider/list_detail_provider.dart';
import '../until/result_state.dart';
import '../wiget/card_resto.dart';

class ListRestoScreen extends StatelessWidget {
  static const routeName = '/resto-list';

  const ListRestoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Restoran'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPageScreen.routeName);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: _RestoListb(context),
    );
  }


}

Widget _RestoListb(BuildContext context) {
  return ChangeNotifierProvider(
    create: (_) => RestoListProvider(apiService: ApiService()),
    child: Consumer<RestoListProvider>(
      builder: (context, state, _) {
        switch (state.state) {
          case ResultState.loading:
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                backgroundColor: Colors.green,
              ),
            );
          case ResultState.hasData:
            return ListView.builder(
              itemBuilder: (context, index) {
                var resto = state.result.restaurants[index];
                return ListResto(restaurant: resto,);
              },
              itemCount: state.result.restaurants.length,
            );
          case ResultState.noData:
            return Center(
              child: Text(state.message),
            );
          case ResultState.error:
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.signal_cellular_connected_no_internet_0_bar,
                    color: Colors.green, size: 80,),
                  SizedBox(height: 25),
                  Text(
                    "Harap Cek Koneksi Anda",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            );
          default:
            return const Center(
              child: Text(
                'Gagal Load Data',
                style: TextStyle(fontSize: 25),
              ),
            );
        }
      },
    ),
  );
}