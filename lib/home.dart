import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gsoctask/get_data.dart';
import 'package:gsoctask/provider.dart';

class InitialScreen extends ConsumerWidget {
  InitialScreen({Key? key, required this.client}) : super(key: key);
  final HttpClient client;
  late WebSocket socket;

  @override
  Widget build(BuildContext context, ref) {
    final sockConnect = ref.watch(sockConnectprovider(client));

    return sockConnect.when(
      data: (socket) {
        this.socket = socket;
        this.socket.pingInterval = const Duration(seconds: 2);
        return OnBoardingPage(client: client, socket: this.socket);
      },
      error: (e, stk) {
        print(e);
        // Future.delayed(const Duration(milliseconds: 700), (() {
        //   ref.refresh(sockConnectprovider(client));
        // }));
        return Home(
          isConnected: false,
        );
      },
      loading: () => const Scaffold(
          backgroundColor: Colors.black, body: CircularProgressIndicator()),
    );
  }
}

class OnBoardingPage extends ConsumerStatefulWidget {
  const OnBoardingPage({Key? key, required this.client, required this.socket})
      : super(key: key);
  final WebSocket socket;
  final HttpClient client;

  @override
  ConsumerState<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends ConsumerState<OnBoardingPage> {
  @override
  void initState() {
    super.initState();
    VISS.init(widget.socket, ref);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.socket.listen(
        (data) {
          // print(data);
          VISS.parseData(ref, data);
        },
        onError: (e, stk) {
          print(e.toString());
          ref.refresh(sockConnectprovider(widget.client));
        },
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.socket.close(786887, "Connection lost with server!");
  }

  @override
  Widget build(BuildContext context) => Home(isConnected: true);
}

class Home extends ConsumerWidget {
  Home({Key? key, required this.isConnected}) : super(key: key);
  bool isConnected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speedprovider = ref.watch(speedProvider);

    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: const Text("Test App"),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Center(
            //   child: CircleAvatar(
            //     backgroundColor: Colors.white,
            //     radius: 40.0,
            //     backgroundImage: NetworkImage(
            //         "https://cdn-icons-png.flaticon.com/512/67/67902.png"),
            //   ),
            // ),
            const Divider(
              height: 60.0,
              color: Colors.grey,
            ),
            const Text(
              'Name',
              style: TextStyle(
                  color: Colors.grey, letterSpacing: 2.0, fontSize: 15.0),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Anuj Solanki',
              style: TextStyle(
                  color: Colors.orangeAccent,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.0),
            const Text(
              'College',
              style: TextStyle(
                  color: Colors.grey, letterSpacing: 2.0, fontSize: 15.0),
            ),
            SizedBox(height: 10.0),
            const Text(
              'IIT Mandi',
              style: TextStyle(
                  color: Colors.orangeAccent,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            const Text(
              'Branch',
              style: TextStyle(
                  color: Colors.grey, letterSpacing: 2.0, fontSize: 15.0),
            ),
            SizedBox(height: 10.0),
            const Text(
              'CSE',
              style: TextStyle(
                  color: Colors.orangeAccent,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.0),
            Row(
              children: const <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "b21151@students.iitmandi.ac.in",
                  style: TextStyle(color: Colors.grey, fontSize: 15.0),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              children: const <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "anuj603362@gmail.com",
                  style: TextStyle(color: Colors.grey, fontSize: 15.0),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            if(isConnected) Text(
              "Speed: ${speedprovider.speed}",
              style: TextStyle(
                  color: Colors.orangeAccent,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
