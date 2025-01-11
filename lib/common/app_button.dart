import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String buttonText;
  final Function onTapButton;
  final double width;
  final Widget? prefixIcon;
  final Color buttonColor;
  final Color textColor;

   AppButton(
      {required this.buttonText,
      required this.onTapButton,
      this.width = 0,
      this.prefixIcon,
        this.buttonColor = Colors.green,
        this.textColor = Colors.white,
     });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  Color _buttonColor = Colors.green;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: MouseRegion(
        onEnter: (e){
          setState(() {
            _buttonColor = Colors.green;
          });
        },
        onExit: (e){
          setState(() {
            _buttonColor = Colors.green;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          width: widget.width == 0 ? double.infinity : widget.width,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(
                Radius.circular(24)),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.prefixIcon ?? const SizedBox.shrink(),
                widget.prefixIcon != null
                    ? const SizedBox(
                        width: 5,
                      )
                    : const SizedBox.shrink(),
                Text(
                  widget.buttonText,
                  style: TextStyle(
                      color:  widget.textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
          if (widget.onTapButton != null) {
            widget.onTapButton();
          }

      },
    );
  }
}
