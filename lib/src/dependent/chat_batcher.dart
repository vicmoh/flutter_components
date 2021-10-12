import 'package:flutter/material.dart';
import 'package:provider_skeleton/provider_skeleton.dart';
import 'package:dart_util/dart_util.dart';

class ChatBatchingStatus {
  /// Greater than the
  /// first two index.
  final bool isSafe;

  /// The last widget.
  final bool isMostRecent;

  /// Determine if it is the oldest item.
  final bool isOldestItem;

  /// The first user post that is different
  /// from the next.
  final bool isFirstUserPost;

  /// The last user post that is different
  /// from the next.
  final bool isLastUserPost;

  /// Determine if it is first
  /// item division of item
  /// has been occurred.
  final bool isFirstTimeDiff;

  /// Determine if it is the last
  /// item where division of the item
  /// occurred.
  final bool isLastTimeDiff;

  /// The batching status if the
  /// Current position.
  ChatBatchingStatus({
    required this.isSafe,
    required this.isMostRecent,
    required this.isOldestItem,
    required this.isFirstTimeDiff,
    required this.isLastTimeDiff,
    required this.isLastUserPost,
    required this.isFirstUserPost,
  });
}

/// Chat batcher that will
/// batch chat based on certain
/// condition such as time stamp etc.
class ChatBatcher<T extends Model> extends StatelessWidget {
  /// The list of items to be batched.
  final List<T> items;

  /// The current position of the item.
  final int index;

  /// The footer bottom of the chat.
  /// This is sometimes used for listing
  /// who has read the chat.
  final Widget? footer;

  /// The builder for creating the widget.
  final Widget Function(ChatBatchingStatus) builder;

  /// Determine the user ID
  /// of the chat.
  ///
  /// For example:
  ///
  /// """
  /// fromUserId: (chat) => chat.user.id
  /// """
  final String Function(T) fromUserId;

  /// Time stamp widget.
  final Widget? timestampWidget;

  /// Chat batcher that will
  /// batch chat based on certain
  /// condition such as time stamp etc.
  ChatBatcher({
    required this.items,
    required this.index,
    required this.builder,
    required this.fromUserId,
    this.footer,
    this.timestampWidget,
  });

  @override
  build(context) => _chatBubble();

  Widget _chatBubble() {
    /// Check if it is safe.
    var isSafe = items.length > 2 && items.length - 2 >= index;

    /// For whether to show the name bubble.
    var isLastIndex = 0 == index;
    var isFirstIndex = items.length - 1 == index;

    /// Calculate of the time and padding.
    var diff = items[index]
        .timestamp!
        .difference(items[isSafe ? index + 1 : index].timestamp!)
        .inMinutes;
    var isLongTime = diff > 1;
    var isLastUserPostTimeDiff = (index != 0 &&
        (items[isSafe ? index - 1 : index]
                .timestamp!
                .difference(items[index].timestamp!)
                .inMinutes >
            1));

    /// Calculate for detecting the last year post.
    var isSameUser = this.fromUserId(items[isSafe ? index + 1 : index]) ==
        this.fromUserId(items[index]);
    var isLastUserPost = (index != 0 &&
        (this.fromUserId(items[index]) !=
            this.fromUserId(items[isSafe ? index - 1 : index])));
    var isFirstUserPost = (index != 0 &&
        (this.fromUserId(items[index]) !=
            this.fromUserId(items[isSafe ? index + 1 : index])));

    /// Check if last comment.
    return Column(children: <Widget>[
      /// Padding if not the same user.
      (isSafe && !isSameUser && !isLongTime)
          ? SizedBox(height: 10)
          : Container(),

      /// Show time based on time diff
      (isSafe && isLongTime)
          ? this.timestampWidget ??
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                      items[index].timestamp!.toDynamicTime(isTwelveHour: true),
                      textScaleFactor: 0.8,
                      style: TextStyle(color: Colors.grey)))
          : Container(),

      /// Build the widget.
      this.builder(ChatBatchingStatus(
          isSafe: isSafe,
          isMostRecent: isLastIndex,
          isOldestItem: isFirstIndex,
          isFirstTimeDiff: isLongTime,
          isLastTimeDiff: isLastUserPostTimeDiff,
          isFirstUserPost: isFirstUserPost,
          isLastUserPost: isLastUserPost)),

      /// Last seen avatar
      (index == 0) ? this.footer ?? Container() : Container(),
    ]);
  }
}
