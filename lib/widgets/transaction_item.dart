import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTx;
  final mediaQuery;

  TransactionItem(this.transaction, this.deleteTx, this.mediaQuery);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title.toString(),
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(transaction.date),
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Quicksand',
          ),
        ),
        trailing: (mediaQuery.size.width > 460)
            ? TextButton.icon(
                onPressed: () {
                  print('delete pressed. ${transaction.id}');
                  deleteTx(transaction.id);
                },
                icon: Icon(Icons.delete),
                label: const Text('Delete'),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).errorColor,
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  print('delete pressed. ${transaction.id}');
                  deleteTx(transaction.id);
                },
                // onPressed: () =>
                //     widget.deleteTx(widget.transactions[index].id),
              ),
      ),
    );
  }
}
