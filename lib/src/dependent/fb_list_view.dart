import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as _fs;
import 'package:firebase_database/firebase_database.dart' as _db;
import 'package:dart_util/dart_util.dart';
import 'package:provider_skeleton/provider_skeleton.dart';

/// The list view type that can be used.
enum _Type { realtimeDatabase, cloudFirestore }

/// Schmick list view containing the smart
/// refresher where you can refresh the page.
class FBListView<T extends Model> extends StatefulWidget {
  /// The list view type.
  final _Type _type;

  /// Widget of when the list is empty.
  final Widget onEmptyList;

  /// The widget builder of each tile in the list.
  /// The builder callbacks the index and the model.
  final Widget Function(List<T>, int) builder;

  /// Determine is the list view is reverse.
  final bool isReverse;

  /// Inner padding of the list view.
  final EdgeInsetsGeometry padding;

  /// Loader.
  final Widget loaderWidget;

  /// The list view scroll controller.
  final ScrollController controller;

  /// Compare function to order the list.
  final int Function(T, T) orderBy;

  /// Fetch delay on initialize state in milliseconds.
  final int fetchDelay;

  /// If this set to true, it will show the empty list.
  /// This is meant for debugging purposes.
  final bool debugEmptyList;

  /* -------------------------------- Firestore ------------------------------- */

  /// Firestore query.
  final _fs.Query fsQuery;

  /// When snap is received. For each data
  /// that that has been received should convert the
  /// snapshot into an object.
  final Future<T> Function(_fs.DocumentSnapshot) forEachSnap;

  /* -------------------------------- Firebase -------------------------------- */

  /// Query for the list view, you can
  /// also used reference.
  final _db.Query dbQuery;

  /// You can use database reference where
  /// it will will create query limit of 30
  /// based on recent timestamp. If you want
  /// a manual query use [dbQuery]. If [dbQuery]
  /// exist it will use that instead. if this
  /// is not null it will to listen new
  /// data.
  final _db.DatabaseReference dbReference;

  /// When snap is received. For each data
  /// that that has been received should convert the
  /// snapshot into an object.
  final Future<T> Function(String id, Map<String, dynamic> json) forEachJson;

  /* ------------------------------- Constructor ------------------------------ */

  /// List view for Firestore.
  FBListView.cloudFirestore({
    @required this.fsQuery,
    @required this.builder,
    @required this.forEachSnap,
    this.onEmptyList,
    this.orderBy,
    this.loaderWidget,
    this.padding,
    this.controller,
    this.isReverse = false,
    this.fetchDelay = 0,
    this.debugEmptyList = false,
  })  : _type = _Type.cloudFirestore,
        this.dbQuery = null,
        this.forEachJson = null,
        this.dbReference = null;

  /// List view for Firebase DB
  FBListView.realtimeDatabase({
    this.dbQuery,
    this.dbReference,
    @required this.builder,
    @required this.forEachJson,
    this.onEmptyList,
    this.orderBy,
    this.loaderWidget,
    this.padding,
    this.controller,
    this.isReverse = false,
    this.fetchDelay = 0,
    this.debugEmptyList = false,
  })  : assert(!(dbQuery == null && dbReference == null)),
        _type = _Type.realtimeDatabase,
        this.fsQuery = null,
        this.forEachSnap = null;

  /// The header of when refreshing a page.
  static Widget waterDropHeader({
    Color color = Colors.black,
    Color backgroundColor = Colors.white,
  }) =>
      WaterDropHeader(
          waterDropColor: backgroundColor,
          idleIcon: Icon(Icons.autorenew, size: 15, color: color));

  /// The footer of when paginating to the next page.
  static Widget emptyFooter() => CustomFooter(builder: (context, status) {
        if (status == LoadStatus.loading)
          return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[CircularProgressIndicator()]);
        return Container();
      });

  @override
  _FBListViewState<T> createState() => _FBListViewState<T>();
}

