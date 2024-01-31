import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../constants/asset_path.dart';
import '../models/owner.dart';

class OwnerWidget extends StatelessWidget {
  const OwnerWidget({
    super.key,
    required this.owner,
    this.expanded,
  });

  final bool? expanded;
  final Owner owner;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: const AssetImage(assetImageOwner),
          foregroundImage: CachedNetworkImageProvider(owner.avatarUrl),
          radius: (expanded != null) ? 20 : 10,
        ),
        hGap10,
        Text(owner.login,
            style: TextStyle(
              color: Colors.grey.shade200,
              fontSize: (expanded != null) ? 24 : 14,
            )),
      ],
    );
  }
}
