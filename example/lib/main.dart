import 'package:example/pagination.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_appkit/riverpod_appkit.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod AppKit Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Riverpod AppKit Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body:
            const IntegerList() // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class IntegerList extends PagedContentList<int> {
  const IntegerList({super.key});

  @override
  Widget buildContent(BuildContext context, WidgetRef ref, int content,
          bool isLast, int? previousContent, int? nextContent) =>
      Card(
        key: ValueKey(content),
        child: ListTile(
          title: Text('$content'),
        ),
      );

  @override
  Widget buildEmpty(BuildContext context, WidgetRef ref) =>
      const Center(child: Text('No data'));

  @override
  Widget buildError(BuildContext context, WidgetRef ref, Object? error) =>
      const Center(child: Text('Error'));

  @override
  Widget buildLoading(BuildContext context, WidgetRef ref, bool isListItem) =>
      isListItem
          ? const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: CupertinoActivityIndicator(),
              ),
            )
          : const Center(child: Text('Loading...'));

  @override
  Refreshable<PagedContent<int>> getProvider(
          BuildContext context, WidgetRef ref) =>
      integerPaginationControllerProvider;

  @override
  void loadMore(BuildContext context, WidgetRef ref) {
    ref.read(integerPaginationControllerProvider.notifier).loadMore();
  }
}
