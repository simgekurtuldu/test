import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/models/test_model.dart';
import 'package:test_app/services/databes.dart';
import 'package:test_app/views/results.dart';
import 'package:test_app/widgets/test_play_widget.dart';

class PlayTest extends StatefulWidget {
  final String testId;
  final String testTitle;
  PlayTest(this.testId, this.testTitle);
  @override
  _PlayTestState createState() => _PlayTestState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _PlayTestState extends State<PlayTest> {
  QuerySnapshot questionsSnapshot;
  DatabaseService databaseService = DatabaseService();
  TestModel getTestModelFromDatasnapshot(DocumentSnapshot questionSnapshot) {
    TestModel testModel = TestModel();
    testModel.question = questionSnapshot["question"];

    List<String> options = [
      questionSnapshot['option1'],
      questionSnapshot['option2'],
      questionSnapshot['option3'],
      questionSnapshot['option4'],
    ];
    options.shuffle();
    testModel.option1 = options[0];
    testModel.option2 = options[1];
    testModel.option3 = options[2];
    testModel.option4 = options[3];
    testModel.correctOption = questionSnapshot['option1'];
    testModel.answered = false;
    return testModel;
  }

  @override
  void initState() {
    databaseService.getTestData(widget.testId).then((value) {
      questionsSnapshot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = questionsSnapshot.docs.length;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.testTitle),
        backgroundColor: Color(0XFF494EC9),
        elevation: 0.0,
        brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              questionsSnapshot == null
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return TestPlay(
                          testModel: getTestModelFromDatasnapshot(questionsSnapshot.docs[index]),
                          index: index,
                        );
                      },
                      itemCount: questionsSnapshot.docs.length,
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0XFF494EC9),
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Results(
                        correct: _correct,
                        incorrect: _incorrect,
                        total: total,
                      )));
        },
      ),
    );
  }
}

class TestPlay extends StatefulWidget {
  final TestModel testModel;
  final int index;
  TestPlay({this.testModel, this.index});
  @override
  _TestPlayState createState() => _TestPlayState();
}

class _TestPlayState extends State<TestPlay> {
  String optionSelected = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "-${widget.index + 1} ${widget.testModel.question}",
            style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              if (!widget.testModel.answered) {
                if (widget.testModel.option1 == widget.testModel.correctOption) {
                  optionSelected = widget.testModel.option1;
                  widget.testModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                  setState(() {});
                } else {
                  optionSelected = widget.testModel.option1;
                  widget.testModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: widget.testModel.option1 == null
                ? Container()
                : TestPlayWidget(
                    correctAnswer: widget.testModel.correctOption,
                    desc: "${widget.testModel.option1}",
                    option: '',
                    optionSelected: optionSelected,
                  ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.testModel.answered) {
                if (widget.testModel.option2 == widget.testModel.correctOption) {
                  optionSelected = widget.testModel.option2;
                  widget.testModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                  setState(() {});
                } else {
                  optionSelected = widget.testModel.option2;
                  widget.testModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: widget.testModel.option2 == null
                ? Container()
                : TestPlayWidget(
                    correctAnswer: widget.testModel.correctOption,
                    desc: "${widget.testModel.option2}",
                    option: '',
                    optionSelected: optionSelected,
                  ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.testModel.answered) {
                if (widget.testModel.option3 == widget.testModel.correctOption) {
                  optionSelected = widget.testModel.option3;
                  widget.testModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                  setState(() {});
                } else {
                  optionSelected = widget.testModel.option3;
                  widget.testModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: widget.testModel.option3 == null
                ? Container()
                : TestPlayWidget(
                    correctAnswer: widget.testModel.correctOption,
                    desc: "${widget.testModel.option3}",
                    option: '',
                    optionSelected: optionSelected,
                  ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.testModel.answered) {
                if (widget.testModel.option4 == widget.testModel.correctOption) {
                  optionSelected = widget.testModel.option4;
                  widget.testModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                  setState(() {});
                } else {
                  optionSelected = widget.testModel.option4;
                  widget.testModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: widget.testModel.option4 == null
                ? Container()
                : TestPlayWidget(
                    correctAnswer: widget.testModel.correctOption,
                    desc: "${widget.testModel.option4}",
                    option: '',
                    optionSelected: optionSelected,
                  ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
