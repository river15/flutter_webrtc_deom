import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as flutterWebRtc;
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc_deom/web_rtc/rtc_util.dart';
import 'package:get/get.dart';

class WebRtcBySrsWidget extends StatefulWidget {
  const WebRtcBySrsWidget({super.key});


  @override
  State<WebRtcBySrsWidget> createState() => WebRtcBySrsWidgetState();
}

class WebRtcBySrsWidgetState extends State<WebRtcBySrsWidget> {
  WebRtcController webRtcController = Get.put(WebRtcController());


  /// 添加远程webrtc流
  addRemoteWebRtc() {
    webRtcController.addRemoteLive(
      "webrtc://huawei.siqianginfo.com/live/wsy1",
      callback: (res) {
        debugPrint("$res");
      },
    );
  }


  /// 关闭拉流
  closeLocal() async {
    var rtc = webRtcController.rtcList[0];
    if (rtc['slef'] == false) {
      return;
    }

    await webRtcController.closeRenderId(rtc['renderId']);
    setState(() {});
  }

  /// 关闭所有
  Future<void> _stop() async {
    webRtcController.close();
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
              () => webRtcController.rtcList.isNotEmpty ? RTCVideoView(
              webRtcController.rtcList[0]['renderer'],
              objectFit:
              RTCVideoViewObjectFit.RTCVideoViewObjectFitCover) : const Text("当前无数据"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addRemoteWebRtc();
        },
        tooltip: '关闭拉流',
        child: const Icon(Icons.close),
      ),
    );
  }


  @override
  void dispose() {
    _stop();
    super.dispose();
  }
}
