class UploadItem {
  String? titleText;
  String? bodyText;
  String? images;

  UploadItem({this.titleText, this.bodyText, this.images});

  UploadItem copyWith({
    String? titleText,
    String? bodyText,
    String? images,
  }) {
    return UploadItem(
      titleText: titleText ?? this.titleText,
      bodyText: bodyText ?? this.bodyText,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title_text': titleText,
      'body_text': bodyText,
      'images': images,
    };
  }

  factory UploadItem.fromJson(Map<String, dynamic> json) {
    return UploadItem(
      titleText: json['title_text'] as String?,
      bodyText: json['body_text'] as String?,
      images: json['images'] as String?,
    );
  }

  @override
  String toString() =>
      "UploadItem(titleText: $titleText,bodyText: $bodyText,images:$images)";

  @override
  int get hashCode => Object.hash(titleText, bodyText, images);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UploadItem &&
          runtimeType == other.runtimeType &&
          titleText == other.titleText &&
          bodyText == other.bodyText &&
          images == other.images;
}
