// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_print, curly_braces_in_flow_control_structures, unrelated_type_equality_checks

import 'package:data2binary/API/api.dart';
import 'package:data2binary/Model/binary.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? num;
  late TextEditingController valueC;

  List<int> nums = [];

  API api = API();

  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  Graph graph = Graph()..isTree = true;

  @override
  void initState() {
    super.initState();
    valueC = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Field to enter number
          TextField(
            controller: valueC,
            decoration: InputDecoration(hintText: "Value"),
            onChanged: (value) {
              try {
                num = int.parse(value);
              }
              // ignore: unused_catch_clause
              on Exception catch (e) {
                //Clean controller
                valueC.clear();
              }
            },
            onSubmitted: (value) {
              if (num != null) {
                setState(() {
                  nums.add(num!);
                  generateNodes(api.getBinaryTree(nums)!, clear: true);
                  valueC.clear();
                  num = null;
                });
              }
            },
          ),

          //Show all the numbers
          Row(
            children: [
              Text("Nums : "),
              Row(
                children: List.generate(
                    nums.length, (i) => Text(nums[i].toString() + ", ")),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical, child: graphDecider())),
          )
        ],
      ),
    );
  }

  Widget rectangleWidget(int a) {
    return InkWell(
      onTap: () {},
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.blue, spreadRadius: 1),
            ],
          ),
          child: Text('Node $a')),
    );
  }

  Widget graphDecider() {
    if (graph.nodes.isEmpty || graph.edges.isEmpty) return Text(".....");
    return GraphView(
      graph: graph,
      algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
      builder: (Node node) {
        var val = node.key!.value as BinaryNode;
        return rectangleWidget(val.value!);
      },
      animated: true,
    );
  }

  Node generateNodes(BinaryNode bn, {bool clear = false}) {
    if (clear) {
      graph.edges.clear();
      graph.nodes.clear();
    }

    Node node = Node.Id(bn);

    //Check left child

    if (bn.left != null) {
      //Left child exists
      graph.addEdge(node, Node.Id(bn.left));
      print("Added left");

      bool found = false;
      for (Edge e in graph.edges) {
        if (e.source == node && e.destination == bn.left) found = true;
      }
      if (found == false) generateNodes(bn.left!);
    }
    if (bn.right != null) {
      //Right child exists
      graph.addEdge(node, Node.Id(bn.right));
      print("Added right");

      bool found = false;
      for (Edge e in graph.edges) {
        if (e.source == node && e.destination == bn.right) found = true;
      }
      if (found == false) generateNodes(bn.right!);
    }
    return node;
  }
}
