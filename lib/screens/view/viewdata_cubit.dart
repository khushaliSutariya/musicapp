import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../model/musictext.dart';
part 'viewdata_state.dart';

class ViewDataCubit extends Cubit<ViewDataState> {
  ViewDataCubit()
      : super(ViewDataState(
            audioPlayer: AudioPlayer(),
            isPlaying: false,
            isPaused: false,
            isRepeat: false,
            isSelected: false,
            isShuffle: false,
            duration: Duration.zero,
            position: Duration.zero,
            imageName: "assets/image/i_love_you.jpg",
            color: Colors.purple,
            colors: Colors.purple,
            index: 0,
            timestoPlay: 3,
            audioText: "I_love_you",
            musicText: [
              MusicText(text: "I_love_you", subText: 'Love'),
              MusicText(text: "Pehli_Dafa", subText: 'Love'),
              MusicText(text: "Rabb manneya", subText: 'Isk'),
              MusicText(text: "Saathi re", subText: 'Sath'),
            ],
            audioList: const [
              "audiofile/i_love_you.mp3",
              "audiofile/Pehli_Dafa.mp3",
              "audiofile/rabb_manneya.mp3",
              "audiofile/saathi_re.mp3"
            ],
            imageList: const [
              "assets/image/i_love_you.jpg",
              "assets/image/pehli_dafa.jpg",
              "assets/image/rab_maneya.jpg",
              "assets/image/sathi_re.jpg",
            ])) {
    audioSliderData();
  }

  audioSliderData() {
    state.audioPlayer.onPlayerStateChanged.listen((event) {
      emit(state.copyWith(isPlaying: event == PlayerState.playing));
    });

    state.audioPlayer.onDurationChanged.listen((newDuration) {
      emit(state.copyWith(duration: newDuration));
    });
    state.audioPlayer.onPositionChanged.listen((newPosition) {
      emit(state.copyWith(position: newPosition));
    });
    state.audioPlayer.onPlayerComplete.listen((event) {
      state.position = const Duration(seconds: 0);
      if (state.isRepeat == true ) {
        state.isPlaying = true;
      } else {
        state.isPlaying = false;
        state.isRepeat = false;
      }
    });


  }

  repeatButton() {
    if (state.isRepeat == false) {
      state.audioPlayer.setReleaseMode(ReleaseMode.loop);
      emit(state.copyWith(isRepeat: true,
          // color: Colors.blue
      ));
    } else if (state.isRepeat == true) {
      state.audioPlayer.setReleaseMode(ReleaseMode.release);
      // state.color = Colors.purple;
      state.isRepeat = false;
    }
  }

  shuffleButton() {
      state.audioPlayer.play(AssetSource(state.audioList[state.index])).then((player) {
        state.audioPlayer.onPlayerComplete.listen((event) {
          state.index++;
          if (state.index >= state.timestoPlay) {
            state.index = 0;
            state.audioPlayer.stop();
          } else {
            state.audioPlayer.resume();
          }
          setAudioImage(state.index);
          setAudioText(state.index);
          // emit(state.copyWith(colors: Colors.blue));
        });
      });
    }


  skipNextButton() async {
    if (state.index < state.audioList.length - 1) {
      state.index++;
      state.audioPlayer.play(AssetSource(state.audioList[state.index]));
    } else {
      state.index = 0;
      state.audioPlayer.play(AssetSource(state.audioList[state.index]));
    }
    setAudioImage(state.index);
    setAudioText(state.index);
  }

  skipPreviousButton() async {
    if (state.index > 0) {
      state.index--;
      state.audioPlayer.play(AssetSource(state.audioList[state.index]));
    } else {
      state.index = state.audioList.length - 1;
      state.audioPlayer.play(AssetSource(state.audioList[state.index]));
    }
    setAudioImage(state.index);
    setAudioText(state.index);
  }

  setAudioImage(index) {
    emit(state.copyWith(
      imageName: state.imageList[index],
    ));
  }

  setAudioText(index) {
    emit(state.copyWith(audioText: state.musicText[index].text));
  }

  playButton() {
    state.audioPlayer.play(AssetSource(state.audioList[state.index]));
    emit(state.copyWith(
      isPlaying: true,
    ));
    print("Play");
  }

  pushButton() {
    state.audioPlayer.pause();
    emit(state.copyWith(
      isPlaying: false,
    ));

    print("push");
  }

  resumeButton() {
    state.audioPlayer.resume();
    emit(state.copyWith(
      isPaused: true,
    ));

    print("push");
  }
}
