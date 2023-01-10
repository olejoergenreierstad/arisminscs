import 'package:AirmineStudy/models/placemodels.dart';

class User {
  String? name;
  String? email;
  List<PollenType>? allergicTypes;

  User({
    this.name,
    this.email,
    this.allergicTypes,
  });
}
