import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:liquid_menu/core/viewmodels/home_model.dart';
import 'package:liquid_menu/ui/shared/globals.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Liquid extends StatelessWidget {
  final bool isFlipped;
  final AnimationController controller;
  final String data;

  Liquid({
    @required this.isFlipped,
    @required this.controller,
    @required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);
    bool click = true;

    final double bheight = 150.0;
    final double sheight = 100.0;
    final FlutterTts flutterTts = FlutterTts();

    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 2000),
        curve: Curves.elasticOut,
        transform: Matrix4.identity()
          ..translate(
            0.0,
            isFlipped ? -model.openValue : model.openValue,
          ),
        decoration: BoxDecoration(
          color: Global.bgColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 30.0,
              color: !isFlipped ? Colors.grey[350] : Colors.white,
              offset: Offset(isFlipped ? -10 : 10, isFlipped ? -20 : 20),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        height: isFlipped ? 150 : 100,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform(
              transform: Matrix4.identity()
                ..scale(1.0, isFlipped ? -.7 : 1.0)
                ..translate(0.0, isFlipped ? -bheight * 2 + 50 : -sheight + 50),
              child: Lottie.asset(
                'data/liquid.json',
                controller: controller,
                animate: false,
                height: isFlipped ? bheight : sheight,
                delegates: LottieDelegates(
                  values: [
                    ValueDelegate.color(
                      const ['**', 'Rectangle 1', 'Fill 1'],
                      value: Global.bgColor,
                      // value: Colors.red,
                    ),
                    ValueDelegate.color(const ['**', 'Shape 1', 'Fill 1'],
                        value: Global.bgColor),
                    // value: Colors.red),
                  ],
                ),
              ),
            ),
            isFlipped
                ? SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data,
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.volume_up_outlined,
                                  color: Colors.blue[300],
                                ),
                                onPressed: () async {
                                  try {
                                    await flutterTts.setLanguage("ne-NP");
                                    await flutterTts.speak(data);
                                  } catch (e) {
                                    Toast.show(
                                        'No Internet, ' +
                                            'Error Code : ' +
                                            e.toString(),
                                        context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM);
                                  }
                                }),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Listen')
                          ],
                        )
                      ],
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      model.openLiquidMenu(controller);
                      click = !click;
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            model.isOpening
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.blue[300],
                          ),
                          click ? Text(data) : SizedBox()
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
