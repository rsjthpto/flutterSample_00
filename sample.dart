import 'importer.dart';

class Sample extends StatefulWidget {
  Sample({Key key}) : super(key: key);

  @override
  createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  String outline;
  String category;
  String priority;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<List<Map>> getData() async {
    String path = join(await getDatabasesPath(), 'data.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE IF NOT EXISTS data(id INTEGER PRIMARY KEY, outline TEXT, category TEXT, priority TEXT)");
    });

    List<Map> result = await database.rawQuery('SELECT * FROM data');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map>>(
        future: getData(),
        builder: (context, result) {
          if (result.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!result.hasData) {
            return Center(
              child: Text(
                'no data',
                style: Styles.smallerStyle,
              ),
            );
          }
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(30),
              color: Colors.lightGreenAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  result.data.length, (index) {
                    var data = result.data[index];
                    outline = data['outline'];
                    category = data['category'];
                    priority = data['priority'];
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 25, 0, 0),
                            ),
                            Container(
                              child: Text(
                                category,
                                style: Styles.modalStyle,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                            ),
                            Container(
                              child: Text(
                                priority,
                                style: Styles.modalStyle,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 30),
                            child: Text(
                              outline,
                              style: Styles.modalStyle,
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
