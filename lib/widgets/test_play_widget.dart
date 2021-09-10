import 'package:flutter/material.dart';

class TestPlayWidget extends StatefulWidget {
  final String option, desc, correctAnswer, optionSelected;
  TestPlayWidget({@required this.option, @required this.desc, @required this.correctAnswer, @required this.optionSelected});
  @override
  _TestPlayWidgetState createState() => _TestPlayWidgetState();
}

class _TestPlayWidgetState extends State<TestPlayWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.desc == widget.optionSelected
                        ? widget.optionSelected == widget.correctAnswer
                            ? Colors.green.withOpacity(0.7)
                            : Colors.red.withOpacity(0.7)
                        : Colors.grey,
                    width: 1.4),
                borderRadius: BorderRadius.circular(30)),
            alignment: Alignment.center,
            child: Text(
              widget.option,
              style: TextStyle(
                  color: widget.optionSelected == widget.desc
                      ? widget.correctAnswer == widget.optionSelected
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red
                      : Colors.grey),
            ),
          ),
          SizedBox(width: 8),
          Text(widget.desc, style: TextStyle(fontSize: 16, color: Colors.black54))
        ],
      ),
    );
  }
}
