import 'package:pokedex_f/utils/constants.dart';

class Pokemon {
  final PokemonInfo info;
  final PokemonBriefInfo? before;
  final PokemonBriefInfo? after;
  final List<EvolutionInfo> evolution;

  const Pokemon(
      {required this.info, this.before, this.after, required this.evolution});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<dynamic> evolutionsJson = json['evolution'];
    List<EvolutionInfo> evolutions = List.empty(growable: true);
    for(var evolution in evolutionsJson) {
      evolutions.add(EvolutionInfo.fromJson(evolution));
    }

    return Pokemon(
        info: PokemonInfo.froJson(json['info']),
        before: json['before'] == null ? null : PokemonBriefInfo.fromJson(json['before']),
        after: json['after'] == null ? null : PokemonBriefInfo.fromJson(json['after']),
        evolution: evolutions);
  }
}

class PokemonInfo {
  final String number;
  final String status;
  final int index;
  final String characteristic;
  final String dotImage;
  final String dotShinyImage;
  final String shinyImage;
  final int generation;
  final String name;
  final String classification;
  final String attribute;
  final String image;
  final String description;

  PokemonInfo({required this.number,
    required this.status,
    required this.index,
    required this.characteristic,
    required this.dotImage,
    required this.dotShinyImage,
    required this.shinyImage,
    required this.generation,
    required this.name,
    required this.classification,
    required this.attribute,
    required this.image,
    required this.description});

  factory PokemonInfo.froJson(Map<String, dynamic> json) {
    return PokemonInfo(
        number: json['number'],
        status: json['status'],
        index: json['index'],
        characteristic: json['characteristic'],
        dotImage: json['dotImage'],
        dotShinyImage: json['dotShinyImage'],
        shinyImage: json['shinyImage'],
        generation: json['generation'],
        name: json['name'],
        classification: json['classification'],
        attribute: json['attribute'],
        image: json['image'],
        description: json['description']);
  }

  List<String> getAttributeImageList() {
    return attribute.split(',').map((e) => _getAttributeImage(e)).toList();
  }

  String _getAttributeImage(String attribute) {
    var result = "${imagesAddress}img_type_";
    switch(attribute) {
      case '불꽃':
        result += 'fire.png';
        break;
      case '물':
        result += 'water.png';
        break;
      case '풀':
        result += 'grass.png';
        break;
      case '전기':
        result += 'electric.png';
        break;
      case '얼음':
        result += 'ice.png';
        break;
      case '격투':
        result += 'fighting.png';
        break;
      case '독':
        result += 'poison.png';
        break;
      case '땅':
        result += 'ground.png';
        break;
      case '비행':
        result += 'flying.png';
        break;
      case '에스퍼':
        result += 'psychic.png';
        break;
      case '벌레':
        result += 'bug.png';
        break;
      case '바위':
        result += 'rock.png';
        break;
      case '고스트':
        result += 'ghost.png';
        break;
      case '드래곤':
        result += 'dragon.png';
        break;
      case '악':
        result += 'dark.png';
        break;
      case '강철':
        result += 'steel.png';
        break;
      case '페어리':
        result += 'fairy.png';
        break;
      default:
        result += "normal.png";
    }
    return result;
  }
}

class PokemonBriefInfo {
  final String number;
  final String name;
  final String dotImage;
  final String dotShinyImage;
  final String attribute;

  PokemonBriefInfo({required this.number,
    required this.name,
    required this.dotImage,
    required this.dotShinyImage,
    required this.attribute});

  factory PokemonBriefInfo.fromJson(Map<String, dynamic> json) {
    try {
      return PokemonBriefInfo(
          number: json['number'],
          name: json['name'],
          dotImage: json['dotImage'],
          dotShinyImage: json['dotShinyImage'],
          attribute: json['attribute']);
    } catch(e) {
      throw('진화 없음');
    }
  }
}

class EvolutionInfo {
  final String beforeDot;
  final String beforeShinyDot;
  final String afterDot;
  final String afterShinyDot;
  final String evolutionImage;
  final String evolutionConditions;

  EvolutionInfo({required this.beforeDot,
    required this.beforeShinyDot,
    required this.afterDot,
    required this.afterShinyDot,
    required this.evolutionImage,
    required this.evolutionConditions});

  factory EvolutionInfo.fromJson(Map<String, dynamic> json) {
    return EvolutionInfo(beforeDot: json['beforeDot'],
        beforeShinyDot: json['beforeShinyDot'],
        afterDot: json['afterDot'],
        afterShinyDot: json['afterShinyDot'],
        evolutionImage: json['evolutionImage'],
        evolutionConditions: json['evolutionConditions']);
  }
}