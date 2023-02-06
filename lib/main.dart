import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:stripe/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Get any initial links
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();

  runApp(MyApp(initialLink: initialLink));
}

class MyApp extends StatefulWidget {
  final PendingDynamicLinkData? initialLink;
  const MyApp({Key? key, required this.initialLink}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? path;

  @override
  initState() {
    if (widget.initialLink != null) {
      path = widget.initialLink!.link!.path;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Book Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(path: path));
  }
}
