import 'package:flutter/material.dart';
import 'api_service.dart';
import 'crypto.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Prices',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CryptoList(),
    );
  }
}

class CryptoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Prices'),
      ),
      body: Center(
        child: FutureBuilder<List<Crypto>>(
          future: fetchCryptos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].symbol),
                    trailing: Text("\$${snapshot.data![index].priceUsd.toStringAsFixed(2)}"),
                  );
                },
              );
            } else {
              return Text("No data found");
            }
          },
        ),
      ),
    );
  }
}
