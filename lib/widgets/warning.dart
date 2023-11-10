import 'package:flutter/material.dart';

Widget showInfo({bool showAlert = true}) => Visibility(
      visible: showAlert,
      replacement: const SizedBox.shrink(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(2),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: const Text(
                    "Please note that the Tote bag and the branded notepad/jotter are available only in black")),
            TextButton(
              onPressed: () {
                showAlert = false;
              },
              child: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
