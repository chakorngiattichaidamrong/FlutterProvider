import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_counter/state.dart';

// coverage:ignore-start
class BlankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var personalState1 = Provider.of<PersonalModel>(context, listen: false);
    var personalState2 = context.watch<PersonalModel>();

    var someModelState = Provider.of<SomeModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Blank page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer2<CounterProvider, PersonalModel>(
              builder: (context, counter, personal, child) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('counter:${counter.value}'),
                  Text('name :${personal.name}'),
                  Text('surname_with_consumer:${personal.surname}'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('surname_with_provier.of: ${personalState1.surname}'),
            ),
            Text('surname_with_context.watch: ${personalState2.surname}'),
            ElevatedButton(
              onPressed: () {
                final snackBar = SnackBar(
                  content:
                      Text('with provider.of : ${someModelState.api.callApi}'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('Call api provider.of'),
            ),
          ],
        ),
      ),
    );
  }
}
