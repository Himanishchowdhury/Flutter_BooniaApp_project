import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: Column(
                  children: [
                    // Placeholder for logo
                    Container(
                      height: 180,
                      width: 180,
                      color: Color.fromARGB(255, 224, 219, 219),
                      child: const Center(child: Text("logo", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      "Boonia",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
      
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.10, // Adjust vertical position
            left: 0,
            right: 0,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IntroScreens()),
                    );
                  },
                  
                  style: ElevatedButton.styleFrom(
                    primary:Color.fromARGB(255, 6, 208, 235),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 90.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                        ),
                  ),
                  
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Already have an account? Click here",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        //decoration: TextDecoration.underline
                        ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -10, // Adjust to prevent overlap
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: BlueCurveClipper(),
              child: Container(
                height: 120,
                color: Color.fromARGB(255, 6, 208, 235),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BlueCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0); // Start from the top-left
    path.quadraticBezierTo(
      size.width / 4, size.height * 0.5, // Peak of the curve closer to the start
      size.width / 2, size.height * 0.5, // Curve dips down at the center
    );
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.5, // Curve back up towards the top right
      size.width, 0, // End at the top-right
    );
    path.lineTo(size.width, size.height); // Line to the bottom-right
    path.lineTo(0, size.height); // Line to the bottom-left
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // No need to reclip if the old clipper doesn't change
  }
}




class IntroScreens extends StatelessWidget {
  const IntroScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // SmoothPageIndicator at the top
              Padding(
                padding: const EdgeInsets.only(top: 40), // Adjust padding as needed
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3, // Number of pages
                  effect: ExpandingDotsEffect(
                    activeDotColor: Color.fromARGB(255, 6, 208, 235),
                    dotColor: Colors.grey.shade300,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 8,
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: controller,
                  children: [
                    IntroPage(
                      title: "Book Your Car" , 
                      description:
                          "With BooNia, go anywhere and save on every ride!",
                      imagePath: "assets/imagescreen2.png",
                      controller: controller,
                      isLastPage: false,
                      pageColor: Colors.grey[400]!,
                    ),
                    IntroPage(
                      title: "On Demand Food",
                      description:
                          "Explore a world of fresh food options and other deliveries with BooNia.",
                      imagePath: "assets/imagescreen3.png",
                      controller: controller,
                      isLastPage: false,
                      pageColor: Colors.grey[400]!,
                      
                    ),
                    IntroPage(
                      title: "Start with Boonia!",
                      description:
                          "Make a sustainable difference with everything you choose with Boonia.",
                      imagePath: "assets/imagescreen4.png",
                      controller: controller,
                      isLastPage: true,
                      pageColor: Colors.grey[400]!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class IntroPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isLastPage;
  final PageController controller;

  const IntroPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.controller,
    this.isLastPage = false, required Color pageColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  imagePath,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Spacer(),
              if (isLastPage)
                ElevatedButton(
                  onPressed: () {
                    // Handle continue action here
                    print("Get Started clicked");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 6, 208, 235), // Blue button
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 100.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        if (!isLastPage)
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: () {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                backgroundColor: Color.fromARGB(255, 6, 208, 235),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22), // Adjust this for more or less rounded corners
                ),
                child:  const Icon(Icons.arrow_forward),
              ),
            ),
          ),
      ],
    );
  }
}