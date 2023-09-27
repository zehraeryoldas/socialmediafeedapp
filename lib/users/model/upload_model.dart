class UploadItem {
  String? titleText;
  String? bodyText;

  UploadItem({
    this.titleText,
    this.bodyText,
  });

  UploadItem copyWith({
    String? titleText,
    String? bodyText,
  }) {
    return UploadItem(
      titleText: titleText ?? this.titleText,
      bodyText: bodyText ?? this.bodyText,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title_text': titleText,
      'body_text': bodyText,
    };
  }

  factory UploadItem.fromJson(Map<String, dynamic> json) {
    return UploadItem(
      titleText: json['title_text'] as String?,
      bodyText: json['body_text'] as String?,
    );
  }

  @override
  String toString() => "UploadItem(titleText: $titleText,bodyText: $bodyText)";

  @override
  int get hashCode => Object.hash(titleText, bodyText);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UploadItem &&
          runtimeType == other.runtimeType &&
          titleText == other.titleText &&
          bodyText == other.bodyText;
}
