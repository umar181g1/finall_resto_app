import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/api_call.dart';
import '../provider/search_res_provider.dart';
import '../until/result_state.dart';
import '../wiget/search_page.dart';

class SearchPageScreen extends StatefulWidget {
  static const routeName = '/resto-search';

  const SearchPageScreen({Key? key}) : super(key: key);

  @override
  State<SearchPageScreen> createState() => _SearchPageScreenState();
}

class _SearchPageScreenState extends State<SearchPageScreen> {
  String queries = '';

  Widget _buildSearchResto(BuildContext context) {
    return Consumer<SearchResProvider>(
      builder: (context, state, _) {
        switch (state.state) {
          case ResultState.loading:
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.brown,
                backgroundColor: Colors.greenAccent,
              ),
            );
          case ResultState.hasData:
            return ListView.builder(
              itemBuilder: (context, index) {
                var restaurant = state.result!.restaurants[index];
                return SearchPage(restaurant: restaurant,);
              },
              itemCount: state.result?.restaurants.length,
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
                  Icon(
                    Icons.signal_cellular_connected_no_internet_0_bar,
                    color: Colors.red,
                    size: 90,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Cek Koneksi',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            );
          default:
            return const Center(
              child: Icon(
                Icons.content_paste_search,
                color: Color.fromARGB(212, 302, 22, 50),
                size: 100,
              ),
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchResProvider(
        apiService: ApiService(),
      ),
      child: Consumer<SearchResProvider>(builder: (context, state, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Pencarian'),
          ),
          body: Stack(
            children: [
              SafeArea(
                child: Container(
                    padding: const EdgeInsets.all(25),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "Cari restoran atau menu"),
                      onChanged: (String result) {
                        setState(
                              () {
                            queries = result;
                          },
                        );
                        state.fetcViewRes(result);
                      },
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: _buildSearchResto(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}