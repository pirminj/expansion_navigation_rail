import 'package:flutter/material.dart';

import 'package:expansion_navigation_rail/expansion_navigation_rail.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  bool _closeOnSelection = false;
  ExpansionMode _expansionMode = ExpansionMode.overlap;

  final List<Color> backgroundColors = [
    Colors.blue[50]!,
    Colors.orange[50]!,
    Colors.red[50]!,
  ];

  @override
  Widget build(BuildContext context) {
    final headlineStyle = Theme.of(context).textTheme.headline6!;
    return Scaffold(
      backgroundColor: backgroundColors[_index],
      body: ExpansionNavigationRail(
        selectedIndex: _index,
        onDestinationSelected: (index) {
          setState(() {
            _index = index;
          });
        },
        closeOnSelection: _closeOnSelection,
        expansionMode: _expansionMode,
        destinations: [
          NavigationRailDestination(
            icon: Icon(Icons.ac_unit),
            label: Text('Snow'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.wb_twighlight),
            label: Text('Sunrise'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.wine_bar),
            label: Text('Wine'),
          ),
        ],
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Options to play with',
                    style: headlineStyle,
                  ),
                ),
                ...ListTile.divideTiles(
                  context: context,
                  tiles: [
                    SwitchListTile(
                      title: Text('Close on selection'),
                      value: _closeOnSelection,
                      onChanged: (value) => setState(() {
                        _closeOnSelection = value;
                      }),
                    ),
                    Column(
                      children: [
                        RadioListTile<ExpansionMode>(
                          title: Text(ExpansionMode.overlap.toString()),
                          value: ExpansionMode.overlap,
                          groupValue: _expansionMode,
                          onChanged: (value) => setState(() {
                            _expansionMode = value!;
                          }),
                        ),
                        RadioListTile<ExpansionMode>(
                          title: Text(ExpansionMode.shift.toString()),
                          value: ExpansionMode.shift,
                          groupValue: _expansionMode,
                          onChanged: (value) => setState(() {
                            _expansionMode = value!;
                          }),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Access it from anywhere with ',
                          style: headlineStyle,
                        ),
                        TextSpan(
                          text: 'ExpansionNavigationRail.of(context)',
                          style: headlineStyle.copyWith(
                            backgroundColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ExpandCollapseButtonBar()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExpandCollapseButtonBar extends StatelessWidget {
  const ExpandCollapseButtonBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rail = ExpansionNavigationRail.of(context);
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => rail?.expand(),
          child: Text('Expand'),
        ),
        ElevatedButton(
          onPressed: () => rail?.collapse(),
          child: Text('Collapse'),
        ),
      ],
    );
  }
}
