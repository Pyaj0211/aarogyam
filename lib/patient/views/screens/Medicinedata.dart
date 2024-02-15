class MedicineData {
  String name;
  String price;
  String imagepath;
  String rating;

  MedicineData({
    required this.name,
    required this.price,
    required this.imagepath,
    required this.rating,
});
  String get _name => name;
  String get _price => price;
  String get _imagepath => imagepath;
  String get _rating => rating;
}