class _FBListViewState<T extends Model> extends State<FBListView<T>>
    with UniquifyListModel {
  RefreshController _refreshController;
  _fs.DocumentSnapshot _lastSnap;
  StreamSubscription _cloudFirestoreSubscription;
  StreamSubscription _realtimeDatabaseSubscription;
  bool _isLoading = false;
  static const _FAILED_FETCH_MESSAGES =
      "Sorry Something went wrong, failed to fetch data at this time. " +
          'Please try again later.';

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);
    if (this.widget._type == _Type.cloudFirestore)
      replaceItems(await _firestoreFetch());
    else if (this.widget._type == _Type.realtimeDatabase)
      replaceItems(await _realtimeDatabaseFetch());
    if (this.widget.orderBy != null) items.sort(this.widget.orderBy);
    setState(() => _isLoading = false);
    _refreshController?.refreshToIdle();
  }

  Future<void> _onLoading() async {
    if (this.widget._type == _Type.cloudFirestore)
      addItems(await _firestoreFetch(isNext: true));
    else if (this.widget._type == _Type.realtimeDatabase)
      addItems(await _realtimeDatabaseFetch(isNext: true));
    if (this.widget.orderBy != null) items.sort(this.widget.orderBy);
    setState(() => _isLoading = false);
    _refreshController?.loadComplete();
  }

  Future<void> _realtimeDatabaseListen() async {
    _realtimeDatabaseSubscription = this
        .widget
        ?.dbReference
        ?.endAt(items?.first?.id)
        ?.onChildAdded
        ?.listen((event) async {
      Log(this, "_realtimeDatabaseListen(): listen = ${event.snapshot.value}");
      addItems([
        await this.widget.forEachJson(
            event.snapshot.key, Map<String, dynamic>.from(event.snapshot.value))
      ]);
      setState(() => _isLoading = false);
    });
  }

  Future<void> _cloudFirestoreListen() async {
    _cloudFirestoreSubscription =
        this.widget.fsQuery.snapshots().listen((data) async {
      addItems(List<T>.from(
          await Future.wait<T>(data.documentChanges.map((docChange) async {
            var data = await this.widget.forEachSnap(docChange.document);
            Log(this, "Listen for new data: $data");
            return data;
          })),
          growable: true));
      if (this.widget.orderBy != null) items.sort(this.widget.orderBy);
      setState(() => _isLoading = false);
    });
  }

  Future<List<T>> _realtimeDatabaseFetch({bool isNext = false}) async {
    List<T> data = [];
    try {
      var query = this.widget.dbQuery ??
          this.widget.dbReference.orderByKey().limitToLast(30);
      if (isNext) query = query.endAt(items.last.id);
      var snap = await query.once();
      var jsonObj = Map<String, dynamic>.from(snap.value);
      data = await Future.wait<T>(jsonObj.entries.toList().map((each) async =>
          await this
              .widget
              .forEachJson(each.key, Map<String, dynamic>.from(each.value))));
    } catch (err) {
      if (isNext) _refreshController?.loadNoData();
      Result.hasError(
          clientMessage: _FAILED_FETCH_MESSAGES,
          devMessage: Log.asString(this, 'firebase fetch(): $err'),
          errorType: null);
    }
    return data;
  }

  Future<List<T>> _firestoreFetch({bool isNext = false}) async {
    List<T> data = [];
    try {
      var query = this.widget.fsQuery;
      if (isNext && _lastSnap != null)
        query = query.startAfterDocument(_lastSnap);
      var doc = await query.getDocuments();
      _lastSnap = doc.documents.last;
      data = await Future.wait<T>(doc?.documents?.map(this.widget.forEachSnap));
    } catch (err) {
      if (isNext) _refreshController?.loadNoData();
      Result.hasError(
          errorType: ErrorTypes.server,
          devMessage: Log.asString(this, 'firestore fetch(): $err'),
          clientMessage: _FAILED_FETCH_MESSAGES);
    }
    return data;
  }

  @override
  void initState() {
    _refreshController = RefreshController();
    this.widget.padding ?? EdgeInsets.all(0);
    super.initState();
    setState(() => _isLoading = true);
    Future.delayed(Duration(milliseconds: this.widget.fetchDelay))
        .then((_) => _onRefresh().then((_) {
              if (this.widget._type == _Type.cloudFirestore)
                _cloudFirestoreListen();
              if (this.widget._type == _Type.realtimeDatabase)
                _realtimeDatabaseListen();
            }));
  }

  @override
  void dispose() {
    _cloudFirestoreSubscription?.cancel();
    _realtimeDatabaseSubscription?.cancel();
    _refreshController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SmartRefresher(
            reverse: this.widget.isReverse,
            controller: _refreshController,
            enablePullDown: this.widget.isReverse ? false : true,
            enablePullUp: true,
            header: FBListView.waterDropHeader(),
            footer: FBListView.emptyFooter(),
            onRefresh: () => _onRefresh(),
            onLoading: () => _onLoading(),
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Decide.from<Widget>(() {
              if (_isLoading) return this.widget.loaderWidget ?? Container();
              if (this.widget.debugEmptyList) return this.widget.onEmptyList;
              if (items.length == 0)
                return this.widget.onEmptyList ??
                    Center(child: Text('Empty list'));
              return ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  controller: this.widget.controller,
                  padding: this.widget.padding,
                  itemCount: items.length,
                  itemBuilder: (context, index) => this
                      .widget
                      .builder(List.castFrom<Model, T>(items), index));
            })));
  }
}
