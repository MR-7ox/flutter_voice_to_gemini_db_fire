import 'package:flutter/material.dart';
import 'package:gigfind/dummydata.dart/dummy.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Home_Screen extends StatefulWidget {
  @override
  State<Home_Screen> createState() {
    return Home_ScreenState();
  }
}

/* class Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: dummyNotesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(dummyNotesList[index].name),
                    subtitle: Text(dummyNotesList[index].Date.toString()),
                    trailing: ,
                    selected: true,
                    selectedColor: Color.fromARGB(255, 48, 132, 202),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('hello'),
                Expanded(child: DraggableMic()),
                Text('hello'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}*/

class Home_ScreenState extends State<Home_Screen> {
  late SpeechToText _speech; // to intialise a varible later
  bool _isListening = false;
  bool _speechAvailable = false;
  var text = "Swipe to take note ";

  @override
  void initState() {
    super.initState();

    _initSpeech();
    /* speech = SpeechToText();
   final bool avail = await _speech.initialize();*/
  }

  Future<void> _initSpeech() async {
    _speech = SpeechToText();
    _speechAvailable = await _speech.initialize();
  }

  void _startlistening() async {
    if (_speechAvailable == true) {
      print('true');
      setState(() {
        _isListening = true;
        _speech.listen(
          onResult: ((val) {
            text = val.recognizedWords;
            print(text);
          }),
        );
      });
    } else {
      print("Not Listening ");
    }
  }

  Widget buildCard(String title, Color color) {
    return Card(
      elevation: 2,
      color: color,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // gridview count is used when we know the count of elemnts
            /* Flexible(
                child: GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(12, (indexValue) {
                    return Text('$indexValue');
                  }),
                ),
              ),*/
            Expanded(
              child: ListView.builder(
                itemCount: dummyNotesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(dummyNotesList[index].name),
                    subtitle: Text(dummyNotesList[index].Date.toString()),
                    trailing: Icon(Icons.note),
                    selected: true,
                    selectedColor: const Color.fromARGB(255, 48, 132, 202),
                    //selectedTileColor: const Color.fromARGB(255, 255, 192, 5),
                  );
                },
              ),
            ),

            DraggableMic(swipeCallback: _startlistening),
            SizedBox(height: 80), //expanded
            //Icon(Icons.mic, size: 15, color: Colors.deepPurpleAccent),
          ],
        ),
      ),
    );
  }
}

class DraggableMic extends StatefulWidget {
  final VoidCallback swipeCallback;
  DraggableMic({
    required this.swipeCallback,
  }); // we give callback inside parent class

  @override
  State<DraggableMic> createState() {
    return DraggableMicState();
  }
}

class DraggableMicState extends State<DraggableMic> {
  @override
  double dragVal = 0.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          dragVal += details.delta.dx; //dx dy axis so
          dragVal = dragVal.clamp(-100, 100);
          // print(dragVal);
        });
      },

      onHorizontalDragEnd: (details) {
        setState(() {
          if (dragVal > 0) {
            widget.swipeCallback;
          }
          dragVal = 0.0;
        });
      },

      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          color: Colors.grey[100],
          //margin: EdgeInsets.all(100),
          elevation: 8,
          shadowColor: const Color.fromARGB(255, 106, 210, 110),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),

          /*ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 1000,
            maxWidth: 1000,
            minHeight: 30,
            maxHeight: 30,)*/
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: widget.swipeCallback,
                child: Text('Swipe'),
              ),
              /*Transform.translate(
                offset: Offset(dragVal * 3, 0),
                child: Transform.rotate(
                  angle: 0 / 100,

                  child: Icon(Icons.mic, size: 50, color: Colors.grey[350]),
                ),
              ),

              // should be double
              Text('Swipe to record', style: TextStyle(color: Colors.black87)),*/
            ],
          ),
        ),
      ),
    );
  }
}
