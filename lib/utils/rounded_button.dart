import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaligram_transport_app/utils/theme_color.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final Function() onTap;
  final IconData? iconData;
  final bool? isEnable;
  final bool? isAsync;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? backgroundColor;
  final bool? isLoading;

  const RoundedButton({Key? key, this.text, this.iconData, this.backgroundColor, this.isAsync, this.isEnable,this.height, this.width, this.fontSize, required this.onTap , this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (height != null) ? height : 50,
      width: (width != null) ? width : double.infinity,
      child: Container(
        decoration: isEnable == true ? BoxDecoration(color: backgroundColor ?? ThemeColor.primaryColor, borderRadius: BorderRadius.circular(15.0),) : BoxDecoration(borderRadius: BorderRadius.circular(15.0),),
        child: ElevatedButton(
          onPressed: () async {
            if ((isAsync == null || isAsync == false)  && isEnable == true) {
              onTap();
            }
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            shape:
            MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                )),
            backgroundColor: isEnable == true ? MaterialStateProperty.all(backgroundColor ?? ThemeColor.primaryColor) : MaterialStateProperty.all(ThemeColor.disableColor),
          ),
          child: isLoading == true ? const CupertinoActivityIndicator(color: Colors.white,radius: 15) : text != null
              ?
          labelTextRegular(text!, fontSize!, ThemeColor.primaryColorLight) : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
