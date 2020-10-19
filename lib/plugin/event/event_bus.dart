typedef void EventCallBack(args);

class EventBus {
  // 私有构造函数
  EventBus._internal();

  // 保存单例
  static EventBus _singleton = new EventBus._internal();

  // 工厂构造函数
  factory EventBus()=> _singleton;

  // 保存事件订阅者队列，key: 事件名(id), value: 对应事件的订阅者队列
  var _emap = new Map<Object, List<EventCallBack>>();

  // 添加订阅者
  void on(eventName, EventCallBack fun) {
    if(eventName == null || fun == null) return;
    _emap[eventName] ??= new List<EventCallBack>();
    _emap[eventName].add(fun);
  }

  // 移除订阅者
  void off(eventName, [EventCallBack fun]) {
    var list = _emap[eventName];
    if(eventName == null || list == null) return;
    if(fun == null){
      _emap[eventName] = null;
    } else {
      list.remove(fun);
    }
  }

  // 触发事件，事件触发后该事件所有订阅者会被调用
  void emit(eventName, [args]) {
    var list = _emap[eventName];
    if(list == null) return;
    int len = list.length - 1;
    // 反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](args);
    }
  }
}

//定义一个top-level（全局）变量，页面引入该文件后可以直接使用bus
var bus = new EventBus();

// 使用示例

///监听登录事件
// bus.on("login", (arg) {
//   // do something
// });
///
// 登录成功后触发登录事件，页面A中订阅者会被调用
// bus.emit("login", userInfo);