import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'scoped_models/main.dart';
import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        title: 'S·fleet Provider',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MainModel _model = MainModel();

  @override
  void initState() {
    _model.auth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model) {
      return model.user == null ? LoginPage() : DashboardPage(userData: _model.user);
    });
  }
}
