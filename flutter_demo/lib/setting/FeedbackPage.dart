import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info/package_info.dart';

import '../Header.dart';

class FeedbackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FeedbackPageState();
}

typedef SelectAction = Function(int index);
typedef DeleteAction = Function(int index);

class _FeedbackPageState extends State<FeedbackPage> {
  String _appVersion = "";
  final String _buildYear = "2019";
  String _deviceVersion = "1.3.6";

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  final _imageMaxCount = 4;
  final List<File> _imageList = List();

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onSubmitFeedback() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _onImageSelect(int index) {
    ImagePicker.pickImage(source: ImageSource.gallery).then((file) {
      if (_imageList.any((f) {
        return f != null && f.path == file.path;
      })) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("This image has selected")));
        return;
      }

      setState(() {
        if (index == _imageMaxCount - 1 || _imageList[index] != null) {
          _imageList[index] = file;
        } else {
          _imageList.insert(index, file);
        }
      });
    });
  }

  void _onImageDelete(int index) {
    setState(() {
      if (index == _imageMaxCount - 1) {
        _imageList[index] = null;
      } else {
        _imageList.removeAt(index);
        if (_imageList.last != null) {
          _imageList.add(null);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _imageList.clear();
    _imageList.add(null);
    PackageInfo.fromPlatform().then((info) {
      setState(() {
        _appVersion = info.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _onBackPressed();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: Header(
          leadingAction: _onBackPressed,
          title: "Feedback",
          actions: <Widget>[
            _createSendButton(_onSubmitFeedback),
          ],
        ),
        backgroundColor: Color(0xFFF5F7F9),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 0.5,
                        color: Color(0xFFE0E0E0),
                      ),
                      Container(
                        height: 65.5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: TextField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Color(0xFF333333),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF333333),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Your full name",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFFD6D6D6),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  minLines: 1,
                                  maxLines: 1,
                                  inputFormatters: <TextInputFormatter>[LengthLimitingTextInputFormatter(20)],
                                  maxLengthEnforced: true,
                                  onChanged: (text) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: 0.5,
                              color: Color(0xFFE0E0E0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 65.5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: TextField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: Color(0xFF333333),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF333333),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Your email",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFFD6D6D6),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  minLines: 1,
                                  maxLines: 1,
                                  inputFormatters: <TextInputFormatter>[LengthLimitingTextInputFormatter(60)],
                                  maxLengthEnforced: true,
                                  onChanged: (text) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: 0.5,
                              color: Color(0xFFE0E0E0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 140.5,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                                child: TextField(
                                  controller: _messageController,
                                  keyboardType: TextInputType.multiline,
                                  cursorColor: Color(0xFF333333),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF333333),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Your message",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFFD6D6D6),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  minLines: 1,
                                  maxLines: 10,
                                  inputFormatters: <TextInputFormatter>[LengthLimitingTextInputFormatter(80)],
                                  maxLengthEnforced: true,
                                  onChanged: (text) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: 0.5,
                              color: Color(0xFFE0E0E0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 105,
                        margin: EdgeInsets.only(
                          left: 6,
                          top: 25,
                          right: 16,
                        ),
                        child: GridView.builder(
                          itemCount: _imageList.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: _imageMaxCount,
                            childAspectRatio: 1.0, //子Widget宽高比例
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 0.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return _createItem(index, _onImageSelect, _onImageDelete);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    "App v$_appVersion Build $_buildYear",
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFFC1C8D6),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 25),
                  child: Text(
                    "Device v$_deviceVersion",
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFFC1C8D6),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _createItem(int index, SelectAction selectAction, DeleteAction deleteAction) {
    File imageFile = _imageList[index];
    if (imageFile == null) {
      return Center(
        child: Container(
          width: 80,
          height: 80,
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              selectAction(index);
            },
            child: Image.asset(
              "images/feedback_scr_add.png",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: Container(
          width: 80,
          height: 80,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    selectAction(index);
                  },
                  child: ClipRRect(
                    child: Image.file(
                      imageFile,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                width: 20,
                height: 20,
                child: GestureDetector(
                  onTap: () {
                    deleteAction(index);
                  },
                  child: Image.asset(
                    "images/feedback_scr_delete.png",
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _createSendButton(GestureTapCallback onActionClick) {
    Color color;
    if (_nameController.text.length > 0 && _emailController.text.length > 0 && _messageController.text.length > 0) {
      color = Color(0xFF5886dc);
    } else {
      color = Color(0x7f5886dc);
      onActionClick = null;
    }

    return Container(
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: onActionClick,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "Send",
            style: TextStyle(
              fontSize: 16,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
