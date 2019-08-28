import 'package:flutter/material.dart';
import 'package:flutter_app/ImgPick.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title: '图片选择器',
      home: Scaffold(
        appBar: AppBar(
          title: Text('图片选择器'),
        ),
        body: MyHomePage(),

      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var list = ['https://ss0.baidu.com/73F1bjeh1BF3odCf/it/u=2959755204,2089953248&fm=85&s=86E740A25F21BB4910FED3A903007005','https://ss0.baidu.com/73F1bjeh1BF3odCf/it/u=2959755204,2089953248&fm=85&s=86E740A25F21BB4910FED3A903007005','https://ss0.baidu.com/73F1bjeh1BF3odCf/it/u=2959755204,2089953248&fm=85&s=86E740A25F21BB4910FED3A903007005','https://ss0.baidu.com/73F1bjeh1BF3odCf/it/u=2959755204,2089953248&fm=85&s=86E740A25F21BB4910FED3A903007005'];
//    var list =[];



    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultipleImagePicker(
      title: '拍照上传',
      isEdit: true,
      imgList: list,
      maxImgNum: 9,
      imgWidth: (MediaQuery.of(context).size.width - 15 * 2 - 10 * 3) / 3,
      showLagerPhoto: (index){
        print('查看${index}');
      },
      deletePhoto: (index){
        print('删除${index}');
        setState(() {
          list.removeAt(index);
        });
      },
      takePhoto: ()async{
        Navigator.pop(context);
        var image = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
          list.add('https://ss0.baidu.com/73F1bjeh1BF3odCf/it/u=2959755204,2089953248&fm=85&s=86E740A25F21BB4910FED3A903007005');
        });
      },
    );
  }
}
