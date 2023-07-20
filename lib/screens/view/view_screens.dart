import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/screens/view/viewdata_cubit.dart';

import '../model/musictext.dart';

class ViewScreens extends StatefulWidget {
  final String musicTextData;
  final String imageData;
  const ViewScreens(
      {Key? key, required this.musicTextData, required this.imageData})
      : super(key: key);

  @override
  State<ViewScreens> createState() => _ViewScreensState();
}

class _ViewScreensState extends State<ViewScreens> {
  // formatTime(int seconds) {
  //   return "${(Duration(seconds: seconds))}".split('.')[0].padLeft(8, '0');
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.purple,
      body: BlocBuilder<ViewDataCubit, ViewDataState>(
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    height: size.height * 0.15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: () {
                          Navigator.of(context).pop();
                        }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                         const Center(
                            child: Text(
                              "Now playing",
                              style: TextStyle(fontSize: 20.0, color: Colors.white),
                            )),
                        IconButton(onPressed: () {

                        }, icon: const Icon(Icons.more_vert,color: Colors.white,))
                      ],
                    ),
                  ),
                ),

                Container(
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: const Color(0xffE79FAB),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.08),
                    child: Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundImage: AssetImage(state.imageName),
                            radius: 120.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 20.0, top: 30.0, end: 20.0, bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.audioText,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              IconButton(onPressed: () {

                              }, icon: const Icon(Icons.favorite_border))
                            ],
                          ),
                        ),
                        Slider(
                          min: 0.0,
                          max: state.duration.inSeconds.toDouble() + 1.0,
                          value: state.position.inSeconds.toDouble().isNaN ==
                                      true ||
                                  state.position.inSeconds.toDouble() == null
                              ? 0
                              : state.position.inSeconds.toDouble(),
                          activeColor: Colors.purple,
                          inactiveColor: Colors.purple.shade200,
                          thumbColor: Colors.pink,
                          onChanged: (double value) {
                            setState(() {
                              final position = Duration(seconds: value.toInt());
                              state.audioPlayer.seek(position);
                              value = value;
                            });
                          },
                        ),
                        Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(state.position.toString().split(".")[0]),
                              Text(state.duration.toString().split(".")[0]),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if(state.isSelected==true){
                                    state.isSelected=!state.isSelected;
                                    context.read<ViewDataCubit>().repeatButton();
                                  }
                                },
                                icon: Image.asset('assets/image/repeat.png',
                                    color: state.color),
                              ),
                              IconButton(
                                  onPressed: () => context
                                      .read<ViewDataCubit>()
                                      .skipPreviousButton(),
                                  icon: const Icon(
                                    Icons.fast_rewind,
                                    size: 35.0,
                                    color: Colors.purple,
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Container(
                                  height: size.height * 0.07,
                                  width: size.width * 0.15,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.purple),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        state.isPlaying
                                            ? context
                                                .read<ViewDataCubit>()
                                                .pushButton()
                                            : state.isPaused
                                                ? context
                                                    .read<ViewDataCubit>()
                                                    .resumeButton()
                                                : context
                                                    .read<ViewDataCubit>()
                                                    .playButton();
                                      },
                                      icon: Center(
                                        child: Icon(
                                          state.isPlaying
                                              ? Icons.pause_circle_filled
                                              : Icons.play_circle_outline,
                                          size: 35.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () => context
                                      .read<ViewDataCubit>()
                                      .skipNextButton(),
                                  icon: const Icon(
                                    Icons.fast_forward,
                                    size: 35.0,
                                    color: Colors.purple,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    if(state.isSelected == false){
                                      state.isSelected=!state.isSelected;
                                      context
                                          .read<ViewDataCubit>()
                                          .shuffleButton();
                                    }

                                  },
                                  icon: Image.asset(
                                    "assets/image/play.png",color: state.colors,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
