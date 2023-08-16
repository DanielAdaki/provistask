import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ReviewWidget extends StatelessWidget {
  final String avatarUrl;
  final String username;
  final int rating;
  final String review;
  final String date;
  const ReviewWidget({
    Key? key,
    required this.avatarUrl,
    required this.username,
    required this.rating,
    required this.review,
    required this.date,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: List.generate(
                    rating,
                    (index) => const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ),
                ),
                ReadMoreText(
                  review,
                  trimLines: 2,
                  textAlign: TextAlign.justify,
                  colorClickableText: const Color(0xFF2B1B99),
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(date),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
