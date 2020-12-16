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
        if let itemProvider: NSItemProvider = results.first?.itemProvider {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                let img: UIImage? = object as? UIImage
                self?.methodChannel.invokeMethod("picture-ios", arguments: "img")
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

    // 调用相册
    let vc: FlutterViewController = self.window.rootViewController as! FlutterViewController

    var config = PHPickerConfiguration()
    config.selectionLimit = 1
    config.filter = PHPickerFilter.images
    let picker = PHPickerViewController(configuration: config)
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
}
