import 'dart:io';
import 'adaptive_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NewTransaction extends StatefulWidget {
  // const NewTransaction({ Key? key }) : super(key: key);

  // late String titleInput;
  // late String amountInput;

  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  FocusNode titleField = new FocusNode();

  FocusNode amountField = new FocusNode();

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  bool isNumeric(String s) {
    // if (s == null) {
    //   return false;
    // }
    return double.tryParse(s) != null;
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  void _submitData() {
    // print('$titleInput $amountInput');
    // print(titleController.text);
    // print(amountController.text);

    FocusScope.of(thisContext).unfocus();
    if (_titleController.text.length == 0) {
      print('failure');
      showMessage(thisContext, "Enter title");
      // titleField.requestFocus();
    } else if (_amountController.text.length == 0) {
      print('failure');
      showMessage(thisContext, "Enter amount");
      // amountField.requestFocus();
    } else if (isNumeric(_amountController.text)) {
      if (double.parse(_amountController.text) <= 0) {
        showMessage(thisContext, "Enter positive value in Amount");
      } else {
        print('success');

        // FocusScope.of(context).unfocus();
        widget.addTransaction(
            _titleController.text,
            double.parse(_amountController.text),
            (_selectedDate != null) ? (_selectedDate) : (DateTime.now()));
        Navigator.of(thisContext).pop();
      }
    } else {
      // showMessage("hello");
      print('failure');
      showMessage(thisContext, 'Enter only numeric values in Amount');
    }
  }

  void showMessage(BuildContext context, String message) {
    // final cupertinoAlert = CupertinoAlertDialog(
    //   // title: Text(),
    //   content: Text(message),
    //   actions: [CupertinoDialogAction(child: Text('Okay'),)],
    // );
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.error,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              message,
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height / 1.9, right: 5, left: 5),
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );
    print('Message showed');
    if (Platform.isAndroid) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(message),
              // content: Text(message),
              actions: [
                CupertinoDialogAction(
                  child: Text('Okay'),
                  onPressed: () => Navigator.of(context).pop(false),
                )
              ],
            );
          });
    }
  }

  late BuildContext thisContext;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColorDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      child: Container(
        decoration: new BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        // padding: EdgeInsets.all(10),
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: new InputDecoration(
                labelText: 'Title',
              ),
              focusNode: titleField,
              controller: _titleController,
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
                thisContext = context;
              },
            ),
            TextField(
              focusNode: amountField,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp('[,]'))
              ],
              controller: _amountController,
              // keyboardType: TextInputType.number,      //maybe not work on iOS
              keyboardType: TextInputType.numberWithOptions(
                  decimal: true), //will work on both android and iOS!
              decoration: InputDecoration(labelText: 'Amount'),
              onSubmitted: (_) {
                //if we directly using () => submitData(), then we have to use paranthesis here. otherwise it will not work if we only provide a function pointer here.
                //whereever we dont want to use the argument but we have to accept it as per flutter rule, then we can use '_' sign as we are accepting this but we are not using it and kinda ignoring it.
                thisContext = context;
                _submitData();
              },
            ),
            // onChanged: (amount) => amountInput = amount,
            Container(
              // color: Theme.of(context).primaryColorDark,
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      (_selectedDate == null)
                          // ? 'No Date Chosen!'
                          ? 'Set date as Today.'
                          : 'Picked date : ${DateFormat.yMMMMd().format(_selectedDate!).toString()}',
                      style: TextStyle(
                        fontSize: 15,
                        fontStyle: (_selectedDate != null)
                            ? FontStyle.normal
                            : FontStyle.italic,
                        fontWeight: (_selectedDate != null)
                            ? FontWeight.bold
                            : FontWeight.normal,
                        // fontFamily: 'Quicksand',
                      ),
                    ),
                  ),
                  AdaptiveTextButton('Choose Date', _presentDatePicker),
                ],
              ),
            ),
            (Platform.isIOS)
                ? Center(
                    child: CupertinoButton(
                        child: Text('Add Transaction'),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          thisContext = context;
                          _submitData();
                        }),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      onPrimary: Theme.of(context).textTheme.button!.color,
                      // textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      thisContext = context;
                      _submitData();
                    },
                    child: Text(
                      'Add Transaction',
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
