import 'package:hive/hive.dart';

part 'person_detail_model.g.dart';

@HiveType(typeId: 1)
class PersonDetailModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;
  @HiveField(2)
  final String gender;
  PersonDetailModel({
    required this.name,
    required this.age,
    required this.gender,
  });
}
