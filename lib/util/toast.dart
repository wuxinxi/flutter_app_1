import 'package:flutter/material.dart';

class Toast {
  static OverlayEntry mOverlayEntry;
  static bool mShowing = false;
  static DateTime mStartTime;
  static String mContent;

  static void toast(BuildContext context, String content) async {
    assert(content != null);
    mContent = content;
    mStartTime = DateTime.now();
    OverlayState overlayState = Overlay.of(context);
    mShowing = true;
    if (mOverlayEntry == null) {
      mOverlayEntry = OverlayEntry(
          builder: (context) => Positioned(
                top: MediaQuery.of(context).size.height * 2 / 3,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.0),
                    child: AnimatedOpacity(
                      opacity: mShowing ? 1.0 : 0.0,
                      duration: Duration(milliseconds: mShowing ? 100 : 400),
                      child: buildToastWidget(),
                    ),
                  ),
                ),
              ));
      overlayState.insert(mOverlayEntry);
    } else {
      mOverlayEntry.markNeedsBuild();
    }
    await Future.delayed(Duration(seconds: 2));
    if (DateTime.now().difference(mStartTime).inSeconds >= 2) {
      mShowing = false;
      mOverlayEntry.markNeedsBuild();
      mOverlayEntry.remove();
      mOverlayEntry = null;
    }
  }

  static buildToastWidget() {
    return Center(
      child: Card(
        color: Colors.black26,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
          child: Text(
            mContent,
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
