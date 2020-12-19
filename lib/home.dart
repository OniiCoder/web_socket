import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  IOWebSocketChannel channel;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    connectSocket();
  }

  void connectSocket() {
    channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text('Web Socket Demo'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [

            SizedBox(height: 20,),
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: 'Enter message',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.indigoAccent,
                  )
                )
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  if(textEditingController.text != '') {
                    channel.sink.add(textEditingController.text);
                  }
                },
                color: Colors.indigoAccent,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            Container(
              child: StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  return Text(snapshot.hasData ? '${snapshot.data}' : '');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
