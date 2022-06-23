
import 'package:finall_resto_app/data/model/res_list_respon.dart';
import 'package:flutter_test/flutter_test.dart';

var testRestauran = {
  "id": "s1knt6za9kkfw1e867",
  "name": "Kafe Kita",
  "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
  "pictureId": "25",
  "city": "Gorontalo",
  "rating": 4
};

void main(){
  test("Test JSON Parsing",() async{
    var result = Restaurant.fromJson(testRestauran).id;

    expect(result, "s1knt6za9kkfw1e867");
  });
}