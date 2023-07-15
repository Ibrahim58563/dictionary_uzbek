import 'dart:convert';

class Word {
  final String word;
  final String translation;
  Word({
    required this.word,
    required this.translation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'word': word,
      'translation': translation,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      word: map['word'] as String,
      translation: map['translation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Word.fromJson(String source) =>
      Word.fromMap(json.decode(source) as Map<String, dynamic>);
}
