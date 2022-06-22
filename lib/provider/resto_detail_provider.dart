import 'package:finall_resto_app/data/model/res_detail_respon.dart';
import 'package:flutter/material.dart';
import '../data/api_call.dart';
import '../until/result_state.dart';

class ResDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  ResDetailProvider({required this.apiService, required this.id}) {
    _fetchReDetail(id);
  }

  late ResultState _state;
  late ResDetailRespon _detail;
  String _message = '';

  ResultState get state => _state;

  ResDetailRespon get result => _detail;

  String get message => _message;

  Future<dynamic> _fetchReDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restoDetail = await apiService.restoDetail(id);
      if (restoDetail.restaurant.id.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        return _detail = restoDetail;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data tidak ditemukan';
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Gagal memuat data';
    }
  }
}
