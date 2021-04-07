// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:provider_counter/state.dart';
import 'package:provider_counter/theme.dart';

import 'blank_page.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        Provider(create: (context) => PersonalModel('', '')),
        Provider(create: (context) => Api()),
        ProxyProvider<Api, SomeModel>(
            update: (context, api, somemodel) => SomeModel(api))
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/blank': (context) => BlankPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proviเด้อออออออออออ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Consumer<CounterProvider>(
              builder: (context, counter, child) => Text(
                'counter : ${counter.value}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            MyCustomForm(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/blank');
              },
              child: Text('Go to next'),
            ),
            Consumer<SomeModel>(
              builder: (context, model, child) => ElevatedButton(
                onPressed: () {
                  final snackBar = SnackBar(
                    content: Text('with comsumer : ${model.api.callApi}'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text('Call api consumer'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/blank', (route) => false);
              },
              child: Text('Go to next (destroy this page)'),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomSpeedDial(
        Key('custom-speed-dial'),
      ),
    );
  }
}

class CustomSpeedDial extends StatefulWidget {
  CustomSpeedDial(Key key) : super(key: key);

  @override
  _CustomSpeedDialState createState() => _CustomSpeedDialState();
}

class _CustomSpeedDialState extends State<CustomSpeedDial> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: Colors.yellow,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.yellow,
            onTap: () {
              context.read<CounterProvider>().increment();
            },
            label: 'Add',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16.0),
            labelBackgroundColor: Colors.yellow),
        // FAB 2
        SpeedDialChild(
            child: Icon(Icons.remove),
            backgroundColor: Colors.yellow,
            onTap: () {
              context.read<CounterProvider>().clear();
            },
            label: 'Clear',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16.0),
            labelBackgroundColor: Colors.yellow)
      ],
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Name',
            ),
            onChanged: (text) {
              Provider.of<PersonalModel>(context, listen: false).name = text;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Surname',
            ),
            onChanged: (text) {
              context.read<PersonalModel>().surname = text;
            },
          ),
        ),
      ],
    );
  }
}
