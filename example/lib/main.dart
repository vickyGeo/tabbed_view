import 'package:flutter/material.dart';
import 'package:tabbed_view/tabbed_view.dart';

void main() {
  runApp(TabbedViewExample());
}

class TabbedViewExample extends StatelessWidget {
  const TabbedViewExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: TabbedViewExamplePage());
  }
}

class TabbedViewExamplePage extends StatefulWidget {
  const TabbedViewExamplePage({Key? key}) : super(key: key);

  @override
  TabbedViewExamplePageState createState() => TabbedViewExamplePageState();
}

class TabbedViewExamplePageState extends State<TabbedViewExamplePage> {
  late TabbedViewController _controller;

  @override
  void initState() {
    super.initState();
    List<TabData> tabs = [];

    tabs.add(TabData(
        text: 'Tab 1',
        isloading: true,
        textColor: Colors.amber,
        buttons: [
          TabButton(
              icon: IconProvider.path(TabbedViewIcons.menu),
              menuBuilder: (context, tabIndex) => [
                    TabbedViewMenuItem(
                        text: "Delete left",
                        onSelection: () {
                          _controller.sublist(tabIndex);
                        })
                  ])
        ],
        leading: (context, status) => Icon(Icons.star, size: 16),
        content: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('Hello'),
                ElevatedButton(onPressed: () {}, child: Text("test"))
              ],
            ))));
    tabs.add(TabData(
        text: 'Tab 2',
        textColor: Colors.amber,
        buttons: [
          TabButton(
              icon: IconProvider.path(TabbedViewIcons.menu),
              menuBuilder: (context, tabIndex) {
                return [
                  TabbedViewMenuItem(
                      text: "Delete left",
                      onSelection: () {
                        // List<TabData> rightSide = tabs.sublist(1);
                        _controller.sublist(tabIndex);
                        // _controller.setTabs(rightSide);
                        // _controller.selectedIndex = 0;
                      })
                ];
              })
        ],
        content:
            Padding(padding: EdgeInsets.all(8), child: Text('Hello again'))));
    tabs.add(TabData(
        closable: false,
        text: 'TextField',
        buttons: [
          TabButton(
              icon: IconProvider.path(TabbedViewIcons.menu),
              menuBuilder: (context, tabIndex) => [
                    TabbedViewMenuItem(
                        text: "Delete left",
                        onSelection: () {
                          _controller.sublist(tabIndex);
                        })
                  ])
        ],
        content: Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
                decoration: InputDecoration(
                    isDense: true, border: OutlineInputBorder()))),
        keepAlive: true));

    _controller = TabbedViewController(tabs);
  }

  @override
  Widget build(BuildContext context) {
    TabbedView tabbedView = TabbedView(
      controller: _controller,
      loadingWidget: CircularProgressIndicator(),
      selectToEnableButtons: false,
    );
    Widget w =
        TabbedViewTheme(data: TabbedViewThemeData.mobile(), child: tabbedView);
    return Scaffold(body: Container(padding: EdgeInsets.all(32), child: w));
  }
}
