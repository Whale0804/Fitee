import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/webview/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'high_lighter.dart';

class FiteeMarkdown extends StatelessWidget{

  static const int DARK_WHITE = 0;

  static const int DARK_LIGHT = 1;

  static const int DARK_THEME = 2;

  final String data;
  final int style;

  FiteeMarkdown({this.data, this.style = DARK_LIGHT});



  _getCommonSheet(BuildContext context, Color codeBackground) {
    MarkdownStyleSheet markdownStyleSheet =
    MarkdownStyleSheet.fromTheme(Theme.of(context));
    return markdownStyleSheet
        .copyWith(
        codeblockDecoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            color: codeBackground,
            border: new Border.all(
                color: HexColor('#6FA0FB'), width: 0.3,)))
        .copyWith(
          codeblockPadding: EdgeInsets.symmetric(vertical: duSetHeight(8), horizontal: duSetWidth(8))
    )   .copyWith(
        blockquoteDecoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            color: HexColor('#6FA0FB'),
            border: new Border.all(
                color: HexColor('#6FA0FB'), width: 0.3)),
        blockquote: TextStyle(
          color: AppTheme.white,
          fontSize: duSetFontSize(18)
        )).copyWith(
        listBullet: TextStyle(
          fontSize: duSetFontSize(18),
          color: AppTheme.white
        )
    ).copyWith(
        tableBody: MarkdownTheme.normalText
    );
  }

  _getStyleSheetDark(BuildContext context) {
    return _getCommonSheet(context, HexColor('#F6F8FA')).copyWith(
      a: TextStyle(fontSize: duSetFontSize(MarkdownTheme.normalTextSize), color: AppTheme.actionColor),
      p: MarkdownTheme.normalText,
      h1: MarkdownTheme.largeLargeText,
      h2: MarkdownTheme.largeTextBold,
      h3: MarkdownTheme.normalTextBold,
      h4: MarkdownTheme.middleText,
      h5: MarkdownTheme.smallText,
      h6: MarkdownTheme.smallText,
      em: const TextStyle(fontStyle: FontStyle.italic),
      strong: MarkdownTheme.middleTextBold,
      code: MarkdownTheme.normalTextWhite.copyWith(
        backgroundColor: Colors.transparent,
        fontFamily: 'WorkSans',
        color: AppTheme.descText
      ),

    );
  }

  _getStyleSheetWhite(BuildContext context) {
    return _getCommonSheet(context, Color.fromRGBO(40, 44, 52, 1.00)).copyWith(
      p: MarkdownTheme.smallText,
      h1: MarkdownTheme.largeLargeText,
      h2: MarkdownTheme.largeTextBold,
      h3: MarkdownTheme.normalTextBold,
      h4: MarkdownTheme.middleText,
      h5: MarkdownTheme.smallText,
      h6: MarkdownTheme.smallText,
      strong: MarkdownTheme.middleTextBold,
      code: MarkdownTheme.smallSubText,
    );
  }


  _getStyleSheetTheme(BuildContext context) {
    return _getCommonSheet(context, Color.fromRGBO(40, 44, 52, 1.00)).copyWith(
      p: MarkdownTheme.smallTextWhite,
      h1: MarkdownTheme.largeLargeTextWhite,
      h2: MarkdownTheme.largeTextWhiteBold,
      h3: MarkdownTheme.normalTextMitWhiteBold,
      h4: MarkdownTheme.middleTextWhite,
      h5: MarkdownTheme.smallTextWhite,
      h6: MarkdownTheme.smallTextWhite,
      em: const TextStyle(fontStyle: FontStyle.italic),
      strong: MarkdownTheme.middleTextWhiteBold,
      code: MarkdownTheme.smallSubText,
    );
  }


  _getStyle(BuildContext context) {
    var styleSheet = _getStyleSheetWhite(context);
    switch (style) {
      case DARK_LIGHT:
        styleSheet = _getStyleSheetDark(context);
        break;
      case DARK_THEME:
        styleSheet = _getStyleSheetTheme(context);
        break;
    }
    return styleSheet;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Markdown(
          data: data,
          styleSheet: _getStyle(context),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          syntaxHighlighter: FiteeHighlighter(),
          onTapLink: (text, href, title) {
            NavUtil.push(FiteeWebView(url: href));
          },
        ),
    );
  }

}

class FiteeHighlighter extends SyntaxHighlighter {
  @override
  TextSpan format(String source) {
    String showSource = source.replaceAll("&lt;", "<");
    showSource = showSource.replaceAll("&gt;", ">");
    return new DartSyntaxHighlighter().format(showSource);
  }
}