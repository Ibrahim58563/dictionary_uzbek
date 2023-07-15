import 'dart:developer';

import 'package:dictionary/utils/app_colors.dart';
import 'package:dictionary/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

import 'models/word_hive_model.dart';

class WordDetailsScreen extends StatefulWidget {
  final String word;
  final String translatedWord;
  const WordDetailsScreen(
      {super.key, required this.word, required this.translatedWord});

  @override
  State<WordDetailsScreen> createState() => _WordDetailsScreenState();
}

final bookMarksBox = Hive.box<WordHiveAdapter>('bookMarks');

class _WordDetailsScreenState extends State<WordDetailsScreen> {
  void saveBookMarks(String word, String translation) {
    setState(() {
      Hive.box<WordHive>('bookMarks').add(WordHive(
        word: word,
        translation: translation,
      ));
      log("added");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.offWhite,
              )),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                // color: Colors.white,
                child: SvgPicture.asset(
                  "assets/dictionary_logo.svg",
                  color: AppColors.lightWhite,
                  height: 200,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: AppColors.lightWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.word,
                          style: bold32,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.translatedWord,
                          style: regular20,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.share,
                              size: 32,
                              color: AppColors.primary,
                            ),
                            InkWell(
                              onTap: () async {
                                saveBookMarks(
                                  widget.word,
                                  widget.translatedWord,
                                );
                                log("added to bookMark");
                              },
                              child: const Icon(
                                CupertinoIcons.bookmark,
                                size: 32,
                                color: AppColors.primary,
                              ),
                            ),
                            const Icon(
                              Icons.copy,
                              size: 32,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
