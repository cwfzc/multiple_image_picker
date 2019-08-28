import 'package:flutter/material.dart';

class MultipleImagePicker extends StatelessWidget {
  final String title; //标题
  final String icon;
  final List imgList; //图片数组
  final double imgWidth; //图片宽度
  final int maxImgNum; //最大图片数量
  final bool isEdit; //是否编辑
  final VoidCallback takePhoto; //拍照
  final VoidCallback openGallery; //从相册选择图片
  final Function deletePhoto; //删除照片
  final Function showLagerPhoto; //显示大图

  MultipleImagePicker(
      {this.title = "",
      this.icon = 'tjzp',
      this.imgList,
      this.imgWidth,
      this.maxImgNum=9,
      this.isEdit = false,
      this.takePhoto,
      this.openGallery,
      this.deletePhoto,
      this.showLagerPhoto});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(15, 12.5, 15, 12.5),
            child: Text(this.title,
                style: TextStyle(color: Color(0xFF333333), fontSize: 14.0)),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: getContent(context)),
          Container(
            height: 1,
            color: Color(0xFFF7F7F7),
          ),
        ],
      ),
    );
  }

  ///通过isEdit判断是否需要编辑
  Widget getContent(context) {
    return isEdit == false
        ? //不需要编辑，只是展示内容
        Padding(
            padding: EdgeInsets.all(5.0),
            child: (this.imgList == null || this.imgList.length == 0)
                ? Container(
                    child: Text('没有上传内容'),
                  )
                : Container(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: imgList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        //纵轴间距
                        mainAxisSpacing: 20.0,
                        //横轴间距
                        crossAxisSpacing: 20.0,
                        //子组件宽高长度比例
                        childAspectRatio: 1.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: Image.network(
                            imgList[index],
                            width: this.imgWidth,
                            height: this.imgWidth,
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            showLagerPhoto == null
                                ? null
                                : showLagerPhoto(index);
                          },
                        );
                      },
                    ),
                  ),
          )
        : needEdit(context);
  }

  ///需要编辑的处理
  Widget needEdit(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: (this.imgList == null || this.imgList.length == 0)
          ? addImg(context) //没有图片的时候
          : Container(
              //有图片处理
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children:getListImg(context)
              ),
            ),
    );
  }

  ///需要添加图片的空间
  Widget addImg(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text("拍摄"),
                    onTap: this.takePhoto,
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("相册"),
                    onTap: this.openGallery,
                  ),
                  ListTile(
                    leading: Icon(Icons.cancel),
                    title: Text("取消"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Image.asset(
            'images/take_photo.png',
            width: this.imgWidth,
            height: this.imgWidth,
          ),
        ),
      ),
    );
  }

  getListImg(BuildContext context){
    List wl = _showList();
    print(wl.length);
    if(wl.length < maxImgNum){
      wl.add(addImg(context));
    }
    print(wl.length);
    return wl;
  }

  ///
  List<Widget> _showList() {
    return this.imgList.asMap().keys.map((index) {
      return InkWell(
        child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            Image.network(
              imgList[index],
              width: this.imgWidth,
              height: this.imgWidth,
              fit: BoxFit.cover,
            ),
            InkWell(
              child: Icon(
                Icons.cancel,
                size: 50,
                color: Colors.amber,
              ),
              onTap: () {
                deletePhoto == null ? null : deletePhoto(index);
              },
            ),
          ],
        ),
        onTap: () {
          showLagerPhoto == null ? null : showLagerPhoto(index);
        },
      );
    }).toList();
  }
}
