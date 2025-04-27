import 'dart:developer';
import 'package:get/get.dart';
import '../models/book_model.dart';
import '../services/book_service.dart';


class BookViewModel extends GetxController {
  var books = <Datum>[].obs;
  var filteredBooks = <Datum>[].obs;
  var groupedBooks = <String, List<Datum>>{}.obs;
  var filterGroupedTopics = <String, List<Datum>>{}.obs;
  var filterGroupedAuthors = <String, List<Datum>>{}.obs;
  var filterGroupedLanguage = <String, List<Datum>>{}.obs;
  var isLoading = false.obs;
  var selectedFilter = 'Topics'.obs;  // Default filter
  RxSet<String> selectedTopics = <String>{}.obs;
  RxSet<String> selectedAuthors = <String>{}.obs;
  RxSet<String> selectedLanguages = <String>{}.obs;
  var errorMessage = ''.obs; // observable string for error


  final List<String> filterOptions = ['Topics', 'Authors', 'Languages'];

  @override
  void onInit() {
    fetchBooks();
    super.onInit();
  }

void fetchBooks() async {
  isLoading(true);
  errorMessage.value = ''; // Clear previous error
  try {
    var fetchedBooks = await BookService.fetchBooks();
    books.value = fetchedBooks;
    groupAllFilterTypes(fetchedBooks);
    groupBooks('Topics'); // Default grouping
  } catch (e) {
    print("Error fetching books: $e");
    errorMessage.value = 'Please try again later';
  } finally {
    isLoading(false);
  }
}



  void groupBooks(String filterType) {
  var grouped = <String, List<Datum>>{};

  List<Datum> booksToGroup = filteredBooks.isNotEmpty ? filteredBooks : books;

  if (filterType == 'Topics') {
    for (var book in booksToGroup) {
      for (var topic in book.topicData) {
        String topicName = topic.topicEnglish ?? 'Unknown';
        if (!grouped.containsKey(topicName)) {
          grouped[topicName] = [];
        }
        grouped[topicName]?.add(book);
      }
    }
  } else if (filterType == 'Authors') {
    for (var book in booksToGroup) {
      for (var author in book.authorData) {
        String authorName = author.authorEnglish ?? 'Unknown';
        if (!grouped.containsKey(authorName)) {
          grouped[authorName] = [];
        }
        grouped[authorName]?.add(book);
      }
    }
  } else if (filterType == 'Languages') {
    for (var book in booksToGroup) {
      for (var language in book.languageData) {
        String languageName = language.languages ?? 'Unknown';
        if (!grouped.containsKey(languageName)) {
          grouped[languageName] = [];
        }
        grouped[languageName]?.add(book);
      }
    }
  }

  groupedBooks.value = grouped;
}


  // Set selected filter and refresh the books display
  void setFilter(String filter) {
    selectedFilter.value = filter;
    groupBooks(filter); // Re-group the books based on the selected filter
  }

  // Update selected filters
  void updateSelectedTopic(String topic) {
    if (selectedTopics.contains(topic)) {
      selectedTopics.remove(topic);
    } else {
      selectedTopics.add(topic);
    }
    applyFilters();
  }

  void updateSelectedAuthor(String author) {
    if (selectedAuthors.contains(author)) {
      selectedAuthors.remove(author);
    } else {
      selectedAuthors.add(author);
    }
    applyFilters();
  }

  void updateSelectedLanguage(String language) {
    if (selectedLanguages.contains(language)) {
      selectedLanguages.remove(language);
    } else {
      selectedLanguages.add(language);
    }
    applyFilters();
  }

  void applyFilters() {
  filteredBooks.clear();

  // Apply the selected filters
  for (var book in books) {
    bool match = false;

    if (selectedTopics.isNotEmpty &&
        book.topicData.any((topic) => selectedTopics.contains(topic.topicEnglish))) {
      match = true;
    }

    if (selectedAuthors.isNotEmpty &&
        book.authorData.any((author) => selectedAuthors.contains(author.authorEnglish))) {
      match = true;
    }

    if (selectedLanguages.isNotEmpty &&
        book.languageData.any((language) => selectedLanguages.contains(language.languages))) {
      match = true;
    }

    if (match) {
      filteredBooks.add(book);
    }
  }

  // Re-group filtered books based on the current filter
  groupBooks(selectedFilter.value);
}

  void groupAllFilterTypes(List<Datum> bookList) {
    var topicsGrouped = <String, List<Datum>>{};
    var authorsGrouped = <String, List<Datum>>{};
    var languagesGrouped = <String, List<Datum>>{};

    for (var book in bookList) {
      // Group by Topics
      for (var topic in book.topicData) {
        String topicName = topic.topicEnglish ?? 'Unknown';
        topicsGrouped.putIfAbsent(topicName, () => []).add(book);
      }

      // Group by Authors
      for (var author in book.authorData) {
        String authorName = author.authorEnglish ?? 'Unknown';
        authorsGrouped.putIfAbsent(authorName, () => []).add(book);
      }

      // Group by Languages
      for (var language in book.languageData) {
        String languageName = language.languages ?? 'Unknown';
        languagesGrouped.putIfAbsent(languageName, () => []).add(book);
      }
    }

    // Save into observable maps
    filterGroupedTopics.value = topicsGrouped;
    filterGroupedAuthors.value = authorsGrouped;
    filterGroupedLanguage.value = languagesGrouped;
  }

  void resetFilters() {
    selectedTopics.clear();
    selectedAuthors.clear();
    selectedLanguages.clear();
    filteredBooks.clear(); // Show all books again
    groupBooks(selectedFilter.value); // Re-group with original list
  }

}


