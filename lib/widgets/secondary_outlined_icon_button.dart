import 'package:flutter/material.dart';

class OutlinedSecondaryIconButton extends StatelessWidget {
  final String text;
  final String assetIconPath; // Path to your local asset SVG/PNG or web URL
  final VoidCallback onPressed;
  final bool isNetworkImage;

  const OutlinedSecondaryIconButton({
    super.key,
    required this.text,
    required this.assetIconPath,
    required this.onPressed,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Takes full width available, tweak or wrap if needed
      height: 52, // Standard modern button height
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF1F2937), // Dark gray text color
          side: const BorderSide(
            color: Color(0xFFDADCE0), // Soft gray border matching the image
            width: 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Smooth rounded corners
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon Handling (Supports both web URL and local Assets)
            isNetworkImage
                ? Image.network(assetIconPath, width: 20, height: 20)
                : Image.asset(assetIconPath, width: 20, height: 20),
            const SizedBox(width: 12), // Space between logo and text
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}