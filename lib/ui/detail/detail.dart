import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex_f/model/compatibility.dart';
import 'package:pokedex_f/model/status_info.dart';
import 'package:pokedex_f/model/type_info.dart';
import 'package:pokedex_f/network/network.dart';
import 'package:pokedex_f/utils/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../model/pokemon_info.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF6A8),
        body: Stack(
          children: [
            detailHeader(isShiny),
            detailFooter(pokemon?.info, controller),
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

  Widget detailFooter(PokemonInfo? info, TabController controller) {
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
                  info != null ? descriptionContainer(info) : const SizedBox(),
                  info != null
                      ? statusContainer(info)
                      : const SizedBox(
                          child: Text('sizedBox'),
                        ),
                  info != null
                      ? compatibilityContainer(info.attribute)
                      : const SizedBox(),
                  info != null ? descriptionContainer(info) : const SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget descriptionContainer(PokemonInfo info) {
    TextStyle textStyle =
        const TextStyle(fontFamily: fontMaruBuri, fontSize: 14);
    TextStyle titleTextStyle = const TextStyle(
        fontFamily: fontMaruBuri,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFFED6035));

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: EdgeInsets.zero,
            elevation: 4,
            child: Container(
                padding: const EdgeInsets.all(7),
                child: Text(info.description)),
          ),
          const SizedBox(
            height: 13,
          ),
          Text(
            '분류',
            style: titleTextStyle,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            info.characteristic,
            style: textStyle,
          ),
          const SizedBox(
            height: 13,
          ),
          Text(
            '특성',
            style: titleTextStyle,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            info.classification,
            style: textStyle,
          ),
        ],
      ),
    );
  }

  Widget statusContainer(PokemonInfo info) {
    var statusList = info.status.split(',').map((e) => int.parse(e)).toList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: List.generate(StatusInfo.values.length,
            (index) => statusBar(StatusInfo.values[index], statusList[index])),
      ),
    );
  }

  Widget statusBar(StatusInfo statusInfo, int status) {
    TextStyle textStyle =
        const TextStyle(fontFamily: fontMaruBuri, fontSize: 14);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              statusInfo.name,
              style: textStyle,
            ),
          ),
          Expanded(
            flex: 7,
            child: LinearPercentIndicator(
              backgroundColor: const Color(0xFFD9D9D9),
              progressColor: statusInfo.color,
              percent: getPercent(status),
              lineHeight: 22,
              center: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    '$status',
                    style: const TextStyle(
                        fontFamily: fontMaruBuri,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              animation: true,
              animationDuration: 1500,
              barRadius: const Radius.circular(22),
            ),
          )
        ],
      ),
    );
  }

  double getPercent(int status) {
    double result = 0.1;
    if (status / 150 > 0.1) {
      result = status / 150;
    }
    return result;
  }

  Widget compatibilityContainer(String attribute) {
    var textStyle = const TextStyle(
        fontFamily: fontMaruBuri, fontSize: 14, fontWeight: FontWeight.bold);
    List<TypeInfo> typeInfoList = TypeInfo.values;
    var typeWeaknessInfoList = attribute
        .split(',')
        .map((e) => getTypeInfo(e).getWeaknessInfo(e))
        .toList();
    List<Compatibility> weaknessInfo = List.empty(growable: true);

    if (typeWeaknessInfoList.isNotEmpty && typeWeaknessInfoList.length != 1) {
      List.generate(typeWeaknessInfoList[0].length, (index) {
        weaknessInfo.add(Compatibility(
            type: typeInfoList[index].name,
            compatibility: typeWeaknessInfoList[0][index] *
                typeWeaknessInfoList[1][index]));
      });
    } else if (typeWeaknessInfoList.isNotEmpty) {
      List.generate(typeWeaknessInfoList[0].length, (index) {
        weaknessInfo.add(Compatibility(
            type: typeInfoList[index].name,
            compatibility: typeWeaknessInfoList[0][index]));
      });
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          weaknessInfo.where((e) => e.compatibility == 0).toList().isNotEmpty
              ? Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    '효과 없음',
                    style: textStyle,
                  ),
                )
              : const SizedBox(),
          Wrap(
            spacing: 5,
            children: [
              for (var info
              in weaknessInfo.where((e) => e.compatibility == 0).toList())
                Image.asset(
                  getTypeInfo(info.type).image,
                  width: 55,
                  height: 55,
                )
            ],
          ),
          weaknessInfo.where((e) => e.compatibility == 4).toList().isNotEmpty
              ? Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'x 4',
                    style: textStyle,
                  ),
                )
              : const SizedBox(),
          Wrap(
            spacing: 5,
            children: [
              for (var info
                  in weaknessInfo.where((e) => e.compatibility == 4).toList())
                Image.asset(
                  getTypeInfo(info.type).image,
                  width: 55,
                  height: 55,
                )
            ],
          ),
          weaknessInfo.where((e) => e.compatibility == 2).toList().isNotEmpty
              ? Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              'x 2',
              style: textStyle,
            ),
          )
              : const SizedBox(),
          Wrap(
            spacing: 5,
            children: [
              for (var info
                  in weaknessInfo.where((e) => e.compatibility == 2).toList())
                Image.asset(
                  getTypeInfo(info.type).image,
                  width: 55,
                  height: 55,
                )
            ],
          ),
          weaknessInfo.where((e) => e.compatibility == 0.25).toList().isNotEmpty
              ? Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'x 0.25',
                    style: textStyle,
                  ),
                )
              : const SizedBox(),
          Wrap(
            spacing: 5,
            children: [
              for (var info in weaknessInfo
                  .where((e) => e.compatibility == 0.25)
                  .toList())
                Image.asset(
                  getTypeInfo(info.type).image,
                  width: 55,
                  height: 55,
                )
            ],
          ),
          weaknessInfo.where((e) => e.compatibility == 0.5).toList().isNotEmpty
              ? Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'x 0.5',
                    style: textStyle,
                  ),
                )
              : const SizedBox(),
          Wrap(
            spacing: 5,
            children: [
              for (var info
                  in weaknessInfo.where((e) => e.compatibility == 0.5).toList())
                Image.asset(
                  getTypeInfo(info.type).image,
                  width: 55,
                  height: 55,
                )
            ],
          ),
          weaknessInfo.where((e) => e.compatibility == 1).toList().isNotEmpty
              ? Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    '보통 효과',
                    style: textStyle,
                  ),
                )
              : const SizedBox(),
          Wrap(
            spacing: 5,
            children: [
              for (var info
                  in weaknessInfo.where((e) => e.compatibility == 1).toList())
                Image.asset(
                  getTypeInfo(info.type).image,
                  width: 55,
                  height: 55,
                )
            ],
          ),
        ],
      ),
    );
  }
}
