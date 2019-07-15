import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SharePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> with AutomaticKeepAliveClientMixin {
  Completer<GoogleMapController> _mapCompleter = Completer();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Trace",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF333333),
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Action click"),
                ));
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Image.asset(
                  "images/icon_nav_history.png",
                  width: 24.0,
                  height: 24.0,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // header line
            Container(
              height: 0.5,
              color: Color(0XFFE0E0E0),
            ),

            // values
            Container(
              height: 65,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.fromLTRB(0, 22.0, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 每个元素的间距一致（平分剩余的间距）
                children: <Widget>[
                  _createTitleItem("100 m", "Distance"),
                  _createTitleItem("20 min", "Time"),
                  _createTitleItem("0.2 m/h", "Speed"),
                ],
              ),
            ),

            // map
            Expanded(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        rotateGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        zoomGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(30.615638, 104.068074),
                          zoom: 14.4746,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _mapCompleter.complete(controller);
                        },
                      ),
                    ),
                  ),

                  Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset("images/share_logo_url.png", width: 180,),
                  ),

                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 37),
                    child: InkWell(
                      onTap: () {
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text("share button click")));
                      },
                      child: Container(
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/share_bg_fb.png"),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 27, right: 27),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.asset("images/share_icon_fb.png", height: 20,),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Share to Feedback",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createTitleItem(String title, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min, // 让Column自适应子控件，如果是max则会填充满父控件
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
          child: Text(
            "$title",
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF333333),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
          child: Text(
            "$desc",
            style: TextStyle(
              fontSize: 11,
              color: Color(0XFFA1A7B2),
            ),
          ),
        ),
      ],
    );
  }
}
