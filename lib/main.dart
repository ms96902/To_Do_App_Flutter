import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:to_do_app/authenticateScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Parse().initialize(
    'WfjdzBnO05J0IZUJnxYGuzLeFwxSPzL6GuQdOLuX',
    'https://parseapi.back4app.com',
    clientKey: 'gvfkPecAafusH6MSPBq7qkbrafSgcTqJsgAV2iuE',
    autoSendSessionId: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickTask',
      home: AuthenticationScreen(),
    );
  }
}
