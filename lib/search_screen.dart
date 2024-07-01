import 'dart:convert';
import 'dart:developer';
import 'package:dictionary/models/word_hive_model.dart';
import 'package:dictionary/utils/app_colors.dart';
import 'package:dictionary/utils/text_styles.dart';
import 'package:dictionary/word_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

List _words = [];
List<dynamic> _foundWords = [];
final historyBox = Hive.box<WordHiveAdapter>('history');

class _SearchScreenState extends State<SearchScreen> {
  Future<void> readDictionary() async {
    final String response =
        await rootBundle.loadString('assets/json_dictionary.json');
    final data = await jsonDecode(response);
    setState(() {
      _words = data;
    });
  }

  @override
  void initState() {
    readDictionary().then((value) {
      _foundWords = [];
    });
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      results = [];
    } else {
      results = _words
          .where((word) => (word["langFullWord"])
              .toString()
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      print(results);
    }
    setState(() {
      _foundWords = results;
    });
  }

  void saveHistory(String word, String translation) {
    setState(() {
      Hive.box<WordHive>('history').add(WordHive(
        word: word,
        translation: translation,
      ));
      log("added");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            SvgPicture.asset(
              "assets/dictionary_logo.svg",
              color: AppColors.lightWhite,
              height: 200,
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _runFilter(value);
                        });
                      },
                      onSubmitted: (value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WordDetailsScreen(
                              word: _foundWords[0]['langFullWord'],
                              translatedWord: _foundWords[0]['entry'],
                            ),
                          ),
                        );
                        saveHistory(
                          _foundWords[0]['langFullWord'],
                          _foundWords[0]['entry'],
                        );
                        print("word saved to history box");
                      },
                      style: const TextStyle(
                          color: AppColors.secondary, fontSize: 22),
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: 'kalima yoming',
                        hintStyle: TextStyle(
                            color: AppColors.secondary.withOpacity(0.3)),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WordDetailsScreen(
                              word: _foundWords[0]['langFullWord'],
                              translatedWord: _foundWords[0]['entry'],
                            ),
                          ),
                        );
                        saveHistory(
                          _foundWords[0]['langFullWord'],
                          _foundWords[0]['entry'],
                        );
                        print("word saved to history box");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.secondary),
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Oxtaring",
                            style: TextStyle(fontSize: 24),
                          ),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _foundWords.isNotEmpty
                  ? ListView.separated(
                      itemCount: _foundWords.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WordDetailsScreen(
                                  word: _foundWords[index]['langFullWord'],
                                  translatedWord: _foundWords[index]['entry'],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.offWhite),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const CircleAvatar(
                                    backgroundColor: AppColors.primary,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: AppColors.secondary,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      _foundWords[index]['langFullWord'],
                                      style: bold24,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Text(" "),
            ),
          ],
        ),
      ),
    );
  }
}
