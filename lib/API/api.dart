// ignore_for_file: prefer_conditional_assignment, curly_braces_in_flow_control_structures

import 'package:data2binary/Model/binary.dart';

class API {
  BinaryNode? getBinaryTree(List<int> array) {
    BinaryNode? rootNode;
    for (int i in array) {
      //Check if Root node is null
      if (rootNode == null)
        rootNode = BinaryNode(right: null, left: null, value: i);
      else {
        //Call function that will traverse the binary tree and put it in correct position
        _traverseAndSetData(i, rootNode);
      }
    }
    printTree(rootNode!);
    return rootNode;
  }

  void _traverseAndSetData(int value, BinaryNode parentNode) {
    //Check if value is > or < than parentNode.value
    if (value > parentNode.value!) {
      //Right side of the tree

      //Check if right node child exists on parent
      if (parentNode.right != null) {
        //Right child exists so we need to treat it as the next parent and do recursion
        _traverseAndSetData(value, parentNode.right!);
      } else {
        //Right child doesn't exist so we can set it as the right child
        BinaryNode right = BinaryNode(value: value, right: null, left: null);
        parentNode.right = right;
      }
    } else {
      //Left side of the tree

      //Check if left node exists on parent
      if (parentNode.left != null) {
        //Left child exists so we need to treat it as the next parent and do recursion
        _traverseAndSetData(value, parentNode.left!);
      } else {
        //Left child doesn't exist so we can set it as the left child
        BinaryNode left = BinaryNode(left: null, right: null, value: value);
        parentNode.left = left;
      }
    }
  }

  void printTree(BinaryNode root) {
    root.toString();
    if (root.right != null) {
      printTree(root.right!);
    }
    if (root.left != null) {
      printTree(root.left!);
    }
  }
}
