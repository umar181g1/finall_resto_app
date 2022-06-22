import 'package:finall_resto_app/data/model/res_search_respon.dart';
import 'package:flutter/material.dart';

import '../data/api_call.dart';
import '../until/result_state.dart';

class SearchResProvider extends ChangeNotifier{
  final ApiService apiService;

  SearchResProvider({required this.apiService}){
    fetcViewRes(query);
  }
  ResultState? _state;
  ResSearchRespon? _search;
  String _query = '';
  String _message = '';

  ResultState? get state => _state;
  ResSearchRespon? get result => _search;
  String get query => _query;
  String get message => _message;

  Future<dynamic> fetcViewRes(String query) async{
    try{
      if(query.isNotEmpty){
        _state = ResultState.loading;
        _query = query;
        notifyListeners();
        final resResult = await apiService.restoSearch(query);
        if(resResult.restaurants.isNotEmpty){
          _state = ResultState.hasData;
          notifyListeners();
          return _search = resResult;
        }else{
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Resto Tidak Ditemukan';
        }
      }
    }catch(e){
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Gagal Memuat Data';
    }
  }
}