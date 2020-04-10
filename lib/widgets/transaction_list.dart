import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List transactions;
  final Function delTxn;
  TransactionList(this.transactions, this.delTxn);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text("No Transactions"),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  elevation: 6,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                            child: Text("\$${transactions[index].amount}")),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(transactions[index].datetime),
                    ),
                    trailing: MediaQuery.of(context).size.width < 440
                        ? IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => delTxn(transactions[index].id),
                            color: Theme.of(context).errorColor,
                          )
                        : FlatButton.icon(
                            onPressed: () => delTxn(transactions[index].id),
                            icon: Icon(Icons.delete),
                            label: Text("Delete"),
                            textColor: Theme.of(context).errorColor,
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
