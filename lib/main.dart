import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page/Focus.dart';
import 'package:flutter_app/page/Form.dart';
import 'package:flutter_app/page/Progress.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 注册路由表
      routes: {
        "new_page": (context) => NewRoute(),
        "/": (context) => MyHomePage(title: "Flutter Demo Home Page"),
        "focus": (context) => FocusTestRoute(),
        "form": (context) => FormTestRoute(),
        "progress": (context) => ProgressRoute()
      },
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // const TextSpan({
  //   TextStyle style,
  //   String text,
  //   List<TextSpan> children,
  //   GestureRecognizer recognizer,
  // })

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "hello flutter" * 6,
              textAlign: TextAlign.center,
              textScaleFactor: 1.5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  height: 1.2,
                  fontFamily: "Courier",
                  background: new Paint()..color = Colors.yellow,
                  decoration: TextDecoration.lineThrough,
                  decorationStyle: TextDecorationStyle.dashed),
            ),
            // Text.rich(
            //   TextSpan(
            //     children: [
            //       TextSpan(
            //         text: "Home:"
            //       ),
            //       TextSpan(
            //         text: "https://baidu.com",
            //         style: TextStyle(
            //           color: Colors.blue
            //         ),
            //         // recognizer: _tapRecognizer
            //       )
            //     ]
            //   )
            // ),
            RaisedButton(
              onPressed: () {},
              color: Colors.blue,
              textColor: Colors.yellow,
              child: Text("normal"),
            ),
            RaisedButton.icon(
                onPressed: () {}, icon: Icon(Icons.send), label: Text("发送")),
            FlatButton(
              child: Text("open new route"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed("new_page", arguments: "hi");
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return NewRoute();
                // }));
              },
            ),
            RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("focus");
                },
                child: Text("焦点控制")),
            RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("form");
                },
                child: Text("表单校验")),
            RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("progress");
                },
                child: Text("进度条")),
            RandomWordsWidget()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// 路由跳转
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Route")),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({
    Key key,
    @required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: () => Navigator.pop(context, "我是返回值"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 新建路由测试
class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          // 打开`TipRoute`,并等待返回结果
          var result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return TipRoute(
              text: "我是提示xxx",
            );
          }));
          print("路由返回值：$result");
        },
        child: Text("打开提示页"),
      ),
    );
  }
}

// 路由带参跳转
class EchoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(args)),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

// 引入english_words
class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}
