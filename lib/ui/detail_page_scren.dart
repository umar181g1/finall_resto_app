import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/api_call.dart';
import '../provider/resto_detail_provider.dart';
import '../until/result_state.dart';
import '../wiget/detail_page.dart';

class DetailPageList extends StatelessWidget {
  static const routeName = '/resto-detail';
  final String id;

  const DetailPageList({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResDetailProvider(apiService: ApiService(), id: id),
      child: Consumer<ResDetailProvider>(
        builder: (context, state, _) {
          switch (state.state) {
            case ResultState.loading:
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                  backgroundColor: Colors.grey,
                ),
              );
            case ResultState.hasData:
              return PageDetail(resDetailRespon: state.result);
            case ResultState.error:
              return Center(
                child: Text(state.message),
              );
            default:
              return const Center(
                child: Text(
                  'Gagal memuat',
                  style: TextStyle(fontSize: 24),
                ),
              );
          }
        },
      ),
    );
  }
}