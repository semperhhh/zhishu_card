public let ZPHFile = ZPHFileManager.share

public class ZPHFileManager {

    let fileManager: FileManager = FileManager()

    static let share = ZPHFileManager()
    
    public init() {}

    public func write(_ filePath: String = "",_ name: String, _ data: Data) -> (Bool, String) {

        let DocumentsPath: String = "\(NSHomeDirectory())/Documents/"
        let path = "\(DocumentsPath)\(filePath)"
        let dataPath = "\(path)/\(name)"

        if !fileManager.fileExists(atPath: path) {
            do {
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("文件目录创建失败")
            }
        }

        return (fileManager.createFile(atPath: dataPath, contents: data, attributes: nil), dataPath)
    }
}
