import 'package:flutter/material.dart';

class ServiceUnavailable extends StatefulWidget {
  const ServiceUnavailable({Key key}) : super(key: key);

  @override
  State<ServiceUnavailable> createState() => _ServiceUnavailableState();
}

class _ServiceUnavailableState extends State<ServiceUnavailable> {
  bool loading = true;

  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3),
      () => setState(() => loading = false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: loading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "We are sorry \u{1F61E}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 44,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  SizedBox(height: 28),
                  Text(
                    "Payment service is currently unavailable",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 34,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
