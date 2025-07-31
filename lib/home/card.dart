import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Or your preferred dots indicator package

class CardPageViewScreen extends StatefulWidget {
  const CardPageViewScreen({super.key});

  @override
  State<CardPageViewScreen> createState() => _CardPageViewScreenState();
}

class _CardPageViewScreenState extends State<CardPageViewScreen> {
  final PageController _pageController = PageController();
  final int _numPages = 3; // Example: 3 cards/pages

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards with Dot Indicator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _numPages,
              itemBuilder: (context, index) {
                // Each page of the PageView will be a Card
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Card(
                    elevation: 5, // Adds a shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Rounded corners
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Card ${index + 1}',
                            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'This is the content for Card ${index + 1}.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Dot indicator at the bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: _numPages,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.deepPurple,
                dotColor: Colors.grey,
                dotHeight: 10,
                dotWidth: 10,
                expansionFactor: 4,
                spacing: 8.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}