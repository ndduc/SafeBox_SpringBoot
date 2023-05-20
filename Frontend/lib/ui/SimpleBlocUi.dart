import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc/CounterBloc.dart';
import '../bloc/event/CounterEvent.dart';
import 'SecondScreen.dart';
import 'menu/MainMenu.dart';


class SimpleBlocUi extends StatefulWidget {
  @override
  _SimpleBlocUi createState() => _SimpleBlocUi();
}

class _SimpleBlocUi extends  State<SimpleBlocUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, int>(
              builder: (context, count) {
                return Text(
                  'Count: $count',
                  style: TextStyle(fontSize: 24),
                );
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(IncrementEvent());
                  },
                  child: Text('Increment'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(DecrementEvent());
                  },
                  child: Text('Decrement'),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _navigateToSecondScreen,
              child: Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }


  void _navigateToSecondScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainMenu()),
    );
  }

}