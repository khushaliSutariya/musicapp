
class MusicText{
  String text;
  String subText;
  MusicText({required this.text,required this.subText});

  MusicText copyWith({
    String? text,
    String? subText,
  }) {
    return MusicText(
      text: text ?? this.text,
      subText: subText ?? this.subText,
    );
  }
}