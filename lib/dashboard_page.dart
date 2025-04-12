// import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

// class DashboardPage extends StatefulWidget {
//   final token;
//   const DashboardPage({super.key, this.token});

//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   late String email;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
//     email = jwtDecodedToken['email'];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(email),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Future<void> _displayTextInputDialog(BuildContext context) async {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//           title: Text('Add To-Do'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 // controller: _todoTitle,
//                 keyboardType: TextInputType.text,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   hintText: "Title",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(10),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () async {
//                   String task = await _displayTextInputDialog(context);
//                   if (task.isEmpty) return;
//                   // Add task to the list
//                 },
//                 child: Text('Add'),
//               ),
//             ],
//           ));
//     },
//   );
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_frontend_app/config.dart';

class DashboardPage extends StatefulWidget {
  final token;
  const DashboardPage({required this.token, Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late String userId;
  TextEditingController _todoTitle = TextEditingController();
  TextEditingController _todoDesc = TextEditingController();
  List? items;
  // final List<String> items = new List<String>.generate(
  //   10,
  //   (index) => "item ${index + 1}",
  // );

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    getTodoList(userId);
  }

  void addTodo() async {
    if (_todoTitle.text.isNotEmpty && _todoDesc.text.isNotEmpty) {
      var regBody = {
        "userId": userId,
        "title": _todoTitle.text,
        "desc": _todoDesc.text,
      };
      var response = await http.post(
          // Uri.parse(addTodo),
          // Uri.parse(addTodo as String),
          Uri.parse('http://localhost:4000/storeTodo'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status']) {
        _todoTitle.clear();
        _todoDesc.clear();
        Navigator.pop(context);
        getTodoList(userId);
      } else {
        print("Something went wrong");
      }
    }
  }


  void getTodoList(userId) async {
    var regBody = {"userId": userId};

    var response = await http.post(
      Uri.parse(getToDoList),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    var jsonResponse = jsonDecode(response.body);

    items = jsonResponse['success'];

    setState(() {});
  }

  void deleteItem(String id) async {
    var regBody = {"id": id};
    var response = await http.post(
      Uri.parse(deleteTodo),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      getTodoList(userId);
    }

  }


  // void deleteItem(String id) async {
  //   var regBody = {"id": id};

  //   var response = await http.post(
  //     Uri.parse(deleteTodo),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode(regBody),
  //   );

  //   var jsonResponse = jsonDecode(response.body);
  //   if (jsonResponse['status']) {
  //     getTodoList(userId);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.list,
                    size: 30.0,
                  ),
                  backgroundColor: Colors.white,
                  radius: 30.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  'ToDo with NodeJS + MongoDB',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8.0),
                Text('Tasks', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: items == null
                    ? Center(child: CircularProgressIndicator())
                    // ? null
                    : ListView.builder(
                        itemCount: items!.length,
                        itemBuilder: (context, int index) {
                          return Slidable(
                            key: ValueKey(items![index]['_id']),
                            // key: const ValueKey(0),
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              dismissible: DismissiblePane(onDismissed: () {}),
                              children: [
                                SlidableAction(
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  onPressed: (BuildContext context) {
                                    deleteItem(items![index]['_id']);
                                    // print('${items![index]}');    
                                  },
                                ),
                              ],
                            ),
                            child: Card(
                              borderOnForeground: false,
                              child: ListTile(
                                leading: Icon(Icons.task),
                                title: Text('${items![index]['title']}'),
                                subtitle: Text('${items![index]['desc']}'),
                                trailing: Icon(Icons.arrow_forward),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayTextInputDialog(context),
        child: Icon(Icons.add),
        tooltip: 'Add ToDo',
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add To-Do'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _todoTitle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _todoDesc,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    addTodo();
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          );
        });
  }
}
