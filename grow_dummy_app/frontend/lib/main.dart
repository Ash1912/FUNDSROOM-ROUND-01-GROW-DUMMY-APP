import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Groww Investment Dashboard',
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List investments = [];

  @override
  void initState() {
    super.initState();
    fetchInvestments();
  }

  fetchInvestments() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/portfolio/1'));
    if (response.statusCode == 200) {
      setState(() {
        investments = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load investments');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Investment Dashboard'),
      ),
      body: ListView.builder(
        itemCount: investments.length,
        itemBuilder: (context, index) {
          final investment = investments[index];
          return ListTile(
            title: Text(investment['name']),
            subtitle: Text('Current Value: ${investment['current_value']}'),
            trailing: Text(
              investment['current_value'] > investment['initial_value']
                  ? 'Gains'
                  : 'Losses',
              style: TextStyle(
                color: investment['current_value'] > investment['initial_value']
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
