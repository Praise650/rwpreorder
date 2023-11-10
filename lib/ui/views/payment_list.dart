import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rwk20/models/payment_list_model.dart';
import 'package:rwk20/ui/base_widget.dart';
import 'package:rwk20/widgets/payment_list_view_widget.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({Key key}) : super(key: key);

  @override
  _PaymentListState createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _init();
    });
  }

  List<PaymentListModel> paymentList = [];

  Future<QuerySnapshot> _init() async {
    final QuerySnapshot orders =
        await FirebaseFirestore.instance.collection("orders").get();
    return orders;
  }

  int selectedIndex = 0;

  updateIndex(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BaseWidget(
        builder: (context, sizingInformation) {
          return Scaffold(
            appBar: AppBar(
              leading: SizedBox.shrink(),
              flexibleSpace: Column(
                children: [
                  Expanded(
                    child: Text(
                      'RW \'23 Preorder Payment List',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: TabBar(
                      physics: const NeverScrollableScrollPhysics(),
                      onTap: (index) => updateIndex(index),
                      tabs: const [
                        Tab(text: "Pending"),
                        Tab(text: "Approved"),
                        Tab(text: "All"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: FutureBuilder<QuerySnapshot>(
              future: _init(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done ||
                    snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  paymentList = documents
                      .map(
                        (document) => PaymentListModel.fromJson(
                          document.data(),
                          document.id,
                        ),
                      )
                      .toList();

                  return Builder(
                    builder: (context) {
                      if (selectedIndex == 0) {
                        final pending = paymentList
                            .where((element) => element.delivered == false)
                            .toList();
                        return PaymentListviewWidget(
                          paymentList: pending,
                        );
                      } else if (selectedIndex == 1) {
                        final approved = paymentList
                            .where((element) => element.delivered == true)
                            .toList();
                        return PaymentListviewWidget(
                          paymentList: approved,
                        );
                      } else {
                        return PaymentListviewWidget(
                          paymentList: paymentList,
                        );
                      }
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('It\'s Error!');
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          );
        },
      ),
    );
  }
}
