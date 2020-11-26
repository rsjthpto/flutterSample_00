import 'importer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 35),
            color: Colors.greenAccent,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/Input');
              },
              child: Text(
                'input',
                style: Styles.mainStyle,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 35),
            color: Colors.greenAccent,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/Sample');
              },
              child: Text(
                'sample',
                style: Styles.mainStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
