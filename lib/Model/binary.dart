class BinaryNode {
  int? value;
  BinaryNode? left;
  BinaryNode? right;

  BinaryNode({this.value, this.left, this.right});

  @override
  String toString() {
    String text = "";
    text = text + "Value " + value.toString();
    if (right != null) {
      text = text + " Right : " + right!.value.toString();
    } else {
      text = text + " Right : NULL";
    }
    if (left != null) {
      text = text + " Left : " + left!.value.toString();
    } else {
      text = text + " Left : NULL";
    }
    return text;
  }
}
