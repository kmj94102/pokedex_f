import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_f/model/pokemon_list_item.dart';
import 'package:pokedex_f/network/network.dart';
import 'package:pokedex_f/ui/detail/detail.dart';
import 'package:pokedex_f/ui/list/list_drawer.dart';
import 'package:pokedex_f/utils/constants.dart';
import 'package:flutter_svg/svg.dart';

import '../../model/type_info.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  String searchText = "";
  List<PokemonListItem> originalList = List.empty(growable: true);
  List<PokemonListItem> list = List.empty(growable: true);
  List<TypeCondition> typeList = TypeInfo.values
      .where((element) => element.name != 'unknown')
      .map((e) => TypeCondition(image: e.image, name: e.name))
      .toList();
  List<int> generationList = [1];

  @override
  void initState() {
    super.initState();
    fetchPokemonList();
  }

  void fetchPokemonList() async {
    print('fetchPokemonList');
    originalList = await NetworkUtil().fetchPokemonList(searchText, generationList);
    typeConditionChange();
    setState(() {});
  }

  void typeConditionChange() {
    setState(() {
      list = originalList.where((element) {
        bool result = false;
        for (var type in element.attribute.split(',')) {
          if (!result) {
            result = typeList
                .where((element) => element.isSelect)
                .map((e) => e.name)
                .contains(type);
          }
        }
        return result;
      }).toList();
    });
  }

  void generationChange(int generation) {
    setState(() {
      if (generationList.contains(generation)) {
        generationList.remove(generation);
      } else {
        generationList.add(generation);
      }
    });
    fetchPokemonList();
  }

  void reset() {
    setState((){
      typeList = TypeInfo.values
          .where((element) => element.name != 'unknown')
          .map((e) => TypeCondition(image: e.image, name: e.name))
          .toList();
      generationList = [1];
    });
    fetchPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: globalKey,
      endDrawer: listDrawer(
          typeList: typeList,
        generationList: generationList,
        typeChangeListener: (index, isSelect) {
          typeList[index].isSelect = isSelect;
          typeConditionChange();
        },
        generationChangeListener: (generation) {
          generationChange(generation);
        },
        resetListener: () {
          reset();
        }
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        '${imagesAddress}ic_prev.svg',
                        height: 24,
                        width: 24,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        globalKey.currentState?.openEndDrawer();
                      },
                      child: SvgPicture.asset(
                        '${imagesAddress}ic_menu.svg',
                        height: 24,
                        width: 24,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: TextField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(
                        color: Color(0xFF299AE6)
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xFFE3F4FF),
                    hintText: '포켓몬 검색'
                  ),
                  onSubmitted: (value){
                    setState((){
                      searchText = value;
                    });
                    fetchPokemonList();
                  },
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 23),
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: [
                    for (var item in list)
                      InkWell(
                        child: pokemonItem(item),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DetailScreen(number: item.number)));
                        },
                      )
                  ],
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
