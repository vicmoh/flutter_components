import 'package:flutter/material.dart';
import '../independent/labels/icon_text.dart';

class SchmickPostCardSkeleton extends StatefulWidget {
  // For display information
  final String name;
  final String location;
  final String time;
  final String post;
  final String numberOfLikes;
  final String numberOfDislikes;
  final String numberOfComments;
  // Color
  final Color nameColor;
  final Color thumbUpColor;
  final Color thumbDownColor;
  final Color commentColor;
  // Hero
  final String heroTag;
  final bool isHeroExpanded;
  // Callback
  final Function() onLiked;
  final Function() onDisliked;
  final Function() onComment;
  final Function() onMoreOption;
  final Function() onCardTap;

  /// Post card for the user post.
  SchmickPostCardSkeleton({
    Key key,
    // Info
    @required this.name,
    @required this.location,
    @required this.time,
    @required this.post,
    this.numberOfLikes = '',
    this.numberOfDislikes = '',
    this.numberOfComments = '',
    // Hero
    @required this.heroTag,
    this.isHeroExpanded = false,
    // Color
    this.nameColor = Colors.grey,
    this.thumbUpColor = Colors.grey,
    this.thumbDownColor = Colors.grey,
    this.commentColor = Colors.grey,
    // Callback
    this.onLiked,
    this.onDisliked,
    this.onComment,
    this.onMoreOption,
    this.onCardTap,
  }) : super(key: key);

  // Build state
  _SchmickPostCardSkeletonState createState() =>
      _SchmickPostCardSkeletonState();
}

class _SchmickPostCardSkeletonState extends State<SchmickPostCardSkeleton> {
  double _cardWidth = 0;

  @override
  Widget build(BuildContext context) {
    return (widget.post == '')
        ? Container()
        : GestureDetector(
            onLongPress: this.widget.onMoreOption,
            onTap: widget.onCardTap,
            child: Hero(
                transitionOnUserGestures: true,
                tag: widget.heroTag,
                placeholderBuilder: (context, size, widget) =>
                    Opacity(opacity: 0, child: _card()),
                child: SingleChildScrollView(child: _card())));
  }

  /// The post card content
  Widget _card() {
    return Card(
        // Shape
        elevation: (widget.isHeroExpanded) ? 0 : 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

        // Get the card width and build the card
        child: LayoutBuilder(builder: (context, constraints) {
          // Get card width
          this._cardWidth = constraints?.maxWidth;

          // Return the card
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Top section
                    SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: this._topSection()),

                    // The location and times
                    SizedBox(height: 3),
                    this._topSubSection(constraints),

                    // The post section
                    SizedBox(height: 10),
                    this._postText(),

                    // The options and buttons
                    SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: this._cardOptions()),
                    SizedBox(height: 10),
                  ]));
        }));
  }

  /// The card options such as [onLiked] and [onDisliked]
  Row _cardOptions() {
    var text = (String label) => Material(
        color: Colors.transparent,
        child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)));

    // Return content
    return Row(children: <Widget>[
      /// Thumb up button
      IconText(
          icon: Icon(Icons.thumb_up, color: widget.thumbUpColor),
          onPressed: widget.onLiked,
          text: text(widget.numberOfLikes)),

      /// Thumb down button
      SizedBox(width: 15),
      IconText(
          icon: Icon(Icons.thumb_down, color: widget.thumbDownColor),
          onPressed: widget.onDisliked,
          text: text(widget.numberOfDislikes)),

      /// Comment button
      SizedBox(width: 5),
      Expanded(child: Container()),
      IconText(
          icon: Icon(Icons.comment, color: widget.commentColor),
          onPressed: widget.onComment,
          text: text(widget.numberOfComments)),
    ]);
  }

  /// The post text for the card
  Container _postText() {
    return Container(
        padding: EdgeInsets.only(left: 5),
        child: Material(
            color: Colors.transparent,
            child: (widget.isHeroExpanded)
                ? Text(widget.post, textScaleFactor: 1.2)
                : Text(widget.post,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14 * 1.2))));
  }

  /// The section which contains the location chip
  /// and the time.
  Widget _topSubSection(BoxConstraints constraints) {
    return Container(
        width: this._cardWidth,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Location chip
              Expanded(
                child: Container(
                  child: Wrap(direction: Axis.horizontal, children: <Widget>[
                    ActionChip(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        elevation: 2,
                        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
                        onPressed: () {},
                        // Avatar and label
                        avatar: Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey,
                        ),
                        label: Material(
                            color: Colors.transparent,
                            child: Text(widget.location,
                                overflow: TextOverflow.ellipsis, maxLines: 1))),
                  ]),
                ),
              ),

              // Time
              SizedBox(width: 10),
              Material(
                  color: Colors.transparent,
                  child: Text(widget.time,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey))),
            ]));
  }

  /// Top section of the card which contain
  /// [name] and more option icon
  Row _topSection() {
    return Row(children: <Widget>[
      // The name
      Expanded(
          child: Material(
              color: Colors.transparent,
              child: Text(widget.name,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: widget.nameColor, fontWeight: FontWeight.bold)))),

      // More option button
      GestureDetector(
          child: Icon(Icons.more_horiz), onTap: widget.onMoreOption),
    ]);
  }
}
