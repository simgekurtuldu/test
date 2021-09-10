import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/views/create_test.dart';
import 'package:test_app/services/databes.dart';
import 'package:test_app/views/play_test.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream testStream;
  DatabaseService databaseService = DatabaseService();

  Widget testList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: StreamBuilder(
        stream: testStream,
        builder: (context, streamSnapshot) {
          return streamSnapshot.data == null
              ? Container()
              : ListView.builder(
                  itemCount: streamSnapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return TestTile(
                      title: streamSnapshot.data.docs[index]['testTitle'],
                      desc: streamSnapshot.data.docs[index]['testDesc'],
                      testId: streamSnapshot.data.docs[index]['testId'],
                    );
                  });
        },
      ),
    );
  }

  @override
  initState() {
    databaseService.getTestsData().then((val) {
      setState(() {
        testStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TESTLER'),
        backgroundColor: Color(0XFF494EC9),
        elevation: 0.0,
        brightness: Brightness.dark,
      ),
      body: testList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0XFF494EC9),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTest()));
        },
      ),
    );
  }
}

class TestTile extends StatelessWidget {
  final String title;
  final String desc;
  final String testId;
  TestTile({@required this.title, @required this.desc, @required this.testId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PlayTest(testId, title)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 140,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://images.unsplash.com/photo-1460602594182-8568137446ce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1955&q=80',
                width: MediaQuery.of(context).size.width - 20,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.black26),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500)),
                  SizedBox(height: 6),
                  Text(desc, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
