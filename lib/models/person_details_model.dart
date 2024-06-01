import 'package:hive/hive.dart';

part 'person_details_model.g.dart';

@HiveType(typeId: 1)
class PersonDetailsModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;
  @HiveField(2)
  final String sex;
  PersonDetailsModel({
    required this.name,
    required this.age,
    required this.sex,
  });
}
