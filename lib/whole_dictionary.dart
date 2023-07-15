import 'dart:convert';

import 'package:dictionary/utils/app_colors.dart';
import 'package:dictionary/utils/text_styles.dart';
import 'package:dictionary/word_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WholeDictionaryScreen extends StatefulWidget {
  const WholeDictionaryScreen({super.key});

  @override
  State<WholeDictionaryScreen> createState() => _WholeDictionaryScreenState();
}

class _WholeDictionaryScreenState extends State<WholeDictionaryScreen> {
  List _words = [];
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
    readDictionary();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Words",
          style: TextStyle(color: AppColors.secondary, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _words.length,
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
                            word: _words[index]['langFullWord'],
                            translatedWord: _words[index]['entry'],
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
                                _words[index]['langFullWord'],
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
