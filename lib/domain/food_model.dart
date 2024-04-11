class Food {
  String name;
  String price;
  String imagePath;
  String composition;
  String comments;

  Food({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.composition,
    required this.comments,
  });
  String get _name => name;
  String get _price => price;
  String get _imagePath => imagePath;
  String get _composition => composition;
  String get _comments => comments;
}
