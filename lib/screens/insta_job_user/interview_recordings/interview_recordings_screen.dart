import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_job/model/chat_model.dart';
import 'package:insta_job/screens/chat_screen.dart';
import 'package:insta_job/utils/app_routes.dart';
import 'package:insta_job/utils/my_colors.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_app_bar.dart';
import 'package:video_player/video_player.dart';

class InterviewRecordingsScreen extends StatefulWidget {
  const InterviewRecordingsScreen({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  State<InterviewRecordingsScreen> createState() => _InterviewRecordingsScreenState();
}

class _InterviewRecordingsScreenState extends State<InterviewRecordingsScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  var position = Duration.zero;
  var position2 = Duration.zero;
  var isMaximized = true;
  var duration = Duration.zero;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _controller = VideoPlayerController.networkUrl(
      // Uri.parse("https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8")
      Uri.parse("https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.mp4/.m3u8"),
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    // Use the controller to loop the video
    _controller.setLooping(true);

    _controller.addListener(updateSeeker); //revisit abebe
  }

  
  Future<void> updateSeeker() async {
    final newPosition = _controller.value.position;
    if (newPosition != position) {
      setState(() {
        position = newPosition;
      });
    }
  }

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void dispose() {
    _controller.removeListener(updateSeeker);
    _controller.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: CustomAppBar(
          title: "",
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var duration = _controller.value.duration;
            debugPrint("LOGGGG: duration => ${_controller.value.duration} ${duration}");
            debugPrint("LOGGGG: position => ${_controller.value.position} ${position}");
            debugPrint("================================");
            
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: _controller.value.isInitialized
                        ? Stack(
                          children: [
                            isMaximized ?
                            VideoPlayer(
                              _controller,
                            ) : AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(
                                _controller,
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              right: 8,
                              child: Container(
                                color: Colors.white.withOpacity(0.7),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isMaximized = !isMaximized;
                                    });
                                  },
                                  child: Icon(
                                    isMaximized ? Icons.fullscreen_exit_outlined : Icons.fullscreen_outlined,
                                  ),
                                                            ),
                              ),
                            )
                          ],
                        )
                        : Container(),
                  ),
                ),
                Container(
                color: MyColors.lightBlack,
                padding: const EdgeInsets.fromLTRB(24, 10, 24, 30),
                child: SizedBox(
                  child: Column(
                    children: [
                      Slider(
                        min: 0,
                        max: _controller.value.duration.inSeconds.toDouble(),
                        onChanged: (val) {
                          position2 = Duration(seconds: val.toInt());
                          setState(() {
                            _controller.seekTo(position2);
                            _controller.play();
                            
                          });

                        },
                        value: position2.inSeconds.toDouble(),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              if (_controller.value.isPlaying) {
                                setState(() {
                                  _controller.pause();
                                });
                              } else {
                                setState(() {
                                  _controller.play();
                                });
                              }
                            },
                            child: SvgPicture.asset(
                              _controller.value.isPlaying ? MyImages.recordingPauseBtn : MyImages.recordingPlayBtn,
                              height: 18,
                            ),
                          ),
                          const SizedBox(width: 14),
                          InkWell(
                            onTap: () async {
                              _controller.seekTo(_controller.value.position - const Duration(seconds: 15));
                            //           // await _controller
                            //           //     .seekTo((await _controller.position) - Duration(seconds: 10));
                            //           await _controller
                            //               .seekTo((await _controller.position.then((value) {
                            //                 return value! - const Duration(seconds: 10);
                            //               })));
                              // _controller.play();
                            },
                            child: SvgPicture.asset(
                              MyImages.recordingSeekBackBtn,
                              height: 18,
                            ),
                          ),
                          const SizedBox(width: 14),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _controller.seekTo(_controller.value.position + const Duration(seconds: 15));
                                // _controller.play();
                              });
                            },
                            child: SvgPicture.asset(
                              MyImages.recordingSeekForwardBtn,
                              height: 18,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Text("${formatTime(position.inSeconds)} / ${formatTime(duration.inSeconds)}",style: TextStyle(color: MyColors.white),),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                            },
                            child: SvgPicture.asset(
                              MyImages.recordingHistoryBtn,
                              height: 26,
                            ),
                          ),
                          const SizedBox(width: 14),
                          InkWell(
                            onTap: () {
                              // AppRoutes.push(
                              //   context,
                              //   ChatScreen(
                              //     chatModel: widget.chatModel,
                              //   ),
                              // );
                            },
                            child: SvgPicture.asset(
                              MyImages.recordingRecruiterMsgBtn,
                              height: 26,
                            ),
                          ),
                          const SizedBox(width: 14),
                          InkWell(
                            onTap: () {
                            },
                            child: SvgPicture.asset(
                              MyImages.recordingTranscriptionBtn,
                              height: 26,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ],
            );

          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      ),
    );
  }
}