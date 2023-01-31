class PokemonListItem {
  final String number;
  final String name;
  final String dotImage;
  final String dotShinyImage;
  final String attribute;

  const PokemonListItem(
      {this.number = "",
      this.name = "",
      this.dotImage = "",
      this.dotShinyImage = "",
      this.attribute = ""});

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(
      number: json['number'],
      name: json['name'],
      dotImage: json['dotImage'],
      dotShinyImage: json['dotShinyImage'],
      attribute: json['attribute'],
    );
  }
}
