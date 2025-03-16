import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/api_constants.dart';

class FlightCompanyWidget extends StatelessWidget {
  final String companyName;
  final String companyPhotoId;
  final double fontSize;

  const FlightCompanyWidget({
    super.key,
    required this.companyName,
    required this.companyPhotoId,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: ApiConstants.companyPhotoUrlPattern.replaceAll(
              '{id}',
              companyPhotoId,
            ),
            height: 50,
            width: 50,
            errorWidget: (context, url, error) => const SizedBox(),
            placeholder: (context, url) => const SizedBox(),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          companyName,
          style: TextStyle(fontSize: fontSize, color: Colors.grey),
          overflow: TextOverflow.visible,
          softWrap: true,
        ),
      ],
    );
  }
}
