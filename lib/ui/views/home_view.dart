import 'package:flutter/material.dart';
import 'package:rwk20/dialogs/login_dialog.dart';
import 'package:rwk20/ui/base_widget.dart';
import 'package:rwk20/ui/sizing_information.dart';
import 'package:rwk20/ui/views/form_screen.dart';
import 'package:rwk20/utils/ui_utils.dart';
import 'package:rwk20/widgets/warning.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, sizingInformation) {
        return Scaffold(
          appBar: AppBar(
            title: Text('RW \'23 Preorder'),
            actions: [
              SizedBox(
                height: 30,
                width: 100,
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      StadiumBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () => showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => LoginDialogWidget(),
                  ),
                  child: Text(
                    'Admin',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  showInfo(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      // textStyle: TextStyle(color: Colors.white),
                      color: Colors.grey.shade200,
                      elevation: 8,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: mobileWidthLimit,
                        margin: const EdgeInsets.all(10),
                        child: BaseWidget(
                          builder: (context, sizingInfo) {
                            SizingInformation si = sizingInfo;
                            return SingleChildScrollView(
                              child: FormView(),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
