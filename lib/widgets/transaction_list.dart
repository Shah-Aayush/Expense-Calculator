import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          // height: 300,
          // height: (MediaQuery.of(context).size.height / 3) * 1.9,
          width: double.infinity,
          child: widget.transactions.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // SizedBox(
                    //   height: 50,
                    // ),
                    Padding(
                      // padding: const EdgeInsets.only(),
                      padding: const EdgeInsets.only(top: 100),
                      child: Text(
                        'No transactions added yet!',
                        style: Theme.of(context).textTheme.headline6,
                        // style: TextStyle(
                        //   fontFamily: 'Quicksand',
                        //   fontWeight: FontWeight.bold,
                        //   fontSize: 20,
                        //   color: Theme.of(context).primaryColor,
                        // ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('tapped animation');
                        _controller.reverse();
                        Future.delayed(
                            const Duration(seconds: 1, milliseconds: 500), () {
                          setState(() {
                            // _controller.animateTo(30);
                            _controller.forward();
                          });
                        });
                      },
                      child: Lottie.asset(
                        'assets/animations/empty_box.json',
                        controller: _controller,
                        width: 300,
                        repeat: false,
                        onLoaded: (composition) {
                          // _controller.animateTo(50);
                          _controller
                            ..duration = composition.duration
                            ..forward();
                          // Future.delayed(Duration(seconds: 1), () {
                          //   setState(() {
                          //     _controller.reverse();
                          //   });
                          // });
                        },
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text(
                                  '\$${widget.transactions[index].amount.toStringAsFixed(2)}'),
                            ),
                          ),
                        ),
                        title: Text(
                          widget.transactions[index].title.toString(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMMd()
                              .format(widget.transactions[index].date),
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () {
                            print(
                                'delete pressed. ${widget.transactions[index].id}');
                            widget.deleteTx(widget.transactions[index].id);
                          },
                          // onPressed: () =>
                          //     widget.deleteTx(widget.transactions[index].id),
                        ),
                      ),
                    );

                    // return Card(
                    //     child: Row(
                    //   children: [
                    //     Container(
                    //       margin: EdgeInsets.symmetric(
                    //         vertical: 10,
                    //         horizontal: 15,
                    //       ),
                    //       decoration: BoxDecoration(
                    //           // borderRadius: BorderRadius.all(Radius.circular(100)),
                    //           border: Border.all(
                    //         color: Theme.of(context).primaryColor,
                    //         width: 2,
                    //         // color: Colors.purple,
                    //       )),
                    //       padding: EdgeInsets.all(10),
                    //       child: Text(
                    //         '\$${widget.transactions[index].amount.toStringAsFixed(2)}',
                    //         maxLines: 1,
                    //         // '\$' + transaction.amount.toString(),

                    //         style: TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 20,
                    //           color: Theme.of(context).primaryColor,
                    //         ),
                    //       ),
                    //     ),
                    //     Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             widget.transactions[index].title.toString(),
                    //             style: Theme.of(context).textTheme.headline6,
                    //             // style: TextStyle(
                    //             //   fontWeight: FontWeight.bold,
                    //             //   fontSize: 18,
                    //             // ),
                    //           ),
                    //           Text(
                    // DateFormat.yMMMMd()
                    //     .format(widget.transactions[index].date),
                    //             // DateFormat('MMMM dd, yyyy').format(transaction.date),
                    //             // DateFormat().format(transaction.date),
                    //             // transaction.date.toString().split(' ')[0],

                    //             style: TextStyle(
                    //               color: Colors.grey, fontFamily: 'Quicksand',
                    //               // color: Color(0xff808080), //setting color through hex code. note that before hex code we have to add '0xff'.
                    //             ),
                    //           ),
                    //         ]),
                    //   ],
                    // ));
                  },
                  itemCount: widget.transactions.length,
                  // children: [    //ListView only
                  // Column(children: [
                  // for (var transaction in transactions)
                  // Card(
                  //     child: Row(
                  //   children: [
                  //     Container(
                  //       margin: EdgeInsets.symmetric(
                  //         vertical: 10,
                  //         horizontal: 15,
                  //       ),
                  //       decoration: BoxDecoration(
                  //           // borderRadius: BorderRadius.all(Radius.circular(100)),
                  //           border: Border.all(
                  //         color: Colors.purple,
                  //       )),
                  //       padding: EdgeInsets.all(10),
                  //       child: Text(
                  //         '\$${transaction.amount}',
                  //         // '\$' + transaction.amount.toString(),
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 20,
                  //           color: Colors.purple,
                  //         ),
                  //       ),
                  //     ),
                  //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  //       Text(
                  //         transaction.title.toString(),
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 18,
                  //         ),
                  //       ),
                  //       Text(
                  //         DateFormat.yMMMMd().format(transaction.date),
                  //         // DateFormat('MMMM dd, yyyy').format(transaction.date),
                  //         // DateFormat().format(transaction.date),
                  //         // transaction.date.toString().split(' ')[0],
                  //         style: TextStyle(
                  //           color: Colors.grey,
                  //           // color: Color(0xff808080), //setting color through hex code. note that before hex code we have to add '0xff'.
                  //         ),
                  //       ),
                  //     ])
                  //   ],
                  // )),
                  // ]),
                  // ]),
                )),
    );
  }
}
