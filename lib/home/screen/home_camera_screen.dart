import 'package:audioplayers/audioplayers.dart';
import 'package:beautyblock_app/utils.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../../config.dart';

class HomeCameraScreen extends StatefulWidget {
  HomeCameraScreen({
    super.key,
  });

  @override
  State<HomeCameraScreen> createState() => _HomeCameraScreenState();
}

class _HomeCameraScreenState extends State<HomeCameraScreen>
    with SingleTickerProviderStateMixin {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool isRecording = false;
  AnimationController? _animationController;
  Animation<double>? _opacityAnimation;
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    initCamera();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController!);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/images/ic_back_arrow.png',
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.black12,
        title: Text(
          '카메라',
          style: AppTheme.appBarTextStyle.copyWith(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black12,
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                    width: Get.width,
                    height: Get.height,
                    child: FadeTransition(
                        opacity: _opacityAnimation!,
                        child: CameraPreview(_controller!)));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.3),
              height: Get.height * 0.2,
              child: DefaultTabController(
                  length: 2,
                  child: Column(children: [
                    TabBar(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * 0.01),
                        labelPadding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: GlobalBeautyColor.middleBlack,
                        indicator: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(175, 175, 175, 1)))),
                        unselectedLabelColor: GlobalBeautyColor.middleBlack,
                        unselectedLabelStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'NotoSans',
                            fontSize: 17),
                        labelColor: Color.fromRGBO(175, 175, 175, 1),
                        labelStyle: TextStyle(fontWeight: FontWeight.w700),
                        tabs: [
                          Tab(
                            text: "사진",
                          ),
                          Tab(
                            text: "비디오",
                          ),
                        ]),
                    Expanded(
                        child: TabBarView(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: IconButton(
                              color: Colors.white,
                              iconSize: Get.height * 0.06,
                              icon: Icon(Icons.camera_alt),
                              onPressed: !isRecording ? _takePicture : null,
                            ),
                          ),
                        ),
                        Center(
                          child: IconButton(
                            color: Colors.red.shade700,
                            iconSize: Get.height * 0.07,
                            icon: Icon(isRecording
                                ? Icons.stop_circle
                                : Icons.radio_button_checked),
                            onPressed: isRecording
                                ? _stopVideoRecording
                                : _startVideoRecording,
                          ),
                        ),
                      ],
                    )),
                  ])),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller?.initialize();
    setState(() {});
  }

  void _takePicture() async {
    try {
      _animationController?.forward(from: 0.0).then((_) {
        _animationController!.reverse();
      });
      await _initializeControllerFuture;
      await audioPlayer.play(AssetSource('sounds/camera_shutter.mp3'));

      final image = await _controller!.takePicture();
      await ImageGallerySaver.saveFile(image.path);
    } catch (e) {
      print(e);
    }
  }

  void _startVideoRecording() async {
    try {
      Fluttertoast.showToast(msg: '촬영을 시작합니다.', gravity: ToastGravity.CENTER);
      audioPlayer.play(AssetSource('sounds/camera_recording_start.mp3'));
      await _initializeControllerFuture;
      await _controller!.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } catch (e) {
      print(e);
    }
  }

  void _stopVideoRecording() async {
    try {
      Fluttertoast.showToast(msg: '촬영을 종료합니다.', gravity: ToastGravity.CENTER);
      audioPlayer.play(AssetSource('sounds/camera_recording_end.mp3'));
      await _initializeControllerFuture;
      final video = await _controller!.stopVideoRecording();
      setState(() {
        isRecording = false;
      });
      await ImageGallerySaver.saveFile(video.path);
      print('Video saved to ${video.path}');
    } catch (e) {
      print(e);
    }
  }
}
