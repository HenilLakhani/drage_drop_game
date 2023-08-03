import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  bool dropped = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Drag & drop"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Draggable(
              data: "demo",
              child: Container(
                height: 150,
                width: 150,
                color: dropped ? Colors.grey : Colors.red,
              ),
              feedback: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(),
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 10,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
              ),
              childWhenDragging: Container(
                height: 150,
                width: 150,
                color: Colors.grey,
              ),
            ),
            DragTarget(
              builder: (context, _, __) => Container(
                height: 150,
                width: 150,
                alignment: Alignment.center,
                color: dropped ? Colors.red : Colors.grey,
                child: Text(
                  dropped ? "Item Dropped" : "Drop here",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              onWillAccept: (data) {
                return data == "demo";
              },
              onLeave: (val) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Missed !!"),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                  ),
                );
              },
              onAccept: (data) {
                setState(() {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  dropped = true;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
