import 'package:flutter/material.dart';

import '../../../widgets/shimmer_widget.dart';

class CategoryLoadingShimmer extends StatelessWidget {
  const CategoryLoadingShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(
          top: 16, bottom: 20),
      child: Row(
        children: List.generate(3, (index) => const Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Column(
            children: [
              ShimmerWidget(width: 80, height: 80, isCircle: true,),
              SizedBox(height: 12),
              ShimmerWidget(width: 90, height: 16),
            ],
          ),
        )).toList(),
      ),
    );
  }
}