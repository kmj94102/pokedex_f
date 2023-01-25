import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_f/model/pokemon_list_item.dart';
import 'package:pokedex_f/network/network.dart';
import 'package:pokedex_f/utils/constants.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<PokemonListItem> list = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    fetchPokemonList();
  }

  void fetchPokemonList() async {
    list = await NetworkUtil().fetchPokemonList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text('리스트 화면'),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 23),
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: [for (var item in list) pokemonItem(item)],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

Widget pokemonItem(PokemonListItem item) {
  return Card(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        side: BorderSide(color: Color(0xFF299AE6))),
    color: const Color(0xFFE3F4FF),
    child: SizedBox(
      width: 80,
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            item.dotImage,
            width: 56,
            height: 56,
          ),
          Text(
            '# ${item.number}',
            style: const TextStyle(
                fontFamily: fontMaruBuri,
                fontSize: 12,
                fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    ),
  );
}
