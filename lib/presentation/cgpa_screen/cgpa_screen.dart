import 'package:flutter/material.dart';
import 'package:cgpa_application/presentation/cgpa_screen/ResultPage.dart';

class CGPACalculate extends StatefulWidget {
  final int n;

  CGPACalculate(this.n);

  @override
  _GPAcalculateState createState() => _GPAcalculateState();
}

class _GPAcalculateState extends State<CGPACalculate> {
  late List<TextEditingController> _sgpaController;
  late List<TextEditingController> _creditController;
  late List list;

  @override
  void initState() {
    super.initState();

    _sgpaController = List.generate(widget.n, (index) => TextEditingController());
    _creditController = List.generate(widget.n, (index) => TextEditingController());

    list = List<int>.generate(widget.n, (i) => i);
  }

  @override
  Widget build(BuildContext context) {
    double sumOfCreditMulSGPA = 0, sumOfCredit = 0;
    double cgpa = 0.0;
    var fields = <Widget>[];
    bool insertedValue = true;

    list.forEach((i) {
      fields.add(
        Row(
          children: [
            Text(
              "Semester ${i + 1}:",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _sgpaController[i],
                decoration: InputDecoration(
                  hintText: "SGPA",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _creditController[i],
                decoration: InputDecoration(
                  hintText: "CREDIT",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("GPA Calculator"),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
      ),
      backgroundColor: Colors.orange[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              "SGPA",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent, width: 30.0),
              ),
              child: Column(
                children: fields,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                for (int i = 0; i < widget.n; i++) {
                  if (_creditController[i].text.isEmpty ||
                      _sgpaController[i].text.isEmpty) {
                    insertedValue = false;
                    continue;
                  }

                  double sgpa = double.parse(_sgpaController[i].text);
                  int credit = int.parse(_creditController[i].text);

                  double creditMulSGPA = credit * sgpa;
                  sumOfCreditMulSGPA += creditMulSGPA;
                  sumOfCredit += credit;
                }
                cgpa = sumOfCreditMulSGPA / sumOfCredit;

                if (insertedValue == true)
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => ResultPage(cgpa),
                    ),
                  );
                else {
                  showAlertBox();
                }
              },
              child: Text(
                "Calculate CGPA",
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAlertBox() {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please enter values for all semesters to calculate'),
          actions: <Widget>[
            TextButton(
              child: Icon(Icons.clear),
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
