import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Carando peliculas',
      'Comprando palomitas',
      'llamando a mi novia',
      'tardando mucho....',
    ];
    return Stream.periodic(Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espero por favor'),
          SizedBox(height: 10),
          CircularProgressIndicator(strokeWidth: 2),
          SizedBox(height: 10),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('cargando');
              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}
