import 'package:flutter/material.dart';
import 'functions/notion.dart';

class ClaimItemCheckScreen extends StatefulWidget {
  const ClaimItemCheckScreen({super.key, required this.passcode});
  final String passcode;
  @override
  State<ClaimItemCheckScreen> createState() => _ClaimItemCheckScreenState();
}

class _ClaimItemCheckScreenState extends State<ClaimItemCheckScreen> {
  final _passcodeController = TextEditingController();
  late final Future claimInfo;

  @override
  void initState() {
    super.initState();
    claimInfo = queryWithPasscode(widget.passcode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: Icon(
          Icons.home,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Padding(
        padding: const EdgeInsets.only(left: 80.0, top: 80),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("請確認以下資訊是否正確？", style: TextStyle(fontSize: 60)),
              Spacer(),
              FutureBuilder(
                  future: claimInfo,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Card(
                        child: Container(
                          padding: EdgeInsets.all(40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('領取物品：${snapshot.data[0]}',
                                  style: TextStyle(
                                    fontSize: 30,
                                  )),
                              Text('領取人：${snapshot.data[1]}',
                                  style: TextStyle(
                                    fontSize: 30,
                                  ))
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0, bottom: 80),
                      child: SizedBox(
                        height: 80,
                        width: 160,
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.background),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              size: 45,
                            ),
                            label: Text("錯誤")),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 80.0, bottom: 80),
                      child: SizedBox(
                        height: 80,
                        width: 160,
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.background),
                            onPressed: () {},
                            icon: Icon(
                              Icons.check,
                              size: 45,
                            ),
                            label: Text("確認")),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
