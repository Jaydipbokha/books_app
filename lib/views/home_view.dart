import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utiles/color.dart';
import '../viewmodels/book_viewmodel.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_marquee.dart';
import '../widgets/text_widget.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final BookViewModel controller = Get.put(BookViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: 'Books by Filter',
        centerTile: true,
        isActionWidget: GestureDetector(
          onTap: () {
            _showFilterBottomSheet(context, controller);
          },
          child: Container(
            margin: EdgeInsets.only(right: 10),
            width: 30,
            height: 30,
            decoration: BoxDecoration(color: AppColors.transparentColor),
            child: Icon(Icons.filter_alt),
          ),
        ),
      ),
      body: GetX<BookViewModel>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return Center(
                child: CircularProgressIndicator(
              color: AppColors.blackColor,
            ));
          }
          if (controller.errorMessage.isNotEmpty) {
            // If there's an error
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Something went wrong... ',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    'Please try again later',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      controller.fetchBooks();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                      decoration: BoxDecoration(
                          color: AppColors.blackColor,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: CustomText(
                        'Retry',
                        color: AppColors.whiteColor,
                        fontSize: 14,
                      ),
                    ),
                  )
                  // ElevatedButton(
                  //   onPressed: () {
                  //     controller.fetchBooks(); // Retry API
                  //   },
                  //   child: Text('Retry'),
                  // ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.selectedFilter.value,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        dropdownColor: Colors.white,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.setFilter(newValue);
                          }
                        },
                        items: controller.filterOptions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),

                // Display books based on selected filter
                Expanded(
                  child: ListView(
                    children: controller.groupedBooks.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              entry.key,
                              fontSize: 19,
                            ),
                          ),
                          SizedBox(
                            height: 195,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: entry.value.length,
                              itemBuilder: (context, index) {
                                final book = entry.value[index];
                                return Container(
                                  width: 135,
                                  height: 150,
                                  padding: EdgeInsets.all(4),
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: AppColors.hintTextColor),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    color: AppColors.whiteColor,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          height: 150,
                                          width: Get.width,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            child: Image.network(
                                              'https://admin.pustakam.co.in${book.bookFrontImage}',
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child; // Image loaded
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: AppColors.blackColor,
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            (loadingProgress
                                                                    .expectedTotalBytes ??
                                                                1)
                                                        : null,
                                                  ),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Center(
                                                    child: Icon(Icons
                                                        .error)); // Show error icon if image fails to load
                                              },
                                            ),
                                          )),
                                      // CustomMarquee(
                                      //   text: book.bookNameEnglish ?? '',
                                      //   velocity: 100, // speed of scrolling
                                      //   style: TextStyle(
                                      //       color: Colors.blue, fontSize: 24),
                                      // ),

                                      CustomText(
                                        book.bookNameEnglish ?? '',
                                        fontSize: 14,
                                      ),
                                      CustomText(
                                        book.authorData.isNotEmpty
                                            ? book.authorData[0]
                                                    .authorEnglish ??
                                                ''
                                            : 'Unknown Author',
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Bottom sheet to display filter options
  // Bottom sheet to display filter options
  void _showFilterBottomSheet(BuildContext context, BookViewModel controller) {
    final RxString selectedSection = 'Topics'.obs; // Track selected section

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          height: 500, // 🔥 Fixed height for the bottom sheet
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(color: AppColors.whiteColor),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Tabs (Fixed)
                    Container(
                      width: 100,
                      margin: EdgeInsets.only(top: 6),
                      decoration: BoxDecoration(color: AppColors.whiteColor),
                      child: Column(
                        children: [
                          _buildSectionTab("Topics", selectedSection),
                          _buildSectionTab("Authors", selectedSection),
                          _buildSectionTab("Languages", selectedSection),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    // Right Section Content (Scrollable)
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(color: AppColors.whiteColor),
                        child: SingleChildScrollView(
                          // 🔥 Make only section scrollable
                          child: Obx(() {
                            switch (selectedSection.value) {
                              case "Authors":
                                return _buildFilterSection(
                                  title: "Authors",
                                  items: controller.filterGroupedAuthors.keys
                                      .where((author) => author != 'Unknown')
                                      .toList(),
                                  selectedItems: controller.selectedAuthors,
                                  onChanged: controller.updateSelectedAuthor,
                                );
                              case "Languages":
                                return _buildFilterSection(
                                  title: "Languages",
                                  items: controller.filterGroupedLanguage.keys
                                      .where(
                                          (language) => language != 'Unknown')
                                      .toList(),
                                  selectedItems: controller.selectedLanguages,
                                  onChanged: controller.updateSelectedLanguage,
                                );
                              case "Topics":
                              default:
                                return _buildFilterSection(
                                  title: "Topics",
                                  items: controller.filterGroupedTopics.keys
                                      .where((topic) => topic != 'Unknown')
                                      .toList(),
                                  selectedItems: controller.selectedTopics,
                                  onChanged: controller.updateSelectedTopic,
                                );
                            }
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              // Bottom Buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.resetFilters();
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            border: Border.all(
                                color: AppColors.hintTextColor, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Center(
                          child: CustomText(
                            "Reset",
                            color: AppColors.blackColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.applyFilters();
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.blackColor,
                            border: Border.all(
                                color: AppColors.greyBackGroundColor, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Center(
                          child: CustomText(
                            "Apply Filters",
                            color: AppColors.whiteColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterSection({
    required String title,
    required List<String> items,
    required RxSet<String> selectedItems,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Wrap(
              spacing: 4.0,
              runSpacing: 1.0,
              children: items.map((item) {
                return Obx(
                  () => FilterChip(
                    label: Text(
                      item,
                      style: TextStyle(
                        color: selectedItems.contains(item)
                            ? Colors.white
                            : Colors.black, // Label text color
                      ),
                    ),
                    selected: selectedItems.contains(item),
                    selectedColor: Colors.black, // Background when selected
                    backgroundColor:
                        Colors.white, // Background when not selected
                    checkmarkColor:
                        Colors.white, // 🔥 Checkmark color when selected
                    onSelected: (bool selected) {
                      onChanged(item); // Toggle selected item
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTab(String title, RxString selectedSection) {
    return Obx(() {
      final isSelected = selectedSection.value == title;
      return GestureDetector(
        onTap: () => selectedSection.value = title,
        child: Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: CustomText(
            title,
            color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
            fontSize: 15,
            textAlign: TextAlign.center,
          ),
        ),
      );
    });
  }
}
