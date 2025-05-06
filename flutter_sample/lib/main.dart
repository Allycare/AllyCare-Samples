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
          url: WebUri(
              'https://allycare-app.rootally.com/?accessToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiItT1A5LTF3NHpHN3RxQ0JPeTRzNyIsImhvc3BpdGFsSWQiOiJrWmswRWV2TEIyUlZDOWpQbkkzUk16MDVPQ1gyIiwiZW1haWwiOiJkZWJtYWx5YUByb290YWxseS5jb20iLCJ1c2VybmFtZSI6IkRlYm1hbHlhIiwiYWdlIjowLCJjcmVhdGlvblRpbWVzdGFtcCI6MTc0NjUxMzgxODk2NCwiYXV0b1NpZ25JbiI6dHJ1ZSwiaW9zX2RlZXB2aWV3IjpmYWxzZSwicGxhdGZvcm0iOiJ3ZWJiIiwiaW9zX3Bhc3NpdmVfZGVlcHZpZXciOmZhbHNlLCIkZmFsbGJhY2tfdXJsIjoiaHR0cHM6Ly9hbGx5Y2FyZS1hcHAucm9vdGFsbHkuY29tLyIsIiR3ZWJfb25seSI6dHJ1ZSwiY29tcG9uZW50SWRzIjpbImFzX2ZzXzAxIl0sInNob3dPbmx5QXNzZXNzbWVudEV4ZXJjaXNlcyI6dHJ1ZSwicmVkaXJlY3Rpb25MaW5rIjpudWxsLCJhZGRpdGlvbmFsUGF5bG9hZCI6e30sInRva2VuSWQiOiIzZDIzOTM5MC1lNzllLTQ2NTQtOTQwMS01MjFkNzE5ZDBhNzIiLCJ0b2tlblVzZXJJZCI6Ii1PUDktMXc0ekc3dHFDQk95NHM3IiwiaWF0IjoxNzQ2NTEzODE4LCJleHAiOjE3NDY2MDAyMTh9.U-Ki6Dk73juf2uAIArRTq3baHBmuhtXeifl1u6AY_kM'),
        ),
        initialSettings: InAppWebViewSettings(
          mediaPlaybackRequiresUserGesture: false,
          allowsInlineMediaPlayback: true,
          iframeAllow: 'camera *',
        ),
        onConsoleMessage: (controller, consoleMessage) {
          print("KDEBUG:: CONSOLE MESSAGE:: ${consoleMessage.message}");
        },
        onPermissionRequest: (controller, request) async {
          final resources = <PermissionResourceType>[];
          if (request.resources.contains(PermissionResourceType.CAMERA)) {
            final cameraStatus = await Permission.camera.request();
            if (!cameraStatus.isDenied) {
              resources.add(PermissionResourceType.CAMERA);
            }
          }
          if (request.resources.contains(PermissionResourceType.MICROPHONE)) {
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

  void camPermissionDenied() {
    print("KDEBUG:: CAMERA PERMISSION DENIED");
  }
}
