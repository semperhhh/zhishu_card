import UIKit
import Flutter
import PhotosUI

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, PHPickerViewControllerDelegate {

    // MARK: PHPickerViewControllerDelegate
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard results.count > 0 else {
            picker.dismiss(animated: true, completion: nil)
            return
        }

        // UTType.image.identifier 图片格式
        // 这个 api 返回的是一个 URL 类型的临时文件路径，苹果在这个 API 的说明中指出：系统会把请求的文件数据复制到这个路径对应的地址，并且在回调执行完毕后删除临时文件。
        if let itemProvider: NSItemProvider = results.first?.itemProvider {
            itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { (url, error) in

                guard error == nil else {
                    self.methodChannel.invokeMethod("picture-ios", arguments: "error")
                    return
                }
                guard let fileStr:String = url?.path else {
                    self.methodChannel.invokeMethod("picture-ios", arguments: "fileError")
                    return
                }
                self.methodChannel.invokeMethod("picture-ios", arguments: fileStr)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }

    /// 通道
    var methodChannel: FlutterMethodChannel!

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    requestUserPrivateState()

    // 调用相册
    let vc: FlutterViewController = self.window.rootViewController as! FlutterViewController

    var config = PHPickerConfiguration()
    config.selectionLimit = 1
    config.filter = PHPickerFilter.images
    let picker = PHPickerViewController(configuration: config)
    picker.modalPresentationStyle = .fullScreen
    picker.delegate = self

    methodChannel = FlutterMethodChannel(name: "picture_page", binaryMessenger: vc as! FlutterBinaryMessenger)
    methodChannel.setMethodCallHandler { (call, result) in
        if call.method == "picture" {
            print("call method - ", call.method)
            vc.present(picker, animated: true, completion: nil)
        }
    }


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    /// 获取用户权限
    func requestUserPrivateState() {
        let level: PHAccessLevel = PHAccessLevel.readWrite
        // 请求权限, limited 权限仅在 accessLevel 为 readAndWrite 时生效
        PHPhotoLibrary.requestAuthorization(for: level) { (status) in
            switch status {
            case .authorized:
                print("-- authorized 授权")
            case .denied:
                print("-- denied 拒绝")
            case .limited:
                print("-- limited 有限的")
            default:
                break
            }
        }
    }
}
