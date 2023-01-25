import 'package:flutter/material.dart';

class PagingGridCustom extends StatefulWidget {
  const PagingGridCustom({
    Key? key,
    this.onRefresh,
    this.onScrollDown,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 10.0,
    this.mainAxisSpacing = 10.0,
    this.physics,
    this.shrinkWrap = false,
    this.isEmpty = false,
    required this.crossAxisCount,
    required this.childWidget,
  }) : super(key: key);

  final bool isEmpty;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final ValueChanged<int>? onScrollDown;
  final ValueChanged<int>? onRefresh;
  final List<Widget> childWidget;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  @override
  _PagingListState createState() => _PagingListState();
}

class _PagingListState extends State<PagingGridCustom>
    with SingleTickerProviderStateMixin {
  int _page = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (widget.isEmpty) {
        return;
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page++;
        if (widget.onScrollDown != null) {
          widget.onScrollDown!(_page);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _page = 1;
        if (widget.onRefresh != null) widget.onRefresh!(_page);
      },
      child: GridView.count(
        controller: _scrollController,
        childAspectRatio: widget.childAspectRatio,
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: widget.crossAxisSpacing,
        mainAxisSpacing: widget.mainAxisSpacing,
        shrinkWrap: widget.shrinkWrap,
        physics: widget.physics ?? const AlwaysScrollableScrollPhysics(),
        children: widget.childWidget,
      ),
    );
  }
}
