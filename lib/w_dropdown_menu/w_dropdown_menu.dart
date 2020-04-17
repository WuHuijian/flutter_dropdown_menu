import 'package:flutter/material.dart';
import 'w_dropdown_menu_controller.dart';

class HJDropDownMenuBuilder {
  final Widget dropDownWidget;
  final double dropDownHeight;

  HJDropDownMenuBuilder(
      {@required this.dropDownWidget, @required this.dropDownHeight});
}

class HJDropDownMenu extends StatefulWidget {
  final HJDropDownMenuController controller;
  final List<HJDropDownMenuBuilder> menus;
  final int animationMilliseconds;

  const HJDropDownMenu({Key key,
    @required this.controller,
    @required this.menus,
    this.animationMilliseconds = 300})
      : super(key: key);

  @override
  _HJDropDownMenuState createState() => _HJDropDownMenuState();
}

class _HJDropDownMenuState extends State<HJDropDownMenu>
    with TickerProviderStateMixin {
  bool _isShowDropDownItemWidget = false;
  bool _isShowMask = false;
  bool _isControllerDisposed = false;
  double _lastDropMenuHeight = 0;
  Animation<double> _animation;
  AnimationController _controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.controller.addListener(_onController);
  }

  _onController() {
    if (widget.controller.isShow) {
      _showDropDownItemWidget();
    } else {
      _hideDropDownItemWidget();
    }
  }



@override
Widget build(BuildContext context) {
//    print('_HJDropDownMenuState.build');
  return _buildDropDownWidget();
}

dispose() {
  _controller.dispose();
  _isControllerDisposed = true;
  super.dispose();
}

_showDropDownItemWidget() {

    int menuIndex = widget.controller.menuIndex;
    if (menuIndex >= widget.menus.length ||
        widget.menus[menuIndex] == null ||
        widget.menus[menuIndex].dropDownWidget == null ||
        widget.menus[menuIndex].dropDownHeight == 0) {
      return;
    }

    _isShowDropDownItemWidget = true;
    _isShowMask = true;
    //展开动画
    _controller = new AnimationController(
        duration: Duration(milliseconds: widget.animationMilliseconds),
        vsync: this);
    _animation =
    new Tween(begin: _lastDropMenuHeight, end: widget.menus[menuIndex].dropDownHeight)
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    if (_isControllerDisposed) return;
    _controller.forward();
    //更新UI
    _lastDropMenuHeight = widget.menus[menuIndex].dropDownHeight;
}

_hideDropDownItemWidget() {

  _isShowDropDownItemWidget = false;
  _isShowMask = false;
  _controller = new AnimationController(
      duration: Duration(milliseconds: widget.animationMilliseconds),
      vsync: this);
  _animation =
  new Tween(begin: _lastDropMenuHeight, end: 0.0)
      .animate(_controller)
    ..addListener(() {
      //更新UI
      setState(() {});
    });

  if (_isControllerDisposed) return;
  _controller.forward();
  _lastDropMenuHeight = 0;
}

Widget _mask() {
  if (_isShowMask) {
    return GestureDetector(
      onTap: () {
        widget.controller.hide(true);
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        color: Color.fromRGBO(0, 0, 0, 0.1),
      ),
    );
  } else {
    return Container(
      height: 0,
    );
  }
}

Widget _buildDropDownWidget() {
  int menuIndex = widget.controller.menuIndex;

  if (menuIndex >= widget.menus.length) {
    return Container();
  }

  return Positioned(
      width: MediaQuery
          .of(context)
          .size
          .width,
      top: widget.controller.dropDownHearderHeight,
      left: 0,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: _animation == null ? 0 : _animation.value,
            child: widget.menus[menuIndex].dropDownWidget,
          ),
          _mask()
        ],
      ));
}}
