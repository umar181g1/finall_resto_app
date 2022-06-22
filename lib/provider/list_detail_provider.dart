import 'package:flutter/material.dart';
import '../data/api_call.dart';
import '../data/model/Res_List_Respon.dart';
import '../until/result_state.dart';

class RestoListProvider extends ChangeNotifier {
  late final ApiService apiService;


  RestoListProvider({required this.apiService}) {
    _fetRestoList();
  }

  late ResultState _state;
  late ResListRespon _list;
  String _massage = '';

  ResultState get state => _state;

  ResListRespon get result => _list;

  String get message => _massage;

  Future<dynamic> _fetRestoList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final resto = await apiService.getData();
      if (resto.restaurants.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        return _list = resto;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        return _massage = "Data Tidak Ada";
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _massage = 'Gagal Memuat Data';
    }
  }
}