import 'package:flutter/material.dart';
import '../../../../core/services/feature_management_service.dart';

class FeatureAwareGameItem extends StatelessWidget {
  final String featureId;
  final Widget child;
  final VoidCallback onTap;
  final FeatureManagementService featureService;

  const FeatureAwareGameItem({
    Key? key,
    required this.featureId,
    required this.child,
    required this.onTap,
    required this.featureService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: featureService.getFeatureStatus(featureId),
      builder: (context, snapshot) {
        final isEnabled = snapshot.data ?? false;
        
        if (!isEnabled) {
          return const SizedBox.shrink(); // Completely remove from layout when disabled
        }

        return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: onTap,
          child: child,
        );
      },
    );
  }
}
