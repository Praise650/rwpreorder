import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rwk20/models/package.dart';
import 'package:rwk20/ui/views/package_preview_slider.dart';
import 'package:rwk20/utils/payment_api.dart';
import 'package:rwk20/widgets/input_field.dart';
import 'dart:js' as js;

class FormView extends StatefulWidget {
  const FormView({Key key}) : super(key: key);

  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  Order order = Order();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var locationController = TextEditingController();
  var emailController = TextEditingController();
  DateTime _curDate = DateTime.now();

  String color = "blue";
  String groupValue = 'color';
  List<String> sizes = ["Small", "Medium", "Large"];
  List<String> packages = [
    'Tee shirts',
    'Hoodie',
    'Sweat shirt',
    'Varsity Jacket',
    'Face cap',
    'Tote bag',
    'Jotter'
  ];
  List<String> colors = ['black', 'blue', 'white'];
  String size = "Small";
  String package = "Hoodie";
  double price = 6000.0;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _loading = false;
  set loading(bool value) {
    setState(() => _loading = value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PackagePreviewSlide(),
        Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Kindly fill the following details',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child: Column(children: [
                          Row(children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Color:',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  isExpanded: true,
                                  items: List.generate(
                                      colors.length,
                                      (index) => DropdownMenuItem(
                                            child: Text("${colors[index]}"),
                                            value: colors[index],
                                          )),
                                  value: color,
                                  onChanged: (value) {
                                    setState(() {
                                      color = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Container()),
                          ]),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Package:',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    items: List.generate(
                                        packages.length,
                                        (index) => DropdownMenuItem(
                                              child: Text("${packages[index]}"),
                                              value: packages[index],
                                            )),
                                    value: package,
                                    onChanged: (value) {
                                      setState(() {
                                        package = value;
                                        switch (value) {
                                          case 'Tee shirts':
                                            price = 3000.00;
                                            break;
                                          case 'Hoodie':
                                            price = 6000.00;
                                            break;
                                          case 'Varsity Jacket':
                                            price = 6000.00;
                                            break;
                                          case 'Sweat shirt':
                                            price = 4000.00;
                                            break;
                                          case 'Tote bag':
                                            price = 2000.00;
                                            color = colors[0];
                                            break;
                                          case 'Face cap':
                                            price = 2000.00;
                                            break;
                                          case 'Jotter':
                                            price = 800.00;
                                            color = colors[0];
                                            break;
                                          default:
                                            price = 0.00;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "\u20A6 $price",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Size:',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    items: List.generate(
                                        sizes.length,
                                        (index) => DropdownMenuItem(
                                              child: Text("${sizes[index]}"),
                                              value: sizes[index],
                                            )),
                                    value: size,
                                    onChanged: (value) {
                                      setState(() {
                                        size = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(flex: 1, child: Container()),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              InputField(
                label: "Full Name",
                controller: nameController,
              ),
              InputField(
                label: "Phone Number",
                controller: phoneController,
                validator: (phone) {
                  if (!RegExp(r'^(?:[0][0-9])?[0-9]{9}$').hasMatch(phone))
                    return "Please Enter a valid Phone number";
                },
              ),
              InputField(
                label: "Email Address",
                controller: emailController,
                validator: (email) {
                  Pattern pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  if (!RegExp(pattern).hasMatch(email))
                    return "Please enter a valid email address";
                },
              ),
              InputField(
                label: "Location",
                controller: locationController,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: _loading == true
                              ? null
                              : () async {
                                  await submitForm(context);
                                },
                          child: _loading == true
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Pay Now",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future submitForm(BuildContext context) async {
    var otherPackageColor =
        package == 'Tote bag' || package == 'Jotter' ? colors[0] : color;
    loading = true;
    if (formKey.currentState.validate()) {
      // Upload Order here
      order.package = package;
      order.customerName = nameController.text;
      order.color = otherPackageColor;
      order.phone = phoneController.text;
      order.email = emailController.text;
      order.location = locationController.text;
      order.size = size;
      order.price = price;
      order.delivered = false;
      order.deliveredStatus = 'Pending';
      await Future.delayed(Duration(seconds: 1));

      print("Getting firebase instance");
      final CollectionReference orders =
          FirebaseFirestore.instance.collection("orders");

      await orders.add({
        'package': order.package,
        'full_name': order.customerName,
        'color': order.color,
        'phone_number': order.phone,
        'email': order.email,
        'location': order.location,
        'size': order.size,
        'price': order.price,
        'date': order.date,
        'delivered':order.delivered,
        'deliveredStatus':order.deliveredStatus

        // 'id':orders.id,
        }).then((value) async {
        print('Details Added');

        double charges = 0;
        if (order.price < 2400) {
          charges = order.price * 0.016;
        } else
          charges = (order.price * 0.016) + 100;

        showToast("Applied Payment Fee: ${order.price + charges}",
            context: context,
            position: ToastPosition.bottom,
            duration: Duration(seconds: 2));

        PaymentApi.initializePayment(
          ((order.price + charges) * 100).round(), order.email)
            .then((value) {
          loading = false;
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => PaymentPage(paymentInitData: value)));

          js.context.callMethod('open', ['${value.authorizationUrl}']);
        }).catchError((e) {
          loading = false;
          showToast("${e.toString()}",
              context: context,
              position: ToastPosition.bottom,
              duration: Duration(seconds: 2));
        });
      }).catchError((onError) {
        loading = false;
        // Fluttertoast.showToast(
        //     msg: "An Error Occurred... Please try again!",
        //     toastLength: Toast.LENGTH_LONG);
        print('$onError');
      });

      // Navigator.pop(context);
    } else {
      print("Fields not filled correctly");
      loading = false;
      // Fluttertoast.showToast(
      //     msg: "Fill all fields", backgroundColor: Colors.red.withOpacity(0.5));
      showToast("Please fill all fields correctly",
          context: context,
          position: ToastPosition.bottom,
          duration: Duration(seconds: 2));
    }
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPhone() {
    return RegExp(r'^(?:[+0][0-9])?[0-9]{10}$').hasMatch(this);
  }
}
