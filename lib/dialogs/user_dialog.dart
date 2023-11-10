import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rwk20/models/payment_list_model.dart';

class AcceptUser extends StatefulWidget {
  AcceptUser({this.user});

  final PaymentListModel user;

  @override
  State<AcceptUser> createState() => _AcceptUserState();
}

class _AcceptUserState extends State<AcceptUser> {
  final _fService = FirebaseFirestore.instance;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.user.delivered == true
          ? Text("View Approved User")
          : Text("Verify Pending User"),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width * .8,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.user.fullname ?? "Nil",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.user.email ?? "Nil",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.user.phone ?? "Nil",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    _InfoCard(
                      tag: 'Package',
                      value: widget.user.package.toString(),
                    ),
                    _InfoCard(
                      tag: 'Color',
                      value: widget.user.color.toString(),
                    ),
                    _InfoCard(
                      tag: 'Location',
                      value: widget.user.location.toString(),
                    ),
                    _InfoCard(
                      tag: 'Size',
                      value: widget.user.size.toString(),
                    ),
                    _InfoCard(
                      tag: 'Price',
                      value: widget.user.price.toString(),
                    ),
                    _InfoCard(
                      tag: 'Delivered',
                      value: widget.user.delivered == true ? 'Yes' : "No",
                    ),
                    _InfoCard(
                      tag: 'Delivery Status',
                      value: widget.user.deliveryStatus.toString(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      actions: widget.user.delivered == true
          ? [
              MaterialButton(
                elevation: 0,
                onPressed: () => Navigator.pop(context),
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text("Close"),
              ),
            ]
          : [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              loading == true
                  ? CircularProgressIndicator()
                  : MaterialButton(
                      elevation: 0,
                      onPressed: () => _approveBuyer(),
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: const Text("Verify"),
                    ),
            ],
    );
  }

  _approveBuyer() {
    setState(() => loading = true);
    try {
      _fService.collection('orders').doc(widget.user.id).set({
        'delivered': true,
        'deliveredStatus': "Delivered",
      }, SetOptions(merge: true)).then(
        (value) {
          actionResponse(true, context);
          Future.delayed(
            Duration(seconds: 4),
            () {
              setState(() => loading = false);
              Navigator.pop(context);
            },
          );
          Navigator.pop(context);
        },
      );
    } catch (e) {
      print(e);
      setState(() => loading = false);
      actionResponse(false, context);
      Future.delayed(
        Duration(seconds: 3),
        () => Navigator.pop(context),
      );
    }
  }

  void actionResponse(bool successful, context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(successful == true
            ? "Verification Successful"
            : "Verification Failed"),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.width * .6,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  successful == true
                      ? Text("User as been verify successfully ")
                      : Text("User verification failed"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({this.value, this.tag});

  final String value;
  final String tag;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "$tag:",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10)
                ],
              ),
              Flexible(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
