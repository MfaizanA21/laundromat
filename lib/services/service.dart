import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Services extends StatelessWidget {
  const Services({super.key});

  Future<List<dynamic>> fetchShops() async {
    if (kDebugMode) {
      print("inside fetchShops");
    }
    final response = await http.get(Uri.parse('http://localhost:8000/api/get-shops'));
    if (response.statusCode == 200) {
      List<dynamic> shops = jsonDecode(response.body);
      if (kDebugMode) {
        print(shops);
      }
      return shops;
    } else {
      throw Exception('Failed to load shops');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Services',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Center(
              child: Text(
                'Find Your Laundromat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 4)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 46.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: 'Choose Laundromat',
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 4)),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: fetchShops(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No laundromats found'));
                } else {
                  List<dynamic> shops = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 26.0),
                    itemCount: shops.length,
                    itemBuilder: (context, index) {
                      var shop = shops[index];
                      return Card(
                        child: ListTile(
                          title: Text(shop['shopName'] ?? 'Unknown Laundromat'),
                          subtitle: Text(shop['address'] ?? 'No address available'),
                          trailing: Text(shop['status'] ?? 'Status unknown'),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
