import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'news_controller.dart';

class NewsApp extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Update the dateController text whenever selectedDate changes
    newsController.selectedDate.listen((date) {
      dateController.text = date;
    });

    return Scaffold(
      appBar: AppBar(title: Text('News App by #Ashik')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Keywords'),
              onChanged: (value) => newsController.keywords.value = value,
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    dateController.text = newsController.selectedDate.value;
                    return TextField(
                      controller: dateController,
                      decoration:
                          InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          newsController.selectedDate.value =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
            Obx(() {
              return DropdownButton<String>(
                value: newsController.selectedLanguage.value,
                items: ['ar', 'de', 'en'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) =>
                    newsController.selectedLanguage.value = value!,
              );
            }),
            Obx(() {
              return DropdownButton<String>(
                value: newsController.selectedSortBy.value,
                items: ['relevancy', 'popularity', 'publishedAt']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) =>
                    newsController.selectedSortBy.value = value!,
              );
            }),
            Obx(() {
              final keywords = newsController.keywords.value;
              return ElevatedButton(
                onPressed: newsController.fetchNews,
                child: Text(
                  'Search news by Ashik',
                ),
              );
            }),
            Expanded(
              child: Obx(() {
                if (newsController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: newsController.newsList.length,
                    itemBuilder: (context, index) {
                      final article = newsController.newsList[index];
                      return ListTile(
                        title: Text(article['title']),
                        subtitle:
                            Text(article['description'] ?? 'No description'),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
