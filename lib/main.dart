import 'package:flutter/material.dart';
import 'package:rechord/locator.dart';
import 'package:rechord/screens/record_page.dart';
import 'package:provider/provider.dart';
import 'package:rechord/services/record_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecordService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RECHORD',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RecordPage(),
      ),
    );
  }
}
