import 'package:flutter/material.dart';
import 'package:test_app/widgets/widgets.dart';
import 'package:random_string/random_string.dart';
import 'package:test_app/services/databes.dart';
import 'package:test_app/views/add_question.dart';

class CreateTest extends StatefulWidget {
  @override
  _CreateTestState createState() => _CreateTestState();
}

class _CreateTestState extends State<CreateTest> {
  final _formKey = GlobalKey<FormState>();
  String testImgUrl, testTitle, textDescription, testId;
  DatabaseService databaseService = DatabaseService();
  bool _isLoading = false;
  createTest() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      testId = randomAlphaNumeric(16);
      Map<String, String> testMap = {
        'testId': testId,
        'testTitle': testTitle,
        'testDesc': textDescription,
      };
      await databaseService.addTestData(testMap, testId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestion(testId)));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0XFF494EC9),
        elevation: 0.0,
        brightness: Brightness.dark,
      ),
      body: _isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: 6),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Test başlığı girin' : null,
                      decoration: InputDecoration(
                        hintText: 'Test başlığı',
                      ),
                      onChanged: (val) {
                        testTitle = val;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Test açıklaması girin' : null,
                      decoration: InputDecoration(
                        hintText: 'Test açıklaması',
                      ),
                      onChanged: (val) {
                        textDescription = val;
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          createTest();
                        },
                        child: blueButton(context: context, text: 'OLUŞTUR')),
                    SizedBox(height: 60)
                  ],
                ),
              ),
            ),
    );
  }
}
