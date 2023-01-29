import 'dart:ui';

import 'package:pokedex_f/utils/constants.dart';

enum TypeInfo {
  normal(
      name: '노말',
      image: '${imagesAddress}img_type_normal.png',
      color: Color(0xFFE3E8ED)),
  fire(
      name: '불꽃',
      image: '${imagesAddress}img_type_fire.png',
      color: Color(0xFFFFC289)),
  water(
      name: '물',
      image: '${imagesAddress}img_type_water.png',
      color: Color(0xFF7CC5FF)),
  electric(
      name: '전기',
      image: '${imagesAddress}img_type_electric.png',
      color: Color(0xFFFFF6A8)),
  grass(
      name: '풀',
      image: '${imagesAddress}img_type_grass.png',
      color: Color(0xFF91FBA0)),
  ice(
      name: '얼음',
      image: '${imagesAddress}img_type_ice.png',
      color: Color(0xFF96FCEF)),
  fighting(
      name: '격투',
      image: '${imagesAddress}img_type_fighting.png',
      color: Color(0xFFFF93B6)),
  poison(
      name: '독',
      image: '${imagesAddress}img_type_poison.png',
      color: Color(0xFFCF9EFF)),
  ground(
      name: '땅',
      image: '${imagesAddress}img_type_ground.png',
      color: Color(0xFFFFB877)),
  flying(
      name: '비행',
      image: '${imagesAddress}img_type_flying.png',
      color: Color(0xFFB5D0FF)),
  psychic(
      name: '에스퍼',
      image: '${imagesAddress}img_type_psychic.png',
      color: Color(0xFFFFA4AD)),
  bug(
      name: '벌레',
      image: '${imagesAddress}img_type_bug.png',
      color: Color(0xFFBBFF86)),
  rock(
      name: '바위',
      image: '${imagesAddress}img_type_rock.png',
      color: Color(0xFFEEDAA5)),
  ghost(
      name: '고스트',
      image: '${imagesAddress}img_type_ghost.png',
      color: Color(0xFF9E8EFF)),
  dragon(
      name: '드래곤',
      image: '${imagesAddress}img_type_dragon.png',
      color: Color(0xFF587DFF)),
  dark(
      name: '악',
      image: '${imagesAddress}img_type_dark.png',
      color: Color(0xFF918A9C)),
  steel(
      name: '강철',
      image: '${imagesAddress}img_type_steel.png',
      color: Color(0xFF93C7DB)),
  fairy(
      name: '페어리',
      image: '${imagesAddress}img_type_fairy.png',
      color: Color(0xFFFDADFF)),
  unknown(
      name: 'unknown',
      image: '${imagesAddress}ic_normal.png',
      color: Color(0xFFFFFFFF));

  const TypeInfo(
      {required this.name, required this.image, required this.color});

  final String name;
  final String image;
  final Color color;

  String getImage(String name) {
    if (!TypeInfo.values.any((element) => element.name == name)) {
      return TypeInfo.unknown.image;
    }
    return TypeInfo.values.firstWhere((element) => element.name == name).image;
  }

  Color getColor(String name) {
    if (!TypeInfo.values.any((element) => element.name == name)) {
      return TypeInfo.unknown.color;
    }
    return TypeInfo.values.firstWhere((element) => element.name == name).color;
  }

