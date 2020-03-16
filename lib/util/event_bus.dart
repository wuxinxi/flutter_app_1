typedef void EventCallback(arg);

class EventBus {
  //私有构造函数
  EventBus._internal();

  static EventBus singleton = EventBus._internal();

  factory EventBus() => singleton;

  var eMap = Map<Object, List<EventCallback>>();

  //添加订阅着
  void on(eventName, EventCallback callback) {
    if (eventName == null || callback == null) return;
    eMap[eventName] ??= List<EventCallback>();
    eMap[eventName].add(callback);
  }

  //移除订阅者
  void off(eventName, [EventCallback callback]) {
    var list = eMap[eventName];
    if (eventName == null || list == null) return;

    if (callback == null) {
      eMap[eventName] = null;
    } else {
      list.remove(callback);
    }
  }

  //触发事件
  void emit(eventName, [arg]) {
    var list = eMap[eventName];
    if (list == null) return;
    int len = list.length - 1;
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}

var bus = EventBus();
