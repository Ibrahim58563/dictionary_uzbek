import 'package:dictionary/models/word_hive_model.dart';
import 'package:dictionary/utils/app_colors.dart';
import 'package:dictionary/utils/text_styles.dart';
import 'package:dictionary/word_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Tarix",
            style: TextStyle(color: AppColors.secondary, fontSize: 24),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ValueListenableBuilder<Box<WordHive>>(
            valueListenable: Hive.box<WordHive>('history').listenable(),
            builder: (context, value, child) {
              final historyList = value.values.toList();
              if (historyList.isEmpty) {
                return const Center(
                  child: Text("No Items yet, add some"),
                );
              } else {
                return ListView.separated(
                  itemCount: historyList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WordDetailsScreen(
                              word: historyList[index].word,
                              translatedWord: historyList[index].translation,
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
                                  historyList[index].word,
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
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
