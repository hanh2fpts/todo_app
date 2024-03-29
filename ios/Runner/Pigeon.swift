// Autogenerated from Pigeon (v10.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)"
  ]
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}
/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol HomeWidgetMessageApi {
  func addHomeWidget(listTodo: [Any]) throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class HomeWidgetMessageApiSetup {
  /// The codec used by HomeWidgetMessageApi.
  /// Sets up an instance of `HomeWidgetMessageApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: HomeWidgetMessageApi?) {
    let addHomeWidgetChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.HomeWidgetMessageApi.addHomeWidget", binaryMessenger: binaryMessenger)
    if let api = api {
      addHomeWidgetChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let listTodoArg = args[0] as! [Any]
        do {
          try api.addHomeWidget(listTodo: listTodoArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      addHomeWidgetChannel.setMessageHandler(nil)
    }
  }
}
