// import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';

// import './transaction_list.dart';
// // import './new_transaction.dart';
// // import '../models/transaction.dart';

// class UserTransactions extends StatefulWidget {
//   // const UserTransactions({Key? key}) : super(key: key);
//   UserTransactions();

//   @override
//   _UserTransactionsState createState() => _UserTransactionsState();
// }

// class _UserTransactionsState extends State<UserTransactions> {
//   // final List<Transaction> _userTransactions = [
//   //   Transaction(
//   //     id: 't1',
//   //     title: 'New Shoes',
//   //     amount: 69.99,
//   //     date: DateTime.now(),
//   //   ),
//   //   Transaction(
//   //     id: 't2',
//   //     title: 'Weekly Groceries',
//   //     amount: 16.53,
//   //     date: DateTime.now(),
//   //   ),
//   //   Transaction(
//   //     id: 't3',
//   //     title: 'Starbucks Coffee',
//   //     amount: 11.99,
//   //     date: DateTime.now(),
//   //   ),
//   //   Transaction(
//   //     id: 't4',
//   //     title: 'Oreo Biscuits',
//   //     amount: 7.69,
//   //     date: DateTime.now(),
//   //   ),
//   //   Transaction(
//   //     id: 't5',
//   //     title: 'Tomato Ketchup',
//   //     amount: 31.57,
//   //     date: DateTime.now(),
//   //   ),
//   // ];

//   // void _addNewTransaction(String txTitle, double txAmount) {
//   //   final newTx = Transaction(
//   //       title: txTitle,
//   //       amount: txAmount,
//   //       date: DateTime.now(),
//   //       id: 't${(_userTransactions.length + 1).toString()}');

//   //   setState(() {
//   //     _userTransactions.add(newTx);
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // NewTransaction(_addNewTransaction),
//         TransactionList(_userTransactions),
//       ],
//     );
//   }
// }
