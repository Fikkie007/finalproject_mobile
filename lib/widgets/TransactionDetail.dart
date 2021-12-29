import "package:flutter/material.dart";
import 'package:my_first_app/models/transaction.dart';
import 'package:my_first_app/providers/TransactionProvider.dart';
import 'package:my_first_app/widgets/TransactionsEdit.dart';
import 'package:provider/provider.dart';

class TransactionDetail extends StatefulWidget {
  final Transaction transaction;
  final Function transactionCallback;
  const TransactionDetail(this.transaction, this.transactionCallback,
      {Key? key})
      : super(key: key);

  @override
  _TransactionDetailState createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final transactionAmountController = TextEditingController();
  final transactionCategoryController = TextEditingController();
  final transactionDescriptionController = TextEditingController();
  final transactionDateController = TextEditingController();
  String errorMessage = '';

  @override
  void initState() {
    transactionAmountController.text = widget.transaction.amount.toString();
    transactionCategoryController.text = widget.transaction.categoryName;
    transactionDescriptionController.text =
        widget.transaction.description.toString();
    transactionDateController.text =
        widget.transaction.transactionDate.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    return Padding(
      padding: EdgeInsets.only(top: 50, left: 10, right: 10),
      child: Container(
        child: Column(
          children: [
            TextFormField(
              controller: transactionAmountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
                icon: Icon(Icons.attach_money),
                hintText: '0',
              ),
              enabled: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: transactionDescriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                )),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: transactionCategoryController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Category Name',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: transactionDateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Transaction date',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: Text('Edit'),
                    onPressed: () => showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext ctx) {
                          return TransactionEdit(widget.transaction,
                              provider.updateTransaction, context);
                        }),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                        minimumSize: const Size.fromHeight(50)),
                    child: Text('Delete'),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmation"),
                            content: Text("Are you sure you want to delete?"),
                            actions: [
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              TextButton(
                                  child: Text("Delete"),
                                  onPressed: () => deleteTransaction(
                                      provider.deleteTransaction,
                                      widget.transaction,
                                      context)),
                            ],
                          );
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () => Navigator.pop(context),
                      child: Text("Close"))
                ]),
          ],
        ),
      ),
    );
  }

  Future deleteTransaction(
      Function callback, Transaction transaction, BuildContext context) async {
    await callback(transaction);
    Navigator.pop(context);
  }
}
