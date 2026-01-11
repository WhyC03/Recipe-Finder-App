import 'package:flutter/material.dart';
import 'package:recipe_finder_app/core/utils/colors.dart';
import 'package:recipe_finder_app/features/recipes/presentation/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Splash_Image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset('assets/images/Logo.png', width: size.width * 0.25),
                SizedBox(height: size.height * 0.02),
                Text(
                  "100K+ Premium Recipe",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.2),
            Column(
              children: [
                Text(
                  "Get \nCooking",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  'Simple way to find Tasty Recipe',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                SizedBox(height: size.height * 0.07),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Container(
                    width: size.width * 0.65,
                    height: 60,
                    decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Start Cooking",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward,
                          size: 20,
                          color: Colors.white,
                          weight: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
