import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import "dart:math";
import 'package:lottie/lottie.dart';
// import 'package:animated_theme_switcher/animated_theme_switcher.dart';

// import 'package:flushbar/flushbar.dart';

// import './widgets/user_transactions.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

// void main() => runApp(MyApp());

void main() {
  runApp(MyApp());
  //this below line will not allow user to use landscap mode :)
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

var thisContext;

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.system);
  var isDark;
  @override
  Widget build(BuildContext context) {
    thisContext = context;
    if (ThemeMode.system == ThemeMode.dark) {
      isDark = true;
    } else {
      isDark = false;
    }
    print('at start $isDark');

    //test starts
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _notifier,
      builder: (_, mode, __) {
        void themeChanger() {
          // _notifier.value =
          //     mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
          _notifier.value = !isDark ? ThemeMode.dark : ThemeMode.light;
          if (isDark) {
            isDark = false;
          } else {
            isDark = true;
          }
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Personal Expenses',
          home: MyHomePage(themeChanger, isDark),
          theme: ThemeData(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    fontSize: 20,
                  ),
                  button: TextStyle(
                    color: Colors.white,
                  ),
                ),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
            primarySwatch: Colors.purple,
            primaryColorDark: Colors.white,
            accentColor: Colors.amber,
            errorColor: Colors.red,
            fontFamily: 'Quicksand',
            backgroundColor: Colors.white,
          ),
          darkTheme: ThemeData(
            textTheme: ThemeData.dark().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.87),
                    fontSize: 20,
                  ),
                  button: TextStyle(
                    color: Color(0xff3c3534),
                  ),
                ),
            appBarTheme: AppBarTheme(
              color: Color(0xff272727),
              textTheme: ThemeData.dark().textTheme.copyWith(
                    headline6: TextStyle(
                      color: Color(0xffFFFFFF).withOpacity(.87),
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
            primarySwatch: Colors.purple,
            primaryColorDark: Color(0xff443a36),
            accentColor: Colors.amber.withOpacity(0.5),
            errorColor: Color(0xfffc3c1c).withOpacity(0.7),
            fontFamily: 'Quicksand',
            primaryColor: Color(0xfffdba78),
            backgroundColor: Colors.white.withOpacity(0.5),
            cardColor: Color(0xff202020),
            scaffoldBackgroundColor: Color(0xff121212),
            bottomSheetTheme:
                BottomSheetThemeData(backgroundColor: Color(0xff443a36)),
          ),
          themeMode: mode,
        );
      },
    );
    //test ends

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Personal Expenses',
    //   home: MyHomePage(),
    //   theme: ThemeData(
    //     textTheme: ThemeData.light().textTheme.copyWith(
    //           headline6: TextStyle(
    //             fontFamily: 'Quicksand',
    //             fontWeight: FontWeight.bold,
    //             color: Colors.purple,
    //             fontSize: 20,
    //           ),
    //           button: TextStyle(
    //             color: Colors.white,
    //           ),
    //         ),
    //     appBarTheme: AppBarTheme(
    //       textTheme: ThemeData.light().textTheme.copyWith(
    //             headline6: TextStyle(
    //               fontFamily: 'OpenSans',
    //               fontSize: 20,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //     ),
    //     primarySwatch: Colors.purple,
    //     primaryColorDark: Colors.white,
    //     accentColor: Colors.amber,
    //     errorColor: Colors.red,
    //     fontFamily: 'Quicksand',
    //     backgroundColor: Colors.white,
    //   ),
    //   darkTheme: ThemeData(
    //     textTheme: ThemeData.dark().textTheme.copyWith(
    //           headline6: TextStyle(
    //             fontFamily: 'Quicksand',
    //             fontWeight: FontWeight.bold,
    //             color: Colors.white.withOpacity(0.87),
    //             fontSize: 20,
    //           ),
    //           button: TextStyle(
    //             color: Color(0xff3c3534),
    //           ),
    //         ),
    //     appBarTheme: AppBarTheme(
    //       color: Color(0xff272727),
    //       textTheme: ThemeData.dark().textTheme.copyWith(
    //             headline6: TextStyle(
    //               color: Color(0xffFFFFFF).withOpacity(.87),
    //               fontFamily: 'OpenSans',
    //               fontSize: 20,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //     ),
    //     primarySwatch: Colors.purple,
    //     primaryColorDark: Color(0xff443a36),
    //     accentColor: Colors.amber.withOpacity(0.5),
    //     errorColor: Color(0xfffc3c1c).withOpacity(0.7),
    //     fontFamily: 'Quicksand',
    //     primaryColor: Color(0xfffdba78),
    //     backgroundColor: Colors.white.withOpacity(0.5),
    //     cardColor: Color(0xff202020),
    //     scaffoldBackgroundColor: Color(0xff121212),
    //     bottomSheetTheme:
    //         BottomSheetThemeData(backgroundColor: Color(0xff443a36)),
    //   ),
    //   themeMode: ThemeMode.dark,
    // );
  }
}

