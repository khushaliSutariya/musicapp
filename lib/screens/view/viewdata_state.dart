part of 'viewdata_cubit.dart';

class ViewDataState extends Equatable {
  AudioPlayer audioPlayer;
  bool isPlaying;
  bool isPaused;
  bool isRepeat;
  bool isSelected;
  bool isShuffle;
  List<dynamic> audioList;
  List imageList;
  int index;
  String imageName;
  String audioText;
  List<MusicText> musicText;
  Duration duration;
  Duration position;
  Color color;
  Color colors;
  int timestoPlay;

  ViewDataState(
      {required this.audioPlayer,
      required this.isPlaying,
      required this.isPaused,
        required this.isShuffle,
      required this.audioList,
      required this.imageList,
      required this.index,
      required this.imageName,
      required this.musicText,
      required this.isRepeat,
      required this.audioText,
      required this.duration,
      required this.isSelected,
      required this.position,
      required this.color,
      required this.colors,
      required this.timestoPlay});

  @override
  List<Object?> get props => [
        audioPlayer,
        isPlaying,
        isPaused,
        audioList,
        imageList,
        colors,
        index,
        imageName,
        musicText,
        audioText,
        duration,
        position,
        isRepeat,isShuffle,
        color,
        isSelected,
        timestoPlay
      ];

  ViewDataState copyWith({
    AudioPlayer? audioPlayer,
    bool? isPlaying,
    bool? isPaused,
    bool? isRepeat,
    bool? isSelected,
    bool? isShuffle,
    List<dynamic>? audioList,
    List? imageList,
    int? index,
    String? imageName,
    String? audioText,
    List<MusicText>? musicText,
    Duration? duration,
    Duration? position,
    Color? color,
    Color? colors,
    int? timestoPlay,
  }) {
    return ViewDataState(
      audioPlayer: audioPlayer ?? this.audioPlayer,
      isPlaying: isPlaying ?? this.isPlaying,
      isPaused: isPaused ?? this.isPaused,
      isRepeat: isRepeat ?? this.isRepeat,
      isSelected: isSelected ?? this.isSelected,
      isShuffle: isShuffle ?? this.isShuffle,
      audioList: audioList ?? this.audioList,
      imageList: imageList ?? this.imageList,
      index: index ?? this.index,
      imageName: imageName ?? this.imageName,
      audioText: audioText ?? this.audioText,
      musicText: musicText ?? this.musicText,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      color: color ?? this.color,
      colors: colors ?? this.colors,
      timestoPlay: timestoPlay ?? this.timestoPlay,
    );
  }
}
