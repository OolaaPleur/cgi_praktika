import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/api_constants.dart';

class FlightCardImage extends StatelessWidget {
  final String imageUrl;

  const FlightCardImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: CachedNetworkImage(
        imageUrl:
            '${ApiConstants.baseUrl}${ApiConstants.imagesMediumEndpoint}/$imageUrl',
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget:
            (context, url, error) => Image.asset(
              'assets/images/cities/city_1.jpg',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
      ),
    );
  }
}
