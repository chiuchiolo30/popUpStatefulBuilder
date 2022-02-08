


import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PopUp StatefulBuilder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'PopUp StatefulBuilder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<void>(
            context: context, 
            builder: (context) {
              int options = 0;
              return StatefulBuilder(
                builder: (context, setState) {
                  return FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: AlertDialog(
                      scrollable: true,
                      actionsAlignment: MainAxisAlignment.center,
                      title: const _Title(),
                      content: _Content(options: options),
                      actions: _buttons(options, setState, context),
                    ),
                  );
                },
              );
            }
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> _buttons(int options, StateSetter setState, BuildContext context) {
    return [
      OutlinedButton(
        onPressed: () {
          if (options<3) {
            setState(() => options++);
          } else {
            setState(() => options = 0);
          }
        },
        child: const Text('ENTREGAR')
      ),
      OutlinedButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('CANCELAR')
      ),
    ];
  }

}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text:const TextSpan(
        children: [
           TextSpan(
            text: 'ENTREGAR PEDIDO\n',
            style: TextStyle(color: Colors.black)
          ),
           TextSpan(
            text:'#1234567899854-12' ,
            style: TextStyle(color: Colors.black, fontSize: 22.0)
          ),
        ]
      )
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
    required this.options,
  }) : super(key: key);

  final int options;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: Center(
        child: options == 0 
          ? const _Principal()
          : options == 1
          ? const _Cargando()
          : options == 2
          ? const _Success()
          : const _Failed(),
      )
    );
  }
}

class _Failed extends StatelessWidget {
  const _Failed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BounceInLeft(
      duration: const Duration(seconds: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeIn(
            delay: const Duration(milliseconds: 700),
            child: const Icon(Icons.clear, size: 60.0, color: Colors.red,)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('FALLO LA ENTREGA'),
            ],
          ),
        ],
      )
    );
  }
}

class _Success extends StatelessWidget {
  const _Success({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BounceInRight(
      duration: const Duration(seconds: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeIn(
            delay: const Duration(milliseconds: 700),
            child: const Icon(Icons.check, size: 60.0, color: Colors.green,)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
               Text('ENTREGA EXITOSA'),
            ],
          ),
        ],
      )
    );
  }
}

class _Cargando extends StatelessWidget {
  const _Cargando({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(seconds: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
           const CircularProgressIndicator(),
           const SizedBox(height: 10.0,),
           BounceInLeft(child: const Text('ENTREGANDO...', style: TextStyle(color: Colors.black, letterSpacing: 2.0), ))
        ],
      ),
    );
  }
}

class _Principal extends StatelessWidget {
  const _Principal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeOut(
      duration: const Duration(seconds: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          const Divider(height: 0.0, color: Colors.black),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('COMPRADOR', style: TextStyle(fontSize: 12.0)),
                Text('Sergio Edgardo, Chiuchiolo'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [
                    Text('DNI', style: TextStyle(fontSize: 12.0),),
                    Text('24519852'),
                  ],
                ),
                Column(
                  children: const [
                    Text('TELEFONO', style: TextStyle(fontSize: 12.0),),
                    Text('3815684753'),
                  ],
                ),
              ],
            ),
          ),
          const DecoratedBox(
            decoration:  BoxDecoration(
              color: Colors.red,
            ),
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Text('BULTOS: 2', style: TextStyle(fontWeight: FontWeight.bold) ),
            ),
          ),
        ],
      ),
    );
  }
}
