import 'package:flutter/material.dart';

import '../elements/card_element.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Welcome",
                    style: const TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Padding(padding: const EdgeInsets.only(left: 20.0)),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),

              Expanded(child: CardView()),
            ],
          ),
        ),
      ),
    );
  }
}
