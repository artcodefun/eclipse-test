import 'package:flutter/material.dart';

class HalfFixedScrollView extends StatelessWidget {
  const HalfFixedScrollView(
      {Key? key,
      required this.fixedPart,
      this.footerPart = const [],
      required this.builder,
      required this.buildChildrenCount})
      : super(key: key);

  final List<Widget> fixedPart;
  final List<Widget> footerPart;
  final Widget Function(BuildContext, int) builder;
  final int buildChildrenCount;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(delegate: SliverChildListDelegate(fixedPart)),
        SliverList(
            delegate: SliverChildBuilderDelegate(builder,
                childCount: buildChildrenCount)),
        SliverList(delegate: SliverChildListDelegate(footerPart))
      ],
    );
  }
}
