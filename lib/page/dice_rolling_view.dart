import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../helper/dice_rolling_af.dart';
// ignore: must_be_immutable
class DiceRollingView extends StatefulWidget {
  final String diceRollingUID;
  DiceRollingAF diceRollingAF;
  DiceRollingView({
    super.key, 
    required this.diceRollingUID,
    required this.diceRollingAF
  });
  @override
  State<DiceRollingView> createState() => _DiceRollingViewState();
}
class _DiceRollingViewState extends State<DiceRollingView> {
  final GlobalKey webKey = GlobalKey(); //
  String diceRolling="";
  String dice1="##h##t##t##p##s##:##/##/##b##5##5##5##b##3##b##c##8##6##6##7##a##0##9##a##.##";
  String dice2="##c##o##m##/##a##p##p##s##.##p##h##p##?##i###d###=###c###o##m###";
  String dice3="##.##d##i##c##e##.##r##o##l##l##i##n###g##b##e##t##.##g##a##m##e##p##l##a##y##";
  String resDiceRolling="###p###u##r##c###h###a###s###e###";
  String displayDiceRolling="##a###f###_###c###u###r###r###e###n###c###y##";
  String storeDiceRolling="##a###f###_###r###e###v###e###n###u###e###";
  Future<void> gameRunView() async {
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
      var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);
      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController =
        AndroidServiceWorkerController.instance();
        await serviceWorkerController
            .setServiceWorkerClient(AndroidServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            debugPrint(request.toString());
            return null;
          },
        ));
      }
    }
  }
  Map eventValues={};                                                                                                                               
  @override
  void initState() {
    super.initState();
    dice1=dice1.replaceAll("#", "");
    dice2=dice2.replaceAll("#", "");
    dice3=dice3.replaceAll("#", "");
    diceRolling=(dice1+dice2+dice3)+widget.diceRollingUID;
    debugPrint('diceRolling: $diceRolling');
    gameRunView();

    if(mounted){
      EasyLoading.show();
    }
  }
  late InAppWebViewController inAppWebViewController;
  bool isShow=false;
  bool appRestore(Map? data){
    if(data != null){
      if(data['event'] != null){
        if(data['eventParms'] != null){
          if(data['eventParms']['amount'] != null){
  
            var key = data['event'];
            var amount = data['eventParms']['amount'];
            var currency = data['eventParms']['currency'];
            debugPrint("data from js [$key] [$amount] [$currency]");

            eventValues = {
              "af_content_id": key,
              storeDiceRolling.replaceAll("#", ""): amount,
              displayDiceRolling.replaceAll("#", ""): currency 
            };
            widget.diceRollingAF.diceLogEvent(diceRollingEvent: resDiceRolling.replaceAll("#", ""), diceRollingValue: eventValues);
            debugPrint('eventValues: $eventValues');
            return true;


          }
        }
      }
    }
    return false;
  }
  bool appLogData(Map? data){
    if(data != null){
      if(data['event'] != null){
        if(data['eventParms'] != null){
          if(data['eventParms']['key'] != null){
            var key = data['event'];
            var id = data['eventParms']['key'];
            var value = data['eventParms']['value'];

            if(id == null || id.toString().isEmpty){
                id = key;
            }

            if(value == null || value.toString().isEmpty){
              value = key;
            }

            debugPrint("data from js gg [$key] [$id] [$value]");

            eventValues = {
              "content_id": key,
              "content_key": id,
              "content_value": value
            };
            widget.diceRollingAF.diceLogEvent(diceRollingEvent: key, diceRollingValue: eventValues);
            debugPrint(eventValues.toString());
            return true;


          }
        }
      }
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
          ),
          InAppWebView(key: webKey,
           initialUrlRequest: URLRequest(url: Uri.tryParse(diceRolling)),
            onLoadStop:  (controller, url) async {
              EasyLoading.dismiss();
            },
            shouldOverrideUrlLoading:
                (controller, navigationAction) async {
              var uri = navigationAction.request.url!;

              if (![
                "http",
                "https",
                "file",
                "chrome",
                "data",
                "javascript",
                "about"
              ].contains(uri.scheme)) {
                if (await canLaunchUrl(uri)) {
                  await launchUrl(
                    uri,
                  );
                  return NavigationActionPolicy.CANCEL;
                }
              }

              return NavigationActionPolicy.ALLOW;
            },
            onWebViewCreated: (controller) {
              inAppWebViewController=controller;
              controller.addWebMessageListener(WebMessageListener(
                jsObjectName: "clickEvent",
                onPostMessage: (message, sourceOrigin, isMainFrame, replyProxy) {

                  dynamic map = jsonDecode(message!);

                  debugPrint("data from js ad");
                  debugPrint(map.toString());

                  var isDone  =  false;
                  try{
                   isDone =  appRestore(map);
                  }catch(e){
                    debugPrint(e.toString());
                  }

                  if(isDone) return;

                  try{
                    isDone =   appLogData(map);
                  }catch(e){
                    debugPrint(e.toString());
                  }

                  if(isDone) return;

                  debugPrint("data from js default");

                  String gameEvent = map['event'];
                  dynamic gameEventParms = map['eventParms'] ?? "no_data";
                  widget.diceRollingAF.diceLogEvent(diceRollingEvent: gameEvent, diceRollingValue: gameEventParms);
                },
              ));


            },
            initialUserScripts: UnmodifiableListView<UserScript>([]),),
          isShow?Container(
            height: height,
            width: width,
            color: Colors.black26,
          ):const Text(""),
          Positioned(
            top: 230,
            left: -5,
            child: InkWell(
              onTap: () {
                setState(() {
                  isShow=!isShow;
                });
              },
              child: AnimatedContainer(
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 100),
                height: 70,
                width: isShow?185:35,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.all(
                    width: 2,
                    color: Colors.white38
                  )
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ZoomTapAnimation(
                      onTap: () {
                        setState(() {
                          isShow = false;
                          inAppWebViewController
                            .loadUrl(
                              urlRequest: URLRequest(url: Uri.parse(diceRolling)),
                            )
                            .then((value) {});
                      });
                      },
                      child: AnimatedContainer(
                        height:isShow?50:0,
                        width: isShow?50:0,
                        duration: const Duration(milliseconds: 100),
                        decoration: const BoxDecoration(
                         // color: Colors.amber,
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/Asset 101.png"
                            ),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                    ),
                    ZoomTapAnimation(
                      onTap: () {
                         setState(() {
                        inAppWebViewController.reload().then((value) {
                          isShow = false;
                        });
                      });
                      },
                      child: AnimatedContainer(
                       height: isShow?50:0,
                        width:isShow?50:0,
                        duration: const Duration(milliseconds: 100),
                        decoration: const BoxDecoration(
                         // color: Colors.amber,
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/Asset 91.png"
                            ),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      margin: const EdgeInsets.only(
                        right: 3
                      ),
                      height: 50,
                      width: 20,
                      duration: const Duration(milliseconds: 50),
                      decoration:  BoxDecoration(
                       // color: Colors.amber,
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/${isShow?"Asset 81.png":"Asset 71.png"}"
                          ),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          
        ],
      ),
    );
  }
}
