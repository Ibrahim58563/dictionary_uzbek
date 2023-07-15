import 'package:hive/hive.dart';
part 'word_hive_model.g.dart';

@HiveType(typeId: 0)
class WordHive extends HiveObject {
  @HiveField(0)
  final String word;
  @HiveField(1)
  final String translation;
  WordHive({
    required this.word,
    required this.translation,
  });
}
