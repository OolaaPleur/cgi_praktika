import 'package:flutter/material.dart';
import 'package:frontend/constants/api_constants.dart';

class AirportImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final BorderRadius? borderRadius;

  const AirportImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: height,
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Image.network(
          '${ApiConstants.baseUrl}${ApiConstants.imagesEndpoint}/$imageUrl',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value:
                    loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error);
          },
        ),
      ),
    );
  }
}
