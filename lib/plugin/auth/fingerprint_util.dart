import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class FingerPrintUtil {
  static Future<bool> checkTouchId() async {
    var localAuth = LocalAuthentication();

    // 检查设备是否允许
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;

    print("设备是否允许: $canCheckBiometrics");

    var androidAuthStrings = AndroidAuthMessages(
      // 用户未设置指纹时, 弹窗的标题
      fingerprintRequiredTitle: "安全设置",
      // 用户未设置指纹时, 弹窗的说明
      goToSettingsDescription: 'Please set up your Touch ID.',
      // 用户未设置指纹时, 弹窗的 "设置" 按钮
      goToSettingsButton: '去设置',
      // 验证指纹弹窗标题
      signInTitle: "安全认证",
      // 验证指纹弹窗副标题
      fingerprintHint: "请验证您的指纹",
      cancelButton: "取消",
    );

    try {
      bool didAuthenticate = await localAuth.authenticateWithBiometrics(
          androidAuthStrings: androidAuthStrings,
          // 验证指纹弹窗说明
          localizedReason: '验证以继续操作',
          // 设置为true后, 在返回应用程序后可继续进行验证 (如用户来了电话, 若为stickyAuth=false验证直接会失败)
          stickyAuth: true);

      print("didAuthenticate: $didAuthenticate");
      return didAuthenticate;
    } on PlatformException catch (e) {
      print("e:$e");
      if (e.code == auth_error.notAvailable) {
        // todo 处理异常
      }
    }
    return false;
  }
}
