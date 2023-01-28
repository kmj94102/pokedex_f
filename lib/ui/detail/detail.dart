import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex_f/network/network.dart';
import 'package:pokedex_f/utils/constants.dart';

import '../../model/pokemon_info.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.number});

  final String number;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Pokemon? pokemon;
  bool isShiny = false;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF6A8),
        body: Stack(
          children: [
            detailHeader(isShiny),
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
          pokemon?.before?.dotImage == null
              ? const SizedBox(
                  width: 24,
                  height: 24,
                )
              : SvgPicture.asset(
                  '${imagesAddress}ic_prev.svg',
                  width: 24,
                  height: 24,
                ),
          pokemon?.before?.dotImage == null
              ? const SizedBox(
                  height: 42,
                  width: 42,
                )
              : Image.network(
                  isShiny ? '${pokemon?.before?.dotShinyImage}' : '${pokemon?.before?.dotImage}',
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
          const Spacer(),
          Text(
            '#${pokemon?.info.number ?? '0000'}',
            style: const TextStyle(
                fontFamily: fontMaruBuri,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          const Spacer(),
          pokemon?.after?.dotImage == null
              ? const SizedBox(
                  width: 42,
                  height: 42,
                )
              : Image.network(
                  isShiny ? '${pokemon?.after?.dotShinyImage}' : '${pokemon?.after?.dotImage}',
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
          pokemon?.after?.dotImage == null
              ? const SizedBox(
                  width: 42,
                  height: 42,
                )
              : SvgPicture.asset(
                  'assets/images/ic_next.svg',
                  width: 24,
                  height: 24,
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

  Widget detailBottomSheet() {
    return Column();
  }
}
