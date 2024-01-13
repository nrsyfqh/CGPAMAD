import 'package:flutter/material.dart';
import 'package:cgpa_application/presentation/cgpa_screen/cgpa_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController semController = TextEditingController();
  late int n;

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
                  n = semController.text.isEmpty ? 0 : int.parse(semController.text);
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (n is int && n > 0) {
                  int pass = n;
                  n = 0;
                  semController.text = "";
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => CGPACalculate(pass),
                    ),
                  );
                } else {
                  semController.text = "";
                  _showAlert();
                }
              },
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
          title: Text('Please enter the number of semesters to calculate CGPA'),
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
}