  List<double> getWeaknessInfo(String type) {
    List<double> result = List.empty(growable: true);

    if(type == TypeInfo.normal.name) {
      result = [
        1, 1, 1, 1, 1, 1,
        2, 1, 1, 1, 1, 1,
        1, 0, 1, 1, 1, 1,
      ];
    } else if(type == TypeInfo.fire.name) {
      result = [
        1, 0.5, 2, 1, 0.5, 0.5,
        1, 1, 2, 1, 1, 0.5,
        2, 1, 1, 1, 0.5, 0.5,
      ];
    } else if(type == TypeInfo.water.name) {
      result = [
        1, 0.5, 0.5, 2, 2, 0.5,
        1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 0.5, 1,
      ];
    } else if(type == TypeInfo.electric.name) {
      result = [
        1, 1, 1, 0.5, 1, 1,
        1, 1, 2, 0.5, 1, 1,
        1, 1, 1, 1, 0.5, 1,
      ];
    }
    else if(type == TypeInfo.grass.name) {
      result = [
        1, 2, 0.5, 0.5, 0.5, 2,
        1, 2, 0.5, 2, 1, 2,
        1, 1, 1, 1, 1, 1,
      ];
    }
    else if(type == TypeInfo.ice.name) {
      result = [
        1, 2, 1, 1, 1, 0.5,
        2, 1, 1, 1, 1, 1,
        2, 1, 1, 1, 2, 1,
      ];
    } else if(type == TypeInfo.fighting.name) {
      result = [
        1, 1, 1, 1, 1, 1,
        1, 1, 1, 2, 2, 0.5,
        0.5, 1, 1, 0.5, 1, 2,
      ];
    } else if(type == TypeInfo.poison.name) {
      result = [
        1, 1, 1, 1, 0.5, 1,
        0.5, 0.5, 2, 1, 2, 0.5,
        1, 1, 1, 1, 1, 0.5,
      ];
    } else if(type == TypeInfo.ground.name) {
      result = [
        1, 1, 2, 0.5, 2, 2,
        1, 0.5, 1, 1, 1, 1,
        0.5, 1, 1, 1, 1, 1,
      ];
    } else if(type == TypeInfo.flying.name) {
      result = [
        1, 1, 1, 2, 0.5, 2,
        0.5, 1, 0, 1, 1, 0.5,
        2, 1, 1, 1, 1, 1,
      ];
    } else if(type == TypeInfo.psychic.name) {
      result = [
        1, 1, 1, 1, 1, 1,
        0.5, 1, 1, 1, 0.5, 2,
        1, 2, 1, 2, 1, 1,
      ];
    } else if(type == TypeInfo.bug.name) {
      result = [
        1, 2, 1, 1, 0.5, 1,
        0.5, 1, 0.5, 2, 1, 1,
        2, 1, 1, 1, 1, 1,
      ];
    } else if(type == TypeInfo.rock.name) {
      result = [
        0.5, 0.5, 2, 1, 2, 1,
        2, 0.5, 2, 0.5, 1, 1,
        1, 1, 1, 1, 2, 1,
      ];
    } else if(type == TypeInfo.ghost.name) {
      result = [
        0, 1, 1, 1, 1, 1,
        0, 0.5, 1, 1, 1, 0.5,
        1, 2, 1, 2, 1, 1,
      ];
    } else if(type == TypeInfo.dragon.name) {
      result = [
        1, 0.5, 0.5, 0.5, 0.5, 2,
        1, 1, 1, 1, 1, 1,
        1, 1, 2, 1, 1, 2,
      ];
    } else if(type == TypeInfo.dark.name) {
      result = [
        1, 1, 1, 1, 1, 1,
        2, 1, 1, 1, 0.5, 2,
        1, 0.5, 1, 0.5, 1, 2,
      ];
    } else if(type == TypeInfo.steel.name) {
      result = [
        0.5, 2, 1, 1, 0.5, 0.5,
        2, 0.5, 2, 0.5, 0.5, 0.5,
        0.5, 1, 0.5, 1, 0.5, 0.5,
      ];
    } else if(type == TypeInfo.fairy.name) {
      result = [
        1, 1, 1, 1, 1, 1,
        0.5, 2, 1, 1, 1, 0.5,
        1, 1, 0, 0.5, 2, 1
      ];
    } else {
      result = [
        0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0,
      ];
    }

    return result;
  }
}

TypeInfo getTypeInfo(String type) {
  return TypeInfo.values.firstWhere((element) => element.name == type);
}