import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final GestureTapCallback onSearchTap;
  final TextEditingController controller;
  final FocusNode focusNode;
  SearchTextField({this.controller, this.onSearchTap, this.focusNode});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        autofocus: false,
        cursorColor: Colors.black,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '搜索一下吧.',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              color: Colors.blue,
              size: 30.0,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          suffixIcon: GestureDetector(
            child: Icon(
              Icons.search,
              color: Colors.blue,
              size: 30.0,
            ),
            onTap: onSearchTap,
          ),
        ),
      ),
    );
  }
}