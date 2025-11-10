import 'package:flutter/material.dart';

class SiteLogo extends StatelessWidget {
  const SiteLogo({super.key, this.ontap});
  final VoidCallback? ontap; 

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
              onTap: () {
                    ontap;
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      style: TextStyle(
                       fontWeight: FontWeight.bold,
                       color: Colors.white
                      ),
                      "CATALYSTCREW",
                    ),
                  ),
                );
  }
}