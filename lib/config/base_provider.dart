import 'config.dart';

abstract class BaseProvider {

  bool loading = true;

  String status = AppConfig.NORMAL_STATE;

  int currentPage = 1;

  void setPage({int page = 1});

  void onClear() {
    this.currentPage = 1;
    this.loading = true;
    this.status = AppConfig.NORMAL_STATE;
  }
}