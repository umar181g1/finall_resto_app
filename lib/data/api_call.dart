import 'dart:convert';

import 'package:finall_resto_app/data/model/Res_List_Respon.dart';
import 'package:finall_resto_app/data/model/res_detail_respon.dart';
import 'package:finall_resto_app/data/model/res_search_respon.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String list = 'list';
  static const String _detail = 'detail/';
  static const String _search = 'search?q=';

  Future<ResListRespon> getData() async {
    final response = await http.get(Uri.parse(_baseUrl + list));
    if (response.statusCode == 200) {
      return ResListRespon.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ResDetailRespon> restoDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + id));
    if (response.statusCode == 200) {
      return ResDetailRespon.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat detail restoran');
    }
  }

  Future<ResSearchRespon> restoSearch(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _search + query));
    if (response.statusCode == 200) {
      return ResSearchRespon.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat pencarian restoran');
    }
  }
}
