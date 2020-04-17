import 'package:flutter/material.dart';
import 'package:flutter_dropdown_menu/flutter_dropdown_menu.dart';

class SortCondition {
  String name;
  bool isSelected;

  SortCondition({this.name, this.isSelected});
}

class HJDropDownDemoPage extends StatefulWidget {
  @override
  _HJDropDownDemoPageState createState() => _HJDropDownDemoPageState();
}

class _HJDropDownDemoPageState extends State<HJDropDownDemoPage> {
  List<SortCondition> _brandSortConditions = [];
  List<SortCondition> _priceSortConditions = [];
  SortCondition _selectBrandSortCondition;
  SortCondition _selectPriceSortCondition;
  HJDropDownMenuController _dropdownMenuController = HJDropDownMenuController();

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey _stackKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _brandSortConditions.add(SortCondition(name: '全部', isSelected: true));
    _brandSortConditions.add(SortCondition(name: '金逸影城', isSelected: false));
    _brandSortConditions
        .add(SortCondition(name: '中影国际城我比较长，你看我选择后是怎么显示的', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '星美国际城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '博纳国际城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '大地影院', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '嘉禾影城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '太平洋影城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城1', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城2', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城3', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城4', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城5', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城6', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城7', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城8', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城9', isSelected: false));
    _selectBrandSortCondition = _brandSortConditions[0];

    _priceSortConditions
        .add(SortCondition(name: '1000-2000元', isSelected: true));
    _priceSortConditions
        .add(SortCondition(name: '2000-3000元', isSelected: false));
    _priceSortConditions
        .add(SortCondition(name: '3000-5000元', isSelected: false));

    _selectPriceSortCondition = _priceSortConditions[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: <Widget>[Container()],
        title: Text(
          '下拉菜单优化',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      backgroundColor: Colors.white,
      endDrawer:_drawer(),
      body: Container(
        child: Stack(
          key: _stackKey,
          children: <Widget>[
            Column(
              children: <Widget>[
                // 下拉菜单头部
                _header(),
                // 数据列表
                _dataList()
              ],
            ),
            // 下拉菜单
            _menu()
          ],
        ),
      ),
    );
  }
  // 侧滑菜单
  Widget _drawer(){

    return Drawer(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            '侧滑菜单',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  // 下拉菜单头部
  Widget _header() {
    return HJDropDownHeader(
      // 下拉的头部项，目前每一项，只能自定义显示的文字、图标、图标大小修改
      items: [
        HJDropDownHeaderItem('综合', canDrop: false),
        HJDropDownHeaderItem('影城',
            normalIconData: Icons.arrow_drop_down,
            selectedIconData: Icons.arrow_drop_up),
        HJDropDownHeaderItem('价格',
            normalIconData: Icons.arrow_drop_down,
            selectedIconData: Icons.arrow_drop_up),
        HJDropDownHeaderItem('筛选',
            canDrop: false,
            normalIconData: Icons.filter_tilt_shift,
            iconSize: 18),
      ],
      // HJDropDownHeader对应第一父级Stack的key
      stackKey: _stackKey,
      // controller用于控制menu的显示或隐藏
      controller: _dropdownMenuController,
      // 当点击头部项的事件，在这里可以进行页面跳转或openEndDrawer
      onItemTap: (index) {
        if (index == 3) {
          _scaffoldKey.currentState.openEndDrawer();
        }
      },
      // 头部的高度
      height: 40,
      // 头部背景颜色
      color: Colors.white,
      // 头部边框宽度
      borderWidth: 1,
      // 头部边框颜色
      borderColor: Color(0xFFeeede6),
      // 分割线高度
      dividerHeight: 20,
      // 分割线颜色
      dividerColor: Color(0xFFeeede6),
      // 文字样式
      style: TextStyle(color: Color(0xFF666666), fontSize: 13),
      // 下拉时文字样式
      selectStyle: TextStyle(
        fontSize: 13,
        color: Colors.red,
      ),
      // 图标大小
      iconSize: 20,
      // 图标颜色
      iconColor: Color(0xFFafada7),
      // 下拉时图标颜色
//      iconSelectColor: Theme.of(context).primaryColor,
    );
  }

  // 下拉菜单
  Widget _menu() {
    return HJDropDownMenu(
      // controller用于控制menu的显示或隐藏
      controller: _dropdownMenuController,
      // 下拉菜单显示或隐藏动画时长
      animationMilliseconds: 300,
      // 下拉菜单，高度自定义，你想显示什么就显示什么，完全由你决定，你只需要在选择后调用_dropdownMenuController.hide();即可
      menus: [
        HJDropDownMenuBuilder(), //创建一个空的
        HJDropDownMenuBuilder(
            dropDownHeight: 40 * 8.0, //最大高度
            dropDownWidget:
                _buildConditionListWidget(_brandSortConditions, (value) {
              _selectBrandSortCondition = value;
              _dropdownMenuController.hide(true);
              setState(() {});
            })),
        HJDropDownMenuBuilder(
            dropDownHeight: 40.0 * _priceSortConditions.length,
            dropDownWidget:
                _buildConditionListWidget(_priceSortConditions, (value) {
              _selectPriceSortCondition = value;
              _dropdownMenuController.hide(true);
              setState(() {});
            })),
      ],
    );
  }

  //数据列表
  Widget _dataList() {
    return Expanded(
      child: ListView.separated(
          itemCount: 100,
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 1.0),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: ListTile(
                leading: Text('这些是数据列表 $index'),
              ),
              onTap: () {},
            );
          }),
    );
  }

  //下拉菜单选项widget
  _buildConditionListWidget(
      items, void itemOnTap(SortCondition sortCondition)) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      // item 的个数
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1.0),
      // 添加分割线
      itemBuilder: (BuildContext context, int index) {
        SortCondition goodsSortCondition = items[index];
        return GestureDetector(
          onTap: () {
            for (var value in items) {
              value.isSelected = false;
            }
            goodsSortCondition.isSelected = true;

            itemOnTap(goodsSortCondition);
          },
          child: Container(
            height: 40,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    goodsSortCondition.name,
                    style: TextStyle(
                      color: goodsSortCondition.isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                    ),
                  ),
                ),
                goodsSortCondition.isSelected
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      )
                    : SizedBox(),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
