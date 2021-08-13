import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class WidgetHelper extends StatefulWidget {
  const WidgetHelper({Key? key}) : super(key: key);

  @override
  _WidgetHelperState createState() => _WidgetHelperState();

  Widget GradientButton(BuildContext context,var _onpressed) {
    return Container(
      child: RaisedButton(
        onPressed: _onpressed,
        textColor: Colors.white,
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  Color.fromARGB(255, 127, 0, 255),
                  Color.fromARGB(255, 225, 0, 255)
                ],
              )
          ),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Next",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget ExpandableCardForm(BuildContext context,Widget form,String title,String description ){
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "PAN VALIDATION",
                          style: Theme.of(context).textTheme.body2,
                        )),
                    collapsed: Text(
                      "Click to Enter Your PAN DETAILS",
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Pan Form will go here",
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                        FlatButton(onPressed: (){
                          print("Validation");
                        }, child: Text("ENABLE 2nd Accordian")),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class _WidgetHelperState extends State<WidgetHelper> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }



}
