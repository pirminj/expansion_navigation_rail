import 'package:flutter/material.dart';

enum ExpansionMode { shift, overlap }

class ExpansionNavigationRail extends StatefulWidget {
  const ExpansionNavigationRail({
    Key? key,
    required this.destinations,
    required this.selectedIndex,
    required this.child,
    this.onDestinationSelected,
    this.minWidth,
    this.closeOnSelection = false,
    this.expansionMode = ExpansionMode.overlap,
  }) : super(key: key);

  final List<NavigationRailDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final double? minWidth;
  final Widget child;
  final bool closeOnSelection;
  final ExpansionMode expansionMode;

  static _ExpansionNavigationRailState? of(BuildContext context) =>
      context.findAncestorStateOfType<_ExpansionNavigationRailState>();

  @override
  _ExpansionNavigationRailState createState() =>
      _ExpansionNavigationRailState();
}

class _ExpansionNavigationRailState extends State<ExpansionNavigationRail> {
  bool _extended = false;

  void expand() {
    setState(() {
      _extended = true;
    });
  }

  void collapse() {
    setState(() {
      _extended = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget rail = MouseRegion(
      onEnter: (event) => expand(),
      onExit: (event) => collapse(),
      child: NavigationRail(
        destinations: widget.destinations,
        extended: _extended,
        onDestinationSelected: (int index) {
          if (widget.closeOnSelection) collapse();
          if (widget.onDestinationSelected != null)
            widget.onDestinationSelected!(index);
        },
        selectedIndex: widget.selectedIndex,
        minWidth: widget.minWidth,
      ),
    );

    switch (widget.expansionMode) {
      case ExpansionMode.shift:
        return Row(
          children: [
            rail,
            Expanded(
              child: widget.child,
            ),
          ],
        );
      case ExpansionMode.overlap:
        return Stack(
          children: [
            SafeArea(
              minimum: EdgeInsets.only(left: widget.minWidth ?? 72),
              child: widget.child,
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: rail,
            ),
          ],
        );
    }
  }
}
