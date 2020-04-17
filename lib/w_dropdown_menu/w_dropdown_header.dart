import 'package:flutter/material.dart';
import 'w_dropdown_menu_controller.dart';

typedef OnItemTap<T> = void Function(T value);

class HJDropDownHeader extends StatefulWidget {
  final Color color;
  final double borderWidth;
  final Color borderColor;
  final double iconSize;
  final Color iconColor;
  TextStyle style;
  TextStyle selectStyle;
  Color iconSelectColor;

  final double height;
  final double dividerHeight;
  final Color dividerColor;
  final HJDropDownMenuController controller;
  final OnItemTap onItemTap;
  final List<HJDropDownHeaderItem> items;
  final GlobalKey stackKey;

  HJDropDownHeader({
    Key key,
    @required this.items,
    @required this.controller,
    @required this.stackKey,
    this.style = const TextStyle(color: Color(0xFF666666), fontSize: 13),
    this.selectStyle,
    this.height = 40,
    this.iconColor = const Color(0xFFafada7),
    this.iconSelectColor,
    this.iconSize = 20,
    this.borderWidth = 1,
    this.borderColor = const Color(0xFFeeede6),
    this.dividerHeight = 20,
    this.dividerColor = const Color(0xFFeeede6),
    this.onItemTap,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  _HJDropDownHeaderState createState() => _HJDropDownHeaderState();
}

class _HJDropDownHeaderState extends State<HJDropDownHeader>
    with SingleTickerProviderStateMixin {
  bool _isShowDropDownItemWidget = false;
  bool _isSelectedItemWidget = false;
  int _menuCount;
  double _screenWidth;
  double _screenHeight;
  GlobalKey _keyDropDownHearder = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onController);
  }

  _onController() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    widget.selectStyle ??=
        TextStyle(color: Theme.of(context).primaryColor, fontSize: 13);
    widget.iconSelectColor ??= Theme.of(context).primaryColor;

    MediaQueryData mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _menuCount = widget.items.length;

    var gridView = GridView.count(
      crossAxisCount: _menuCount,
      childAspectRatio: (_screenWidth / _menuCount) / widget.height,
      children: widget.items.map<Widget>((item) {
        return _menu(item);
      }).toList(),
    );

    return Container(
      key: _keyDropDownHearder,
      height: widget.height,
      decoration: BoxDecoration(
        //设置边框
        border:
            Border.all(color: widget.borderColor, width: widget.borderWidth),
      ),
      child: gridView,
    );
  }

  dispose() {
    super.dispose();
  }

  _menu(HJDropDownHeaderItem item) {
    int index = widget.items.indexOf(item);
    int menuIndex = widget.controller.menuIndex;
    _isShowDropDownItemWidget = index == menuIndex && widget.controller.isShow;
    return GestureDetector(
      onTap: () {
        final RenderBox overlay =
            widget.stackKey.currentContext.findRenderObject();

        final RenderBox dropDownItemRenderBox =
            _keyDropDownHearder.currentContext.findRenderObject();

        var position =
            dropDownItemRenderBox.localToGlobal(Offset.zero, ancestor: overlay);
        var size = dropDownItemRenderBox.size;

        widget.controller.dropDownHearderHeight = size.height + position.dy;

        if (widget.controller.isShow && index == menuIndex) {
          widget.controller.hide(true);
        } else if (widget.controller.isShow && index != menuIndex) {
          HJDropDownHeaderItem item = widget.items[index];
          if(!item.canDrop){
            widget.controller.hide(item.canDrop);
          }
          widget.controller.show(index, item.canDrop);
        } else {
          HJDropDownHeaderItem item = widget.items[index];
          widget.controller.show(index, item.canDrop);
        }
        if (widget.onItemTap != null) {
          widget.onItemTap(index);
        }
        setState(() {});
      },
      child: Container(
          color: widget.color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _headItemRowSubWidges(item),
                ),
              ),
              index == widget.items.length - 1
                  ? Container()
                  : Container(
                      height: widget.dividerHeight,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: widget.dividerColor, width: 1))),
                    )
            ],
          )),
    );
  }

  List<Widget> _headItemRowSubWidges(HJDropDownHeaderItem item) {
    int index = widget.items.indexOf(item);
    int menuIndex = widget.controller.menuIndex;
    _isSelectedItemWidget = index == menuIndex;
    List<Widget> subWidgets = List<Widget>();
    //标题
    subWidgets.add(
      Flexible(
          child: Text(
        item.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: _isSelectedItemWidget ? widget.selectStyle : widget.style,
      )),
    );
    //图标
    if (item.normalIconData != null) {
      subWidgets.add(Icon(
        !_isShowDropDownItemWidget
            ? item.normalIconData
            : item.selectedIconData ?? item.normalIconData,
        color: _isShowDropDownItemWidget
            ? widget.iconSelectColor
            : widget.iconColor,
        size: item.iconSize ?? widget.iconSize,
      ));
    }

    return subWidgets;
  }
}

class HJDropDownHeaderItem {
  final String title;
  final bool canDrop;
  final IconData normalIconData;
  final IconData selectedIconData;
  final double iconSize;

  HJDropDownHeaderItem(this.title,
      {this.canDrop = true,
      this.normalIconData,
      this.selectedIconData,
      this.iconSize});
}
