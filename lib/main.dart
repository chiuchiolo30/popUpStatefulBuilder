// import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popup_statefull/bloc/option_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OptionBloc())
      ], 
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PopUp Bloc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'PopUp Bloc'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _options = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text('Presione el botón + para abrir el popup'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<void>(
            barrierDismissible: false,
              context: context,
              builder: (context) {
                return BlocBuilder<OptionBloc, OptionState>(
                  builder: (context, state) {
                    return FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: AlertDialog(
                        scrollable: true,
                        actionsAlignment: MainAxisAlignment.center,
                        title: const _Title(),
                        content: _Content(options: state.option),
                        actions: state.option == 0
                            ? _buttons(state.option, context)
                            : state.option != 1
                                ? _salir(context)
                                : [],
                      ),
                    );
                  },
                );
              });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> _buttons(int options, BuildContext context) {
    return [
      OutlinedButton(
          onPressed: () => BlocProvider.of<OptionBloc>(context).add(ChangeOption()),
          child: const Text('ENTREGAR')),
      OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCELAR')),
    ];
  }

  List<Widget> _salir(BuildContext context) {
    return [
      Row(
        children: [
          Expanded(
            child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  BlocProvider.of<OptionBloc>(context).add(StateInitial());
                },
                child: const Text('ACEPTAR')),
          ),
        ],
      ),
    ];
  }
}

class _Title extends StatelessWidget {
  const _Title() : super();

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(children: [
          TextSpan(
              text: 'ENTREGAR PEDIDO\n', style: TextStyle(color: Colors.black)),
          TextSpan(
              text: '#1234567899854-12',
              style: TextStyle(color: Colors.black, fontSize: 22.0)),
        ]));
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.options}) : super();

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
        ));
  }
}

class _Failed extends StatelessWidget {
  const _Failed() : super();

  @override
  Widget build(BuildContext context) {
    return BounceInLeft(
        duration: const Duration(seconds: 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeIn(
                delay: const Duration(milliseconds: 700),
                child: const Icon(
                  Icons.clear,
                  size: 60.0,
                  color: Colors.red,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('FALLO LA ENTREGA'),
              ],
            ),
          ],
        ));
  }
}

class _Success extends StatelessWidget {
  const _Success() : super();

  @override
  Widget build(BuildContext context) {
    return BounceInRight(
        duration: const Duration(seconds: 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeIn(
                delay: const Duration(milliseconds: 700),
                child: const Icon(
                  Icons.check,
                  size: 60.0,
                  color: Colors.green,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('ENTREGA EXITOSA'),
              ],
            ),
          ],
        ));
  }
}

class _Cargando extends StatelessWidget {
  const _Cargando() : super();

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(seconds: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            height: 10.0,
          ),
          BounceInLeft(
              child: const Text(
            'ENTREGANDO...',
            style: TextStyle(color: Colors.black, letterSpacing: 2.0),
          ))
        ],
      ),
    );
  }
}

class _Principal extends StatelessWidget {
  const _Principal() : super();

  @override
  Widget build(BuildContext context) {
    return FadeOut(
      duration: const Duration(seconds: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    Text(
                      'DNI',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Text('24519852'),
                  ],
                ),
                Column(
                  children: const [
                    Text(
                      'TELEFONO',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Text('3815684753'),
                  ],
                ),
              ],
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Text('BULTOS: 2',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
