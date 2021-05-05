import UIKit
import Flutter
import PhotosUI

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

    }

    /*
    // MARK: PHPickerViewControllerDelegate
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard results.count > 0 else {
            picker.dismiss(animated: true, completion: nil)
            return
        }

        // UTType.image.identifier 图片格式
        // 这个 api 返回的是一个 URL 类型的临时文件路径，苹果在这个 API 的说明中指出：系统会把请求的文件数据复制到这个路径对应的地址，并且在回调执行完毕后删除临时文件。
        if let itemProvider: NSItemProvider = results.first?.itemProvider {

            /*
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
 */

            itemProvider.loadObject(ofClass: UIImage.self) { (img, error) in

                guard error == nil else {
                    return
                }
                guard let image = img as? UIImage else {
                    return
                }

                if let imgData = image.jpegData(compressionQuality: 1.0) {

                    let result = ZPHFile.write("images", "head.jpeg", imgData)
                    if result.0 {
                        self.methodChannel.invokeMethod("picture-ios", arguments: result.1)
                    }
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
*/

    /// 通道
    var methodChannel: FlutterMethodChannel!

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

//    DispatchQueue.main.async {
//        //主动弹出照片选择器
//        PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self.window.rootViewController!)
//    }

    // 调用相册
    let vc: FlutterViewController = self.window.rootViewController as! FlutterViewController

    methodChannel = FlutterMethodChannel(name: "report_page", binaryMessenger: vc as! FlutterBinaryMessenger)
    methodChannel.setMethodCallHandler { (call, result) in
        if call.method == "report_page_push" {
            print("周报界面")
            let report = PHReportViewController()
            let navi = PHNaviViewController(rootViewController: report)
            navi.modalPresentationStyle = .fullScreen
            self.window.rootViewController?.present(navi, animated: true, completion: nil)
        }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    /*
    func selectUserPrivateState() {
        let level: PHAccessLevel = PHAccessLevel.readWrite
        let status: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus(for: level)
        switch status {
        case .authorized:
            print("-- authorized 授权")
            self.window.rootViewController?.present(self.pickerVC, animated: true, completion: nil)
        case .denied:
            print("-- denied 拒绝")
        case .limited:
            print("-- limited 有限的")
//            requestUserPrivateState()
            self.window.rootViewController?.present(self.pickerVC, animated: true, completion: nil)
        case .notDetermined:
            print("-- notDetermined 未确定")
            requestUserPrivateState()
        default:
            break
        }
    }

    /// 请求用户权限
    func requestUserPrivateState() {
        let level: PHAccessLevel = PHAccessLevel.readWrite
        // 请求权限, limited 权限仅在 accessLevel 为 readAndWrite 时生效
        PHPhotoLibrary.requestAuthorization(for: level) { (status) in
            switch status {
            case .authorized:
                print("--- authorized 授权")
                self.window.rootViewController?.present(self.pickerVC, animated: true, completion: nil)
            case .denied:
                print("--- denied 拒绝")
            case .limited:
                print("--- limited 有限的")
                self.limtShow()
            case .notDetermined:
                print("--- 未确定的")
            default:
                break
            }
        }
    }

    func limtShow() {
        let option: PHFetchOptions = PHFetchOptions()
        option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchList = PHAsset.fetchAssets(with: .image, options: option)
        var nmList: [PHAsset] = []
        fetchList.enumerateObjects { (asset, idx, stop) in
            print(asset.value(forKey: "filename") ?? "filename = nil")
            nmList.append(asset)
        }
        for asset in nmList {
            let options = PHImageRequestOptions()
            options.deliveryMode = .highQualityFormat
            PHImageManager.default().requestImage(for: asset, targetSize: UIScreen.main.bounds.size, contentMode: .aspectFit, options: options) { (result, info) in

            }
        }
    }
    */
}

/*
-(void)limtShow{
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    //                  //ascending 为YES时，按照照片的创建时间升序排列;为NO时，则降序排列
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    self.fetchList = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:option];//PHFetchResult这个类型可以当成NSArray使用。此时所有可获取照片都已拿到，可以刷新UI进行显示

    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    [self.fetchList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        PHAsset *asset = (PHAsset *)obj;

        NSLog(@"照片名%@", [asset valueForKey:@"filename"]);

        [assets addObject:asset];

    }];
    NSString * numStr = [NSString stringWithFormat:@"全部图片(%ld)",assets.count];
    self.array_collect = [NSMutableArray array];
    NSLog(@"%@",numStr);
    for (PHAsset *set in assets) {

        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];

        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;



        [[PHImageManager defaultManager] requestImageForAsset:set targetSize:[UIScreen mainScreen].bounds.size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {

            //设置处理图片

            [self.array_collect addObject:result];

            [self.collection reloadData];

        }];

        NSLog(@"%lu",(unsigned long)_array_collect.count);
    }
}
 */
