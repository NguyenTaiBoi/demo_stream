import 'package:flutter/material.dart';
import 'package:stream_demo/my_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  MyBloc bloc =new MyBloc();
  @override
  void dispose() {
    // TODO: implement dispose
    bloc.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    bloc.counterStream.listen((data) {
      print(data.toString());
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Container(
              child: StreamBuilder(
                stream: bloc.counterStream,
                builder: (context,snapshot)=>Text(
                  snapshot.hasData?snapshot.data.toString():"0",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          bloc.increase();
          bloc.counterStream.listen((data) {
            print(data.toString());
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
