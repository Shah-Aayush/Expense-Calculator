import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "dart:math";
import 'package:lottie/lottie.dart';
import 'package:flutter/rendering.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

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
ThemeData lightTheme = ThemeData(
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
  cupertinoOverrideTheme: CupertinoThemeData(
    barBackgroundColor: Colors.purple,
  ),
);

ThemeData darkTheme = ThemeData(
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
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xff443a36)),
  cupertinoOverrideTheme: CupertinoThemeData(
    barBackgroundColor: Color(0xff272727),
  ),
);
CupertinoThemeData iosTheme = CupertinoThemeData(
  barBackgroundColor: Colors.amber,
);

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  var isDark;

  @override
  Widget build(BuildContext context) {
    thisContext = context;
    final isPlatformDark =
        WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;

    final initTheme = isPlatformDark ? darkTheme : lightTheme;
    return ThemeProvider(
      initTheme: initTheme,
      builder: (_, myTheme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: myTheme,
          home: MyHomePage(isPlatformDark),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final isDark;
  MyHomePage(this.isDark);
  @override
  _MyHomePageState createState() => _MyHomePageState(isDark);
}

class _MyHomePageState extends State<MyHomePage> {
  var isDark;
  _MyHomePageState(this.isDark);
//imported code starts
  final List<Transaction> _userTransactions = [];

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

  bool isExpanded = true;
  late ScrollController fabController;

  @override
  void initState() {
    super.initState();
    fabController = ScrollController();
    fabController.addListener(() {
      setState(() {
        isExpanded = fabController.position.userScrollDirection ==
            ScrollDirection.forward;
        isExpanded = (_userTransactions.length > 0) ? isExpanded : true;
      });
    });
  }

  PreferredSizeWidget _buildCupertinoNavBar() {
    return CupertinoNavigationBar(
      middle: Text('Personal Expenses'),
      trailing: Row(
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          )
        ],
      ),
    );
  }

  PreferredSize _buildMaterialNavBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          // SizedBox(
          //   height: 10,
          //   width: 40,
          //   child:
          ThemeSwitcher(
            clipper: ThemeSwitcherCircleClipper(),
            builder: (context) {
              return IconButton(
                icon: Icon(
                  (isDark) ? Icons.wb_sunny_rounded : Icons.dark_mode,
                  color:
                      (isDark) ? Colors.amber.withOpacity(0.5) : Colors.amber,
                ),
                onPressed: () {
                  if (isDark) {
                    isDark = false;
                  } else {
                    isDark = true;
                  }
                  print('status : $isDark');
                  // var brightness = ThemeProvider.of(context)!.brightness;
                  ThemeSwitcher.of(context)!.changeTheme(
                    theme: isDark ? darkTheme : lightTheme,
                    // theme: brightness == Brightness.light
                    //     ? darkTheme
                    //     : lightTheme,
                    reverseAnimation: isDark ? false : true,
                  );
                },
              );
            },
          ),

          Text(
            'Personal Expenses',
          ),
          IconButton(
            icon: Icon(
              Icons.insert_chart_outlined,
              color: _appBarIconColor,
              size: 30,
            ),
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
        ]),
      ),
    );
  }

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
    final PreferredSizeWidget appBar =
        Platform.isIOS ? _buildCupertinoNavBar() : _buildMaterialNavBar();
    final pageBody = SafeArea(
      child: Column(
        children: [
          if (_userTransactions.isNotEmpty && _showChart)
            Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  ((mediaQuery.orientation == Orientation.portrait)
                      ? ((Platform.isIOS) ? (0.25) : (0.25))
                      : ((Platform.isIOS) ? (0.45) : (0.50))),
              child: Chart(_recentTransactions),
            ),
          Container(
            height: (mediaQuery.size.height -
                    mediaQuery.padding.top -
                    appBar.preferredSize.height) *
                ((mediaQuery.orientation == Orientation.portrait)
                    ? ((_showChart)
                        ? ((Platform.isIOS) ? (0.70) : (0.75))
                        : ((Platform.isIOS) ? (0.90) : (1)))
                    : ((_showChart)
                        ? ((Platform.isIOS) ? (0.45) : (0.50))
                        : ((Platform.isIOS) ? (0.90) : (1)))),
            child: TransactionList(
                _userTransactions, _deleteTransaction, fabController),
          ),
        ],
      ),
    );
    return ThemeSwitchingArea(
      child: (Platform.isIOS)
          ? CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                leading: ThemeSwitcher(
                  clipper: ThemeSwitcherCircleClipper(),
                  builder: (context) {
                    return GestureDetector(
                      child: Icon(
                        (isDark) ? Icons.wb_sunny_rounded : Icons.dark_mode,
                        color: (isDark)
                            ? Colors.amber.withOpacity(0.5)
                            : Colors.amber,
                      ),
                      onTap: () {
                        if (isDark) {
                          isDark = false;
                        } else {
                          isDark = true;
                        }
                        print('status : $isDark');
                        // var brightness = ThemeProvider.of(context)!.brightness;
                        ThemeSwitcher.of(context)!.changeTheme(
                          theme: isDark ? darkTheme : lightTheme,
                          // theme: brightness == Brightness.light
                          //     ? darkTheme
                          //     : lightTheme,
                          reverseAnimation: isDark ? false : true,
                        );
                      },
                    );
                  },
                ),
                middle: Text(
                  'Personal Expenses',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      child: Icon(
                        CupertinoIcons.add,
                        color: (isDark)
                            ? Colors.amber.withOpacity(0.5)
                            : Colors.amber,
                      ),
                      onTap: () => _startAddNewTransaction(context),
                    ),
                  ],
                ),
              ),
              child: pageBody,
            )
          : Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SizedBox(
                      //   height: 10,
                      //   width: 40,
                      //   child:
                      ThemeSwitcher(
                        clipper: ThemeSwitcherCircleClipper(),
                        builder: (context) {
                          return IconButton(
                            icon: Icon(
                              (isDark)
                                  ? Icons.wb_sunny_rounded
                                  : Icons.dark_mode,
                              color: (isDark)
                                  ? Colors.amber.withOpacity(0.5)
                                  : Colors.amber,
                            ),
                            onPressed: () {
                              if (isDark) {
                                isDark = false;
                              } else {
                                isDark = true;
                              }
                              print('status : $isDark');
                              // var brightness = ThemeProvider.of(context)!.brightness;
                              ThemeSwitcher.of(context)!.changeTheme(
                                theme: isDark ? darkTheme : lightTheme,
                                // theme: brightness == Brightness.light
                                //     ? darkTheme
                                //     : lightTheme,
                                reverseAnimation: isDark ? false : true,
                              );
                            },
                          );
                        },
                      ),

                      Text(
                        'Personal Expenses',
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.insert_chart_outlined,
                          color: _appBarIconColor,
                          size: 30,
                        ),
                        onPressed: () {
                          print('showchart toggle pressed.');
                          _isUserPressedChartButton = true;
                          setState(() {
                            if (_showChart) {
                              _showChart = false;
                              //white
                              // _appBarIconColor = Colors.white;
                              _appBarIconColor =
                                  Theme.of(context).backgroundColor;
                            } else {
                              _showChart = true;
                              //amber
                              _appBarIconColor = Theme.of(context).accentColor;
                            }
                            print(_showChart);
                          });
                        },
                      )
                    ]),
              ),
              body: pageBody,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton:
                  // Platform.isIOS ?
                  AnimatedContainer(
                width: isExpanded ? 200 : 56,
                height: 56,
                duration: Duration(milliseconds: 150),
                child: Opacity(
                  opacity: isExpanded ? 0.9 : 0.8,
                  child: FloatingActionButton.extended(
                    onPressed: () => _startAddNewTransaction(context),
                    // label: Text('Add a Transaction'),
                    // icon: Icon(Icons.add),
                    icon: isExpanded ? Icon(Icons.add) : null,
                    label: isExpanded
                        ? Text(
                            "Add a transaction",
                            style: TextStyle(
                              // color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Icon(Icons.add),
                  ),
                ),
              )
              // : FloatingActionButton(
              //     child: Icon(Icons.add),
              //     onPressed: () => _startAddNewTransaction(context),
              //   ),
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
