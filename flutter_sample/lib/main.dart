import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AllyCare WebView Integration',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri('https://allycare-app.rootally.com/'),
        ),
        initialSettings: InAppWebViewSettings(
          mediaPlaybackRequiresUserGesture: false,
          allowsInlineMediaPlayback: true,
          iframeAllow: 'camera *',
        ),
        onPermissionRequest: (controller, request) async {
          final resources = <PermissionResourceType>[];
          if (request.resources.contains(PermissionResourceType.CAMERA)) {
            final cameraStatus = await Permission.camera.request();
            if (!cameraStatus.isDenied) {
              resources.add(PermissionResourceType.CAMERA);
            }
          }
          if (request.resources
              .contains(PermissionResourceType.MICROPHONE)) {
            final microphoneStatus = await Permission.microphone.request();
            if (!microphoneStatus.isDenied) {
              resources.add(PermissionResourceType.MICROPHONE);
            }
          }
          // only for iOS and macOS
          if (request.resources
              .contains(PermissionResourceType.CAMERA_AND_MICROPHONE)) {
            final cameraStatus = await Permission.camera.request();
            final microphoneStatus = await Permission.microphone.request();
            if (!cameraStatus.isDenied && !microphoneStatus.isDenied) {
              resources.add(PermissionResourceType.CAMERA_AND_MICROPHONE);
            }
          }

          return PermissionResponse(
              resources: resources,
              action: resources.isEmpty
                  ? PermissionResponseAction.DENY
                  : PermissionResponseAction.GRANT);
        },
      ),
    );
  }
}
