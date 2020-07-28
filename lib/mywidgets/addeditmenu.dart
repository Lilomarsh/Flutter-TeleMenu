import 'package:flutter/material.dart';
class menuItem<T> extends PopupMenuItem<T>
{
  final Widget child;
  final Function onClick;

  menuItem({@required this.child,@required this.onClick}):super(child:child);
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    // TODO: implement createState
    return menuItemState();
  }
}
class menuItemState<T,PopMenuItem>extends PopupMenuItemState<T,menuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}