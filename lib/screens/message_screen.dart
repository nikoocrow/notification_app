import 'package:flutter/material.dart';

class Messagecreen extends StatelessWidget {
 

  

  @override
  Widget build(BuildContext context) {

    final  args = ModalRoute.of(context)?.settings.arguments ?? 'No data';

    return Scaffold(
      appBar: AppBar(
        title: Text('Messege Home'),
      ),
      body: Center(
        child: Text('$args', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}