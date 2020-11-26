import 'importer.dart';

class Input extends StatefulWidget {
  Input({Key key}) : super(key: key);

  @override
  createState() => _InputState();
}

class _InputState extends State<Input> {
  String outline;
  TextEditingController controller;
  String category;
  String priority;

  @override
  void initState() {
    controller = new TextEditingController(text: '');
    category = '';
    priority = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 70, 30, 5),
        color: Colors.lightBlueAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: controller,
              style: Styles.subStyle,
              decoration: InputDecoration(
                hintText: 'outline',
                hintStyle: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 25,
                  fontWeight: FontWeight.w200,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
              autocorrect: true,
              keyboardType: TextInputType.text,
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  outline = value;
                });
              },
            ),
            OutlineButton(
              onPressed: _categoryPressed,
              borderSide: BorderSide(color: Colors.lightBlueAccent),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'category    ' + category,
                  style: Styles.subStyle,
                ),
              ),
            ),
            OutlineButton(
              onPressed: _priorityPressed,
              borderSide: BorderSide(color: Colors.lightBlueAccent),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'priority       ' + priority,
                  style: Styles.subStyle,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                ),
                OutlineButton(
                  borderSide: BorderSide(color: Colors.lightBlueAccent),
                  child: Text(
                    'save',
                    style: Styles.subStyle,
                  ),
                  onPressed: _writePressed,
                  highlightColor: Colors.black38,
                  highlightElevation: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                OutlineButton(
                  borderSide: BorderSide(color: Colors.lightBlueAccent),
                  child: Text(
                    'end',
                    style: Styles.subStyle,
                  ),
                  onPressed: _donePressed,
                  highlightColor: Colors.black38,
                  highlightElevation: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _categoryPressed() {
    showModalBottomSheet(
      context: this.context,
      builder: (BuildContext context) => Column(
        children: <Widget>[
          Text(
            'category select',
            style: Styles.subStyle,
          ),
          Padding(
            padding: EdgeInsets.all(20),
          ),
          FlatButton(
            onPressed: () => Navigator.pop<String>(context, 'test1'),
            child: Text(
              '1',
              style: Styles.modalStyle,
            ),
          ),
          FlatButton(
            onPressed: () => Navigator.pop<String>(context, 'test2'),
            child: Text(
              '2',
              style: Styles.modalStyle,
            ),
          ),
        ],
      ),
      //);
    ).then<void>((value) => categoryResult(value));
  }

  void categoryResult(String value) {
    setState(() {
      category = '$value';
    });
  }

  void _priorityPressed() {
    showModalBottomSheet(
      context: this.context,
      builder: (BuildContext context) => DraggableScrollableSheet(
        initialChildSize: 1,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'priority select',
                  style: Styles.subStyle,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                FlatButton(
                  onPressed: () => Navigator.pop<String>(context, 'A'),
                  child: Text(
                    'A',
                    style: Styles.modalStyle,
                  ),
                ),
                FlatButton(
                  onPressed: () => Navigator.pop<String>(context, 'B'),
                  child: Text(
                    'B',
                    style: Styles.modalStyle,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ).then<void>((value) => priorityResult(value));
  }

  void priorityResult(String value) {
    setState(() {
      priority = '$value';
    });
  }

  //②WriteToDo_body_メソッド類
  void _writePressed() {
    if (outline == '' ||
        category == '' ||
        priority == '') {
      showDialog(
        context: this.context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'please input all',
            style: Styles.subStyle,
          ),
          content: OutlineButton(
            borderSide: BorderSide(color: Colors.white),
            child: Text(
              'ok',
              style: Styles.smallerStyle,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } else {
      saveData();
      guide();
    }
  }


  void saveData() async {
    String path = join(await getDatabasesPath(), 'data.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE IF NOT EXISTS data(id INTEGER PRIMARY KEY, outline TEXT, category TEXT, priority TEXT)");
        });

    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO data(outline, category, priority) VALUES(?, ?, ?)',[outline, category, priority]);
    });

    setState(() {
      controller.text = '';
    });
  }

  void guide() {
    showDialog(
      context: this.context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'saved',
          style: Styles.subStyle,
        ),
        content: Text(
          'input next?',
          style: Styles.subStyle,
        ),
        actions: <Widget>[
          OutlineButton(
            borderSide: BorderSide(color: Colors.white),
            child: Text(
              'no',
              style: Styles.smallerStyle,
            ),
            onPressed: () {
              //Navigator.pop(context);
              Navigator.pushNamed(this.context, '/Sample');
            },
          ),
          OutlineButton(
            borderSide: BorderSide(color: Colors.white),
            child: Text(
              'yes',
              style: Styles.smallerStyle,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _donePressed() {
    if (outline == '' &&
        category == '' &&
        priority == '') {
      Navigator.pushNamed(this.context, '/Sample');
    } else {
      showDialog(
        context: this.context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'this is not saved, ok?',
            style: Styles.subStyle,
          ),
          actions: <Widget>[
            OutlineButton(
              borderSide: BorderSide(color: Colors.white),
              child: Text(
                'no',
                style: Styles.smallerStyle,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            OutlineButton(
              borderSide: BorderSide(color: Colors.white),
              child: Text(
                'ok',
                style: Styles.smallerStyle,
              ),
              onPressed: () {
                Navigator.pushNamed(this.context, '/Sample');
              },
            ),
          ],
        ),
      );
    }
  }
}