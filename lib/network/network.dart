import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex_f/model/pokemon_list_item.dart';
import 'package:pokedex_f/model/pokemon_info.dart';

class NetworkUtil {
  final baseUrl = 'https://a38f-121-164-144-250.ngrok.io/';

  Future<List<PokemonListItem>> fetchPokemonList() async {
    var url = '${baseUrl}pokemons/1';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> resultList = jsonDecode(utf8.decode(response.bodyBytes));
      List<PokemonListItem> list = List.empty(growable: true);

      for(var result in resultList) {
        list.add(PokemonListItem.fromJson(result));
      }
      return list;
    } else {
      return throw ('리스트 조회 실패');
    }
  }

  Future<Pokemon> fetchPokemonDetailInfo(String number) async {
    var url = '${baseUrl}pokemon/number/$number';
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      return throw ('조회 실패');
    }
  }
}
