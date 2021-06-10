import 'package:flutter/material.dart';
import "dart:math";
import 'package:lottie/lottie.dart';

// import 'package:flushbar/flushbar.dart';

// import './widgets/user_transactions.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
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
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // final DateFormat formatter = DateFormat('dd-MM-yyyy');

  // late String titleInput;
  // late String amountInput;

  // final titleController = TextEditingController();
  // final amountController = TextEditingController();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        context: ctx,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return GestureDetector(
              onTap: () {}, //will do nothing when we tap on the sheet.
              behavior: HitTestBehavior
                  .opaque, //wont close sheet when we tap on the sheet.
              child: Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(25.0),
                    topRight: const Radius.circular(25.0),
                  ),
                ),
                child: Column(children: [
                  NewTransaction(
                    _addNewTransaction,
                  ),
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
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
          // style: TextStyle(fontFamily: 'OpenSans'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              //app bar add icon
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: Column(
        // mainAxisAlignment:
        //     MainAxisAlignment.spaceAround, //vertical      FOR COLUMN
        // crossAxisAlignment:
        //     CrossAxisAlignment.stretch, //horizontal    FOR COLUMN
        children: [
          if (_userTransactions.isNotEmpty) Chart(_recentTransactions),
          TransactionList(_userTransactions,_deleteTransaction),
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