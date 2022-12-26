import 'package:flutter/material.dart';
import 'package:kinoapp/movie_list_item.dart';
import './settings_page.dart';
import './get_data.dart';
import './movie_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: DefaultTabController(
        length: 15,
        child: HomePage(title: 'Kino App v0.1'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _hejterMode = false;
  bool _tenaMode = false;
  bool _isLoading = true;
  int _selectedTab = 0;

  List<String> _datumi = [];
  List<MovieListItem> _data = [];

  @override
  void initState() {
    _datumi = Data.getDatumi();
    Data.getData().then(
      (value) {
        _data = value;
        _setIsLoading();
      },
    );
    super.initState();
  }

  void _setData(data) {
    setState(() {
      _data = data;
    });
  }

  void _setSelectedTab(tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  void _setIsLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _setHejterMode(arg) {
    setState(() {
      _hejterMode = arg;
    });
  }

  void _setTenaMode(arg) {
    setState(() {
      _tenaMode = arg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: [
        IconButton(
          icon: Icon(
            Icons.settings,
          ),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SettingsPage(
                        setHejterMode: _setHejterMode,
                        hejterCheck: _hejterMode,
                      ))),
        )
      ]),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                ColoredBox(
                  color: Colors.green[200]!,
                  child: TabBar(
                    labelColor: Colors.black,
                    //onTap: (inx) => _setSelectedTab(inx),
                    onTap: (inx) {
                      var index = DefaultTabController.of(context)!.index;
                      DefaultTabController.of(context)!.animateTo(index);
                      _setSelectedTab(index);
                    },
                    isScrollable: true,
                    labelPadding: EdgeInsets.only(
                        top: 14, bottom: 14, left: 25, right: 25),
                    tabs: _datumi.map((e) => Text(e)).toList(),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: _datumi.map(
                      (e) {
                        var datum_id = e.substring(0, 6);
                        return MovieList(_data, datum_id, _hejterMode);
                      },
                    ).toList(),
                  ),
                ),
                // Container(
                //   height: 60,
                //   color: Colors.green[100]!,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Container(
                //             color: Colors.blue[400]!,
                //             child: SizedBox(
                //               height: 40,
                //               width: 40,
                //             ),
                //           ),
                //           Text('Tuškanac'),
                //         ],
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Container(
                //             color: Colors.amber[400]!,
                //             child: SizedBox(
                //               height: 40,
                //               width: 40,
                //             ),
                //           ),
                //           Text('Kinoteka'),
                //         ],
                //       ),
                //       !_hejterMode
                //           ? Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Container(
                //                   color: Colors.grey[400]!,
                //                   child: SizedBox(
                //                     height: 40,
                //                     width: 40,
                //                   ),
                //                 ),
                //                 Text('Cinestar'),
                //               ],
                //             )
                //           : SizedBox.shrink(),
                //     ],
                //   ),
                // ),
              ],
            ),
    );
  }
}