class MyHomePage extends StatefulWidget {
  final isDark;
  // final DateFormat formatter = DateFormat('dd-MM-yyyy');

  // late String titleInput;
  // late String amountInput;

  // final titleController = TextEditingController();
  // final amountController = TextEditingController();
  final Function themeChanger;
  MyHomePage(this.themeChanger, this.isDark);
  @override
  _MyHomePageState createState() => _MyHomePageState(isDark);
}

class _MyHomePageState extends State<MyHomePage> {
  var isDark;
  _MyHomePageState(this.isDark);
//imported code starts
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't3',
    //   title: 'Starbucks Coffee',
    //   amount: 11.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't4',
    //   title: 'Oreo Biscuits',
    //   amount: 7.69,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't5',
    //   title: 'Tomato Ketchup',
    //   amount: 31.57,
    //   date: DateTime.now(),
    // ),
  ];

  String getRandomAnimation() {
    var listOfAnimations = [
      'https://assets4.lottiefiles.com/packages/lf20_rqes9zyp.json',
      'https://assets4.lottiefiles.com/packages/lf20_u70phlit.json',
      'https://assets4.lottiefiles.com/packages/lf20_id5yltov.json',
      'https://assets4.lottiefiles.com/packages/lf20_yvwcdrrw.json'
    ];
    // return math.randomChoice(listOfAnimations);
    final _random = new Random();
    String randomAnimation =
        listOfAnimations[_random.nextInt(listOfAnimations.length)];
    return randomAnimation;
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: 't${(_userTransactions.length + 1).toString()}');

    setState(() {
      _userTransactions.add(newTx);
    });
  }
  //imported code ends

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            // padding: MediaQuery.of(context).viewInsets,
            child: GestureDetector(
              onTap: () {}, //will do nothing when we tap on the sheet.
              behavior: HitTestBehavior
                  .opaque, //wont close sheet when we tap on the sheet.

              child:
                  (MediaQuery.of(context).orientation != Orientation.portrait)
                      ? SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            decoration: new BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(25.0),
                                topRight: const Radius.circular(25.0),
                              ),
                            ),
                            child: Wrap(direction: Axis.horizontal, children: [
                              NewTransaction(
                                _addNewTransaction,
                              ),
                              if (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: (Lottie.network(
                                    getRandomAnimation(),
                                    // height: 200,
                                    // width: 200,
                                    // onLoaded: (composition) {
                                    //   _controller
                                    //     ..duration = composition.duration
                                    //     ..reset()
                                    //     ..repeat();
                                    // },
                                  )),
                                )
                            ]),
                          ),
                        )
                      : Container(
                          decoration: new BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(25.0),
                              topRight: const Radius.circular(25.0),
                            ),
                          ),
                          child: Wrap(direction: Axis.horizontal, children: [
                            NewTransaction(
                              _addNewTransaction,
                            ),
                            if (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                              Center(
                                child: (Lottie.network(
                                  getRandomAnimation(),
                                  height: 200,
                                  // width: 200,
                                  // onLoaded: (composition) {
                                  //   _controller
                                  //     ..duration = composition.duration
                                  //     ..reset()
                                  //     ..repeat();
                                  // },
                                )),
                              )
                          ]),
                        ),
            ),
          );
        });
  }

  bool _isUserPressedChartButton = false;
  Color _appBarIconColor = Theme.of(thisContext).accentColor;
  // var themeIconName = Icons.wb_sunny_rounded;
  bool _showChart = true;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    print('at initial : $isDark');
    // bool _showChart = MediaQuery.of(context).orientation == Orientation.portrait;
    if (!_isUserPressedChartButton)
      setState(() {
        if (mediaQuery.orientation == Orientation.portrait) {
          _showChart = true;
          _appBarIconColor = Theme.of(context).accentColor;
          // _appBarIconColor = Theme.of(context).primaryColorDark;
        } else {
          _showChart = false;
          _appBarIconColor = Theme.of(context).backgroundColor;
        }
      });

    // final appBar = AppBar(
    //   title: Text(
    //     'Personal Expenses',
    //     // style: TextStyle(fontFamily: 'OpenSans'),
    //   ),
    //   actions: <Widget>[
    //     IconButton(
    //       icon: Icon(
    //         //app bar add icon
    //         // Icons.add_chart_rounded,
    //         // Icons.addchart_rounded,
    //         Icons.insert_chart_outlined,
    //         // Icons.add,
    //         color: _appBarIconColor,
    //         size: 30,
    //       ),
    //       // onPressed: () => _startAddNewTransaction(context),
    //       onPressed: () {
    //         _isUserPressedChartButton = true;
    //         setState(() {
    //           if (_showChart) {
    //             _showChart = false;
    //             _appBarIconColor = Colors.white;
    //           } else {
    //             _showChart = true;
    //             _appBarIconColor = Colors.amber;
    //           }
    //           print(_showChart);
    //         });
    //       },
    //     )
    //   ],
    // );

    // var isMoonIcon =
    //     (MediaQuery.of(context).platformBrightness == Brightness.dark)
    //         ? true
    //         : false;

    final appBar = AppBar(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
          icon: Icon(
            // themeIconName,
            (isDark) ? Icons.wb_sunny_rounded : Icons.dark_mode,
            color: (isDark) ? Colors.amber.withOpacity(0.5) : Colors.amber,
            // (isMoonIcon) ? (Icons.dark_mode) : (Icons.wb_sunny_rounded),
            // color: _appBarIconColor,
          ),
          onPressed: () {
            print('toggle theme mode : $isDark');
            setState(() {
              widget.themeChanger();
              if (isDark) {
                isDark = false;
              } else {
                isDark = true;
              }
              // if (MediaQuery.of(context).platformBrightness ==
              //     Brightness.dark) {
              //   // isMoonIcon = true;
              //   themeIconName = Icons.dark_mode;
              // } else {
              //   // isMoonIcon = false;
              //   themeIconName = Icons.wb_sunny_rounded;
              // }
            });
            print('After toggling : $isDark');
          },
        ),
        Text(
          'Personal Expenses',
        ),
        IconButton(
          icon: Icon(
            //app bar add icon
            // Icons.add_chart_rounded,
            // Icons.addchart_rounded,
            Icons.insert_chart_outlined,
            // Icons.add,
            color: _appBarIconColor,
            size: 30,
          ),
          // onPressed: () => _startAddNewTransaction(context),
          onPressed: () {
            print('showchart toggle pressed.');
            _isUserPressedChartButton = true;
            setState(() {
              if (_showChart) {
                _showChart = false;
                //white
                // _appBarIconColor = Colors.white;
                _appBarIconColor = Theme.of(context).backgroundColor;
              } else {
                _showChart = true;
                //amber
                _appBarIconColor = Theme.of(context).accentColor;
              }
              print(_showChart);
            });
          },
        )
      ]

          // style: TextStyle(fontFamily: 'OpenSans'),
          ),
      // actions: <Widget>[],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Column(
        // mainAxisAlignment:
        //     MainAxisAlignment.spaceAround, //vertical      FOR COLUMN
        // crossAxisAlignment:
        //     CrossAxisAlignment.stretch, //horizontal    FOR COLUMN
        children: [
          if (_userTransactions.isNotEmpty && _showChart)
            Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  ((mediaQuery.orientation == Orientation.portrait)
                      ? (0.25)
                      : (0.50)),
              child: Chart(_recentTransactions),
            ),
          Container(
            height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                ((mediaQuery.orientation == Orientation.portrait)
                    ? ((_showChart) ? (0.75) : (1))
                    : ((_showChart) ? (0.50) : (1))),
            child: TransactionList(
              _userTransactions,
              _deleteTransaction,
            ),
          ),
          // if (_userTransactions.isNotEmpty) Chart(_recentTransactions),
          // TransactionList(
          //   _userTransactions,
          //   _deleteTransaction,
          // ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}

/*
EXTRA CODES : 

  //tough implementation of map :
          // Column(
          //   children: transactions.map((tx) {
          //     return Card(
          //       child: Text(tx.title.toString()),
          //     );
          //   }).toList(),
          // ),

 //easy implementatin of for loop :
          // for (var transaction in transactions)
          //   Card(
          //       child: Column(
          //     children: [
          //       Text('Id : ' + transaction.id.toString()),
          //       Text('Title : ' + transaction.title.toString()),
          //       Text('Amount : \$' + transaction.amount.toString()),
          //       Text('Date : ' + transaction.date.toString()),
          //     ],
          //   )),
*/
