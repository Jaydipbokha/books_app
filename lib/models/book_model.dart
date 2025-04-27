class Book {
    Book({
        required this.status,
        required this.data,
    });

    final String? status;
    final List<Datum> data;

    factory Book.fromJson(Map<String, dynamic> json){ 
        return Book(
            status: json["status"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.map((x) => x?.toJson()).toList(),
    };

}

class Datum {
    Datum({
        required this.id,
        required this.authorData,
        required this.topicData,
        required this.languageData,
        required this.bookKeywords,
        required this.bookFrontImage,
        required this.bookFile,
        required this.timestamp,
        required this.number,
        required this.bookNameEnglish,
        required this.bookPrice,
        required this.purchaseCount,
        required this.downloadCount,
        required this.draft,
        required this.bookNameHindi,
        required this.bookSubtitleEnglish,
        required this.bookSubtitleHindi,
        required this.bookDetailsEnglish,
        required this.bookDetailsHindi,
        required this.bookPriceDiscount,
        required this.bookFreeDemo,
        required this.purchase,
        required this.authorDetailsEnglish,
        required this.authorDetailsHindi,
    });

    final num? id;
    final List<AuthorDatum> authorData;
    final List<TopicDatum> topicData;
    final List<LanguageDatum> languageData;
    final List<String> bookKeywords;
    final String? bookFrontImage;
    final String? bookFile;
    final DateTime? timestamp;
    final num? number;
    final String? bookNameEnglish;
    final num? bookPrice;
    final num? purchaseCount;
    final num? downloadCount;
    final bool? draft;
    final String? bookNameHindi;
    final dynamic bookSubtitleEnglish;
    final dynamic bookSubtitleHindi;
    final String? bookDetailsEnglish;
    final String? bookDetailsHindi;
    final num? bookPriceDiscount;
    final num? bookFreeDemo;
    final dynamic purchase;
    final String? authorDetailsEnglish;
    final String? authorDetailsHindi;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            authorData: json["author_data"] == null ? [] : List<AuthorDatum>.from(json["author_data"]!.map((x) => AuthorDatum.fromJson(x))),
            topicData: json["topic_data"] == null ? [] : List<TopicDatum>.from(json["topic_data"]!.map((x) => TopicDatum.fromJson(x))),
            languageData: json["language_data"] == null ? [] : List<LanguageDatum>.from(json["language_data"]!.map((x) => LanguageDatum.fromJson(x))),
            bookKeywords: json["book_keywords"] == null ? [] : List<String>.from(json["book_keywords"]!.map((x) => x)),
            bookFrontImage: json["book_front_image"],
            bookFile: json["book_file"],
            timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
            number: json["number"],
            bookNameEnglish: json["book_name_english"],
            bookPrice: json["book_price"],
            purchaseCount: json["purchase_count"],
            downloadCount: json["download_count"],
            draft: json["draft"],
            bookNameHindi: json["book_name_hindi"],
            bookSubtitleEnglish: json["book_subtitle_english"],
            bookSubtitleHindi: json["book_subtitle_hindi"],
            bookDetailsEnglish: json["book_details_english"],
            bookDetailsHindi: json["book_details_hindi"],
            bookPriceDiscount: json["book_price_discount"],
            bookFreeDemo: json["book_free_demo"],
            purchase: json["purchase"],
            authorDetailsEnglish: json["author_details_english"],
            authorDetailsHindi: json["author_details_hindi"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "author_data": authorData.map((x) => x?.toJson()).toList(),
        "topic_data": topicData.map((x) => x?.toJson()).toList(),
        "language_data": languageData.map((x) => x?.toJson()).toList(),
        "book_keywords": bookKeywords.map((x) => x).toList(),
        "book_front_image": bookFrontImage,
        "book_file": bookFile,
        "timestamp": timestamp?.toIso8601String(),
        "number": number,
        "book_name_english": bookNameEnglish,
        "book_price": bookPrice,
        "purchase_count": purchaseCount,
        "download_count": downloadCount,
        "draft": draft,
        "book_name_hindi": bookNameHindi,
        "book_subtitle_english": bookSubtitleEnglish,
        "book_subtitle_hindi": bookSubtitleHindi,
        "book_details_english": bookDetailsEnglish,
        "book_details_hindi": bookDetailsHindi,
        "book_price_discount": bookPriceDiscount,
        "book_free_demo": bookFreeDemo,
        "purchase": purchase,
        "author_details_english": authorDetailsEnglish,
        "author_details_hindi": authorDetailsHindi,
    };

}

class AuthorDatum {
    AuthorDatum({
        required this.id,
        required this.authorEnglish,
        required this.authorHindi,
        required this.timestamp,
        required this.number,
        required this.topicData,
    });

    final num? id;
    final String? authorEnglish;
    final String? authorHindi;
    final DateTime? timestamp;
    final num? number;
    final dynamic topicData;

    factory AuthorDatum.fromJson(Map<String, dynamic> json){ 
        return AuthorDatum(
            id: json["id"],
            authorEnglish: json["author_english"],
            authorHindi: json["author_hindi"],
            timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
            number: json["number"],
            topicData: json["topic_data"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "author_english": authorEnglish,
        "author_hindi": authorHindi,
        "timestamp": timestamp?.toIso8601String(),
        "number": number,
        "topic_data": topicData,
    };

}

class LanguageDatum {
    LanguageDatum({
        required this.id,
        required this.languages,
        required this.number,
        required this.timestamp,
    });

    final num? id;
    final String? languages;
    final num? number;
    final DateTime? timestamp;

    factory LanguageDatum.fromJson(Map<String, dynamic> json){ 
        return LanguageDatum(
            id: json["id"],
            languages: json["languages"],
            number: json["number"],
            timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "languages": languages,
        "number": number,
        "timestamp": timestamp?.toIso8601String(),
    };

}

class TopicDatum {
    TopicDatum({
        required this.id,
        required this.topicEnglish,
        required this.topicHindi,
        required this.timestamp,
        required this.number,
    });

    final num? id;
    final String? topicEnglish;
    final String? topicHindi;
    final DateTime? timestamp;
    final num? number;

    factory TopicDatum.fromJson(Map<String, dynamic> json){ 
        return TopicDatum(
            id: json["id"],
            topicEnglish: json["topic_english"],
            topicHindi: json["topic_hindi"],
            timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
            number: json["number"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "topic_english": topicEnglish,
        "topic_hindi": topicHindi,
        "timestamp": timestamp?.toIso8601String(),
        "number": number,
    };

}
