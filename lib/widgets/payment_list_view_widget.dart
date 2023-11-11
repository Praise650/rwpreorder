import 'package:flutter/material.dart';
import 'package:rwk20/dialogs/user_dialog.dart';
import 'package:rwk20/models/payment_list_model.dart';

class PaymentListviewWidget extends StatefulWidget {
  PaymentListviewWidget({Key key, this.paymentList}) : super(key: key);

  List<PaymentListModel> paymentList = [];

  @override
  State<PaymentListviewWidget> createState() => _PaymentListviewWidgetState();
}

class _PaymentListviewWidgetState extends State<PaymentListviewWidget> {
  List<PaymentListModel> filteredCards = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Search by packages... ',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onChanged: (value) {
              setState(() {
                filteredCards.clear();
                if (value.isEmpty) {
                  return;
                }

                for (var element in widget.paymentList) {
                  if (element.package.toLowerCase().contains(value)) {
                    filteredCards.add(element);
                  }
                }
              });
            },
          ),
          SizedBox(height: 10),
          Expanded(
            child: filteredCards.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredCards.length,
                    itemBuilder: (context, index) {
                      final paymentList = filteredCards[index];
                      return Card(
                        child: ListTile(
                          title: Text(paymentList.fullname),
                          subtitle: Text(paymentList.email),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () async => await showDialog(
                            context: context,
                            builder: (context) => AcceptUser(
                              user: paymentList
                            ),
                          ),
                        ),
                      );
                    })
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.paymentList.length,
                    itemBuilder: (context, index) {
                      final paymentList = widget.paymentList[index];
                      return Card(
                        child: ListTile(
                          title: Text(paymentList.fullname),
                          subtitle: Text(paymentList.email),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () async => await showDialog(
                            context: context,
                            builder: (context) => AcceptUser(
                              user: paymentList,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
