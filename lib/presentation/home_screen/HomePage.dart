// home_page.dart

import 'package:cgpa_application/controller/sqlitedb.dart';
import 'package:flutter/material.dart';
import 'package:cgpa_application/presentation/cgpa_screen/cgpa_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController semController = TextEditingController();
  int? n;
  late DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    await databaseHelper.initializeDatabase();
  }

  @override
  void dispose() {
    databaseHelper.closeDatabase();
    super.dispose();
  }

  void _calculateCGPA() {
    if (n != null && n! > 0) {
      int pass = n!;
      n = null;
      semController.text = "";

      // Save the number of semesters to the SQLite database
      saveSemestersToDatabase(pass);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            // Pass null or any value you need for n
            var n2 = null;
            return CGPACalculate(pass, n: n2);
          },
        ),
      );
    } else {
      semController.text = "";
      _showAlert();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CGPA Calculator"),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0, // Remove app bar shadow
      ),
      backgroundColor: Colors.orange[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              autofocus: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.lightBlueAccent,
                hintText: "Enter number of semesters",
                hintStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
              controller: semController,
              onChanged: (String str) {
                setState(() {
                  n = int.tryParse(semController.text);
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateCGPA,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Calculate CGPA",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please enter a valid number of semesters to calculate CGPA'),
          actions: <Widget>[
            TextButton(
              child: Icon(Icons.clear, size: 40.0),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> saveSemestersToDatabase(int semesters) async {
    await databaseHelper.saveSemestersToDatabase(semesters);
  }
}
