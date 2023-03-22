import 'package:app_submission_flutter_fundamental/src/common/constants/theme_custom.dart';
import 'package:app_submission_flutter_fundamental/src/common/utils/utils.dart';
import 'package:app_submission_flutter_fundamental/src/features/restaurant/data/models/customer_review_model.dart';
import 'package:flutter/material.dart';

class ListTileReview extends StatelessWidget {
  final CustomerReviewModel data;
  final bool? isDetailReviews;

  const ListTileReview({
    super.key,
    required this.data,
    this.isDetailReviews = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      style: ListTileStyle.list,
      leading: CircleAvatar(
        child: Text(
          Utils.generateInitialText(data.name),
          style: TextStyle(
            color: ThemeCustom.secondaryColor.withOpacity(0.8),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            data.date,
            style: const TextStyle(
              color: ThemeCustom.thirdColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
      subtitle: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        child: isDetailReviews!
            ? Text(
                data.review,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                ),
              )
            : Text(
                data.review,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
      ),
    );
  }
}
