import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../MainPage.dart';
import '../location/LatLng.dart';
import 'GMessage.dart';
import 'MemberDetailPage.dart';

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with AutomaticKeepAliveClientMixin {
  LatLng _topLocation = LatLng(30.548, 154.264);
  String _topName = "POI Name";
  bool hasInputText = false;
  bool isSOSMode = false;
  List<GMessage> _messageList = List();

  void setTopPin(LatLng topLocation, String topName) {
    setState(() {
      _topLocation = topLocation;
      _topName = topLocation != null ? topName ?? "" : null;
    });
  }

  void topPinClick() {
//    MainPagState.jumpToPage(0);
    MainPagState.showToast("Top Pin Click");
//    Scaffold.of(context).showSnackBar(SnackBar(
//      content: Text("Top Pin Click"),
//    ));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Message',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF333333),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MemberDetailPage()));
              },
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.asset(
                    "images/icon_nav_menber.png",
                    width: 24.0,
                    height: 24.0,
                  ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          // top pin layout
          _createTopPinLayout(topPinClick),

          // message list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _messageList.length,
              itemBuilder: (BuildContext context, int index) {
                return _createMessageView(index);
              },
            ),
          ),

          // bottom layout
          _createInputLayout(),
        ],
      ),
    );
  }

  Widget _createMessageView(int index) {
    GMessage msg = _messageList[index];
    switch (msg.type) {
      case GMessageType.TYPE_MSG:
        {
          break;
        }
      case GMessageType.TYPE_LOC:
        {
          break;
        }
      case GMessageType.TYPE_SOS:
        {
          break;
        }
      case GMessageType.TYPE_PIN:
        {
          break;
        }
      case GMessageType.TYPE_VOC:
        {
          break;
        }
    }

    return null;
  }

  Widget _createInputLayout() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Column(
        children: <Widget>[
          Container(
            height: 0.5,
            color: Color(0xFFE0E0E0),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // Location send button
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 6),
                  child: Image.asset(
                    "images/btn_chat_location.png",
                    width: 42,
                    height: 42,
                  ),
                ),
              ),

              // SOS send button
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 10, 6),
                  child: _createSOSButton(),
                ),
              ),

              // input layout
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFF2F2F3), width: 0.5),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.elliptical(21, 21), bottom: Radius.elliptical(21, 21)),
                  ),
                  margin: EdgeInsets.fromLTRB(0, 10, 10, 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // input view
                      Expanded(
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              hintText: "Your Message...",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFD6D6D6),
                              ),
                              border: InputBorder.none,
                            ),
                            cursorColor: Color(0xFF333333),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF333333),
                            ),
                            minLines: 1,
                            maxLines: 10,
//                                  maxLength: 80, //最大文本长度
                            inputFormatters: <TextInputFormatter>[
//                                    WhitelistingTextInputFormatter.digitsOnly,//只输入数字
                              LengthLimitingTextInputFormatter(80) //限制长度，如果使用maxLength来限制，会显示一个长度计数器
                            ],
                            maxLengthEnforced: true,
                            //超过最大长度后, 是否禁止输入
                            onChanged: (value) {
                              print("input length: ${value.length}");
                              setState(() {
                                hasInputText = value.length > 0;
                              });
                            },
                          ),
                        ),
                      ),

                      // message send button / Voc send button
                      Container(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 4, 4, 4),
                            child: _createSendButton(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createTopPinLayout(Function onTop) {
    if (_topLocation == null) {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Container(
          height: 0.5,
          color: Color.fromARGB(0XFF, 0xE0, 0XE0, 0XE0),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTop,
        child: Column(
          children: <Widget>[
            Container(
              height: 0.5,
              color: Color.fromARGB(0XFF, 0xF2, 0X94, 0X58),
            ),
            Container(
              height: 32,
              color: Color.fromARGB(0XFF, 0xFC, 0XED, 0XE3),
              child: Center(
                child: Text(
                  _topName ?? "",
                  style: TextStyle(
                    color: Color.fromARGB(0xFF, 0xF2, 0x94, 0x58),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(
              height: 0.5,
              color: Color.fromARGB(0XFF, 0xF2, 0X94, 0X58),
            ),
          ],
        ),
      );
    }
  }

  Widget _createSendButton() {
    if (hasInputText) {
      return Image.asset(
        "images/btn_chat_send.png",
        width: 34,
        height: 34,
      );
    } else {
      return Image.asset(
        "images/btn_chat_voice.png",
        width: 34,
        height: 34,
      );
    }
  }

  Widget _createSOSButton() {
    if (isSOSMode) {
      return Image.asset(
        "images/btn_chat_sos_open.png",
        width: 42,
        height: 42,
      );
    } else {
      return Image.asset(
        "images/btn_chat_sos_close.png",
        width: 42,
        height: 42,
      );
    }
  }
}
