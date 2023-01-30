import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex_f/network/network.dart';
import 'package:pokedex_f/utils/constants.dart';

import '../../model/pokemon_info.dart';
import 'footer_items.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.number});

  final String number;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  Pokemon? pokemon;
  bool isShiny = false;
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    fetchPokemonDetailInfo();
  }

  void fetchPokemonDetailInfo() async {
    pokemon = await NetworkUtil().fetchPokemonDetailInfo(widget.number);
    setState(() {});
  }

  void _shinyStateChange() {
    setState(() {
      isShiny = !isShiny;
    });
  }

  void _pageMove(String number) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => DetailScreen(number: number)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF6A8),
        body: Stack(
          children: [
            detailHeader(isShiny),
            detailFooter(controller),
            detailBody(pokemon?.info, isShiny, _shinyStateChange)
          ],
        ),
      ),
    );
  }

  Widget detailHeader(bool isShiny) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 24,
          ),
          if (pokemon?.before?.dotImage == null)
            const SizedBox(
              width: 24,
              height: 24,
            )
          else
            GestureDetector(
              onTap: () {
                var number = pokemon?.before?.number;
                if (number == null) return;
                _pageMove(number);
              },
              child: SvgPicture.asset(
                '${imagesAddress}ic_prev.svg',
                width: 24,
                height: 24,
              ),
            ),
          if (pokemon?.before?.dotImage == null)
            const SizedBox(
              height: 42,
              width: 42,
            )
          else
            GestureDetector(
              onTap: () {
                var number = pokemon?.before?.number;
                if (number == null) return;
                _pageMove(number);
              },
              child: Image.network(
                isShiny
                    ? '${pokemon?.before?.dotShinyImage}'
                    : '${pokemon?.before?.dotImage}',
                errorBuilder: (
                  BuildContext context,
                  Object error,
                  StackTrace? stackTrace,
                ) {
                  return SvgPicture.asset(
                    '${imagesAddress}ic_ball.svg',
                    width: 42,
                    height: 42,
                  );
                },
                width: 42,
                height: 42,
              ),
            ),
          const Spacer(),
          Text(
            '#${pokemon?.info.number ?? '0000'}',
            style: const TextStyle(
                fontFamily: fontMaruBuri,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          const Spacer(),
          if (pokemon?.after?.dotImage == null)
            const SizedBox(
              width: 42,
              height: 42,
            )
          else
            GestureDetector(
              onTap: () {
                var number = pokemon?.after?.number;
                if (number == null) return;
                _pageMove(number);
              },
              child: Image.network(
                isShiny
                    ? '${pokemon?.after?.dotShinyImage}'
                    : '${pokemon?.after?.dotImage}',
                errorBuilder: (
                  BuildContext context,
                  Object error,
                  StackTrace? stackTrace,
                ) {
                  return SvgPicture.asset(
                    '${imagesAddress}ic_ball.svg',
                    width: 42,
                    height: 42,
                  );
                },
                width: 42,
                height: 42,
              ),
            ),
          if (pokemon?.after?.dotImage == null)
            const SizedBox(
              width: 42,
              height: 42,
            )
          else
            GestureDetector(
              onTap: () {
                var number = pokemon?.after?.number;
                if (number == null) return;
                _pageMove(number);
              },
              child: SvgPicture.asset(
                'assets/images/ic_next.svg',
                width: 24,
                height: 24,
              ),
            ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
    );
  }

  Widget detailBody(PokemonInfo? info, bool isShiny, Callback callback) {
    if (info == null) return const SizedBox();
    return Container(
      padding: const EdgeInsets.only(top: 57, left: 24, right: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              info.name,
              style: const TextStyle(
                  fontFamily: fontMaruBuri,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              for (var attribute in info.getAttributeImageList())
                Container(
                  margin: const EdgeInsets.only(right: 2),
                  child: Image.asset(
                    attribute,
                    width: 43,
                    height: 43,
                  ),
                ),
              const Spacer(),
              InkWell(
                child: SvgPicture.asset(isShiny == true
                    ? '${imagesAddress}ic_shiny.svg'
                    : '${imagesAddress}ic_normal.svg'),
                onTap: () {
                  callback.call();
                },
              )
            ],
          ),
          if (info.image.isNotEmpty)
            Image.network(
              isShiny ? info.shinyImage : info.image,
              width: 200,
              height: 200,
            )
        ],
      ),
    );
  }

  Widget detailFooter(TabController controller) {
    return Container(
      padding: const EdgeInsets.only(top: 290),
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.only(left: 13),
              child: TabBar(
                tabs: const [
                  Text('설명'),
                  Text('스테이터스'),
                  Text('상성'),
                  Text('진화'),
                ],
                controller: controller,
                indicatorColor: const Color(0xFFED6035),
                unselectedLabelColor: Colors.black,
                labelColor: const Color(0xFFED6035),
                labelStyle: const TextStyle(
                    fontFamily: fontMaruBuri,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                labelPadding:
                    const EdgeInsets.only(bottom: 5.5, left: 9, right: 9),
                isScrollable: true,
              ),
            ),
            const Divider(
              height: 1,
              color: Color(0xFFC8C8C8),
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  pokemon?.info != null
                      ? descriptionContainer(pokemon!.info)
                      : const SizedBox(),
                  pokemon?.info != null
                      ? statusContainer(pokemon!.info)
                      : const SizedBox(
                          child: Text('sizedBox'),
                        ),
                  pokemon?.info != null
                      ? compatibilityContainer(pokemon!.info.attribute)
                      : const SizedBox(),
                  pokemon?.evolution != null
                      ? evolutionContainer(pokemon!.evolution, isShiny)
                      : const SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
