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
        if let itemProvider: NSItemProvider = results.first?.itemProvider {
            itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { (url, error) in
                guard let u = url else {
                    return
                }
                self.methodChannel.invokeMethod("picture-ios", arguments: u)
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
