import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/compatibility.dart';
import '../../model/pokemon_info.dart';
import '../../model/status_info.dart';
import '../../model/type_info.dart';
import '../../utils/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget descriptionContainer(PokemonInfo info) {
  TextStyle textStyle = const TextStyle(fontFamily: fontMaruBuri, fontSize: 14);
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
              padding: const EdgeInsets.all(7), child: Text(info.description)),
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
  TextStyle textStyle = const TextStyle(fontFamily: fontMaruBuri, fontSize: 14);
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
  if (status / 150 >= 1) {
    result = 1;
  } else if (status / 150 > 0.1) {
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
          compatibility:
              typeWeaknessInfoList[0][index] * typeWeaknessInfoList[1][index]));
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
            for (var info
                in weaknessInfo.where((e) => e.compatibility == 0.25).toList())
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

Widget evolutionContainer(List<EvolutionInfo> infoList, bool isShiny) {
  return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          for(var info in infoList) evolutionItem(info, isShiny)
        ],
      ));
}

Widget evolutionItem(EvolutionInfo info, bool isShiny) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Image.network(
        isShiny ? info.beforeShinyDot : info.beforeDot,
        width: 80,
        height: 80,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            info.evolutionImage,
            width: 24,
            height: 24,
          ),
          const SizedBox(
            height: 3,
          ),
          SizedBox(
            width: 85,
            child: Text(
              info.evolutionConditions,
              style: const TextStyle(
                fontFamily: fontMaruBuri,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      Image.network(
        isShiny ? info.afterShinyDot : info.afterDot,
        width: 80,
        height: 80,
      ),
    ],
  );
}
