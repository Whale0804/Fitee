import 'dart:async';

import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './input_helper.dart';

typedef void CaretMoved(Offset globalCaretPosition);
typedef void TextChanged(String text);

// Helper widget to track caret position.
class TrackingTextInput extends StatefulWidget {
  TrackingTextInput(
      {Key key,
      this.onCaretMoved,
      this.onTextChanged,
      this.enable,
      this.hintText,
      this.icon,
      this.isObscured = false})
      : super(key: key);
  final CaretMoved onCaretMoved;
  final TextChanged onTextChanged;

  final String hintText;
  final bool isObscured;
  final bool enable;
//  final FormFieldValidator<String> validator;
  final IconData icon;

  @override
  _TrackingTextInputState createState() => _TrackingTextInputState();
}

class _TrackingTextInputState extends State<TrackingTextInput> {
  final GlobalKey _fieldKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();
  Timer _debounceTimer;
  bool pwdSwitch = false;
//  bool _isPasswordField = false;
//  bool _passwordObscured = false;

  @override
  initState() {
    _textController.addListener(() {
      // We debounce the listener as sometimes the caret position is updated after the listener
      // this assures us we get an accurate caret position.
      if (_debounceTimer?.isActive ?? false) _debounceTimer.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        if (_fieldKey.currentContext != null) {
          // Find the render editable in the field.
          final RenderObject fieldBox =
              _fieldKey.currentContext.findRenderObject();
          Offset caretPosition = getCaretPosition(fieldBox);

          if (widget.onCaretMoved != null) {
            widget.onCaretMoved(caretPosition);
          }
        }
      });
      if (widget.onTextChanged != null) {
        widget.onTextChanged(_textController.text);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _fieldKey,
      enabled: widget.enable,
      keyboardType:
          widget.isObscured ? TextInputType.visiblePassword : TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        fillColor: HexColor('#EFEFEF'),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x00FF0000)),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        hintText: widget.hintText,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x00000000)),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        prefixIcon: Icon(widget.icon, color: Colors.blueAccent),
      ),
      controller: _textController,
      obscureText: widget.isObscured,
    );
  }
}
