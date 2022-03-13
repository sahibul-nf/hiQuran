// import 'dart:developer';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:get/get.dart';

// class AudioPlayerController extends GetxController {
//   // for state of playing Audio
//   var isPlay = false.obs;
//   void setPlay(bool value) {
//     isPlay.value = value;
//   }

//   var audioPlayer = AudioPlayer();
//   var playerState = PlayerState.STOPPED.obs;
//   var duration = 0.obs;

//   play({required List<String> url}) async {
//     for (var i = 0; i < url.length; i++) {
//       int result = await audioPlayer.play(url[i]);
//       if (result == 1) {
//         fetchDuration();
//         setPlay(true);
//         // Get.snackbar("Waahh", "Successfully playing audio");
//       } else {
//         Get.snackbar("Opps", "Failed playing audio");
//       }
//       await Future.delayed(Duration(milliseconds: duration.value + 500));
//     }
//   }

//   // changeState() {
//   //   audioPlayer.onPlayerStateChanged.listen((event) {
//   //     playerState.value = event;
//   //     print(playerState.value);
//   //   });
//   // }

//   fetchDuration() async {
//     duration.value = await audioPlayer.getDuration();
//     audioPlayer.onDurationChanged.listen((event) {
//       log(event.inMilliseconds.toString());
//     });
//   }

//   stop() async {
//     int result = await audioPlayer.stop();
//     if (result == 1) {
//       setPlay(false);
//     }
//   }
// }
