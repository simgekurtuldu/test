import 'package:flutter/material.dart';
import 'package:test_app/widgets/widgets.dart';
import 'package:test_app/services/databes.dart';

class AddQuestion extends StatefulWidget {
  final String testId;
  AddQuestion(this.testId);
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;
  int index = 0;
  DatabaseService databaseService = DatabaseService();

  uploadQuestionData() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      Map<String, String> questionMap = {
        'question': question,
        'option1': option1,
        'option2': option2,
        'option3': option3,
        'option4': option4,
      };
      await databaseService.addQuestionData(questionMap, widget.testId).then((value) {
        setState(() {
          _isLoading = false;
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
        actions: [
          FlatButton(
              onPressed: () {
                setState(() {
                  index == 1 ? index = 0 : index = 1;
                });
              },
              child: Text(
                'Değiştir',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ))
        ],
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : index == 0
              ? Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) => val.isEmpty ? 'Soru girin' : null,
                          decoration: InputDecoration(
                            hintText: 'Soru',
                          ),
                          onChanged: (val) {
                            question = val;
                          },
                        ),
                        SizedBox(height: 6),
                        TextFormField(
                          validator: (val) => val.isEmpty ? '1. seçeneği girin' : null,
                          decoration: InputDecoration(
                            hintText: 'Seçenek1(Doğru cevap)',
                          ),
                          onChanged: (val) {
                            option1 = val;
                          },
                        ),
                        SizedBox(height: 6),
                        TextFormField(
                          validator: (val) => val.isEmpty ? '2. seçeneği girin' : null,
                          decoration: InputDecoration(
                            hintText: 'Seçenek2',
                          ),
                          onChanged: (val) {
                            option2 = val;
                          },
                        ),
                        SizedBox(height: 6),
                        TextFormField(
                          validator: (val) => val.isEmpty ? '3. seçeneği girin' : null,
                          decoration: InputDecoration(
                            hintText: 'Seçenek3',
                          ),
                          onChanged: (val) {
                            option3 = val;
                          },
                        ),
                        SizedBox(height: 6),
                        TextFormField(
                          //validator: (val) => val.isEmpty ? '4. seçeneği girin' : null,
                          decoration: InputDecoration(
                            hintText: 'Seçenek4',
                          ),
                          onChanged: (val) {
                            option4 = val;
                          },
                        ),
                        Spacer(),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: blueButton(context: context, text: 'Kaydet', buttonWidth: MediaQuery.of(context).size.width / 2 - 36)),
                            SizedBox(width: 24),
                            GestureDetector(
                                onTap: () {
                                  uploadQuestionData();
                                },
                                child: blueButton(context: context, text: 'Soru Ekle', buttonWidth: MediaQuery.of(context).size.width / 2 - 36)),
                          ],
                        ),
                        SizedBox(height: 60)
                      ],
                    ),
                  ),
                )
              : Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) => val.isEmpty ? 'Soru girin' : null,
                          decoration: InputDecoration(
                            hintText: 'Soru',
                          ),
                          onChanged: (val) {
                            question = val;
                          },
                        ),
                        SizedBox(height: 6),
                        TextFormField(
                          validator: (val) => val.isEmpty ? '1. seçeneği girin' : null,
                          decoration: InputDecoration(
                            hintText: '1. Seçenek(Doğru Cevap)',
                          ),
                          onChanged: (val) {
                            option1 = val;
                            option3 = null;
                            option4 = null;
                          },
                        ),
                        SizedBox(height: 6),
                        TextFormField(
                          validator: (val) => val.isEmpty ? '2. seçeneği girin' : null,
                          decoration: InputDecoration(
                            hintText: '2.Seçenek',
                          ),
                          onChanged: (val) {
                            option2 = val;
                          },
                        ),
                        Spacer(),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: blueButton(context: context, text: 'Kaydet', buttonWidth: MediaQuery.of(context).size.width / 2 - 36)),
                            SizedBox(width: 24),
                            GestureDetector(
                                onTap: () {
                                  uploadQuestionData();
                                },
                                child: blueButton(context: context, text: 'Soru Ekle', buttonWidth: MediaQuery.of(context).size.width / 2 - 36)),
                          ],
                        ),
                        SizedBox(height: 60)
                      ],
                    ),
                  ),
                ),
    );
  }
}
