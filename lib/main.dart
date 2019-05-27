import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sfleet_provider/pages/notifications_page.dart';

import 'scoped_models/main.dart';
import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();

  @override
  void initState() {
    _model.auth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        title: 'S·fleet Provider',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (BuildContext context) => ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model) {
            return model.user == null ? LoginPage() : DashboardPage(userData: _model.user);
          }),
          '/dashboard': (BuildContext context) => DashboardPage(userData: _model.user),
        }
      )
    );
    // return ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model) {
    //   return model.user == null ? LoginPage() : DashboardPage(userData: _model.user);
    // });
  }
}
