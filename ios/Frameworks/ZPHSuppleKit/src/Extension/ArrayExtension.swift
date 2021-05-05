public extension Dictionary {
    /// 字典转json
    var toJSONString: String {
        guard JSONSerialization.isValidJSONObject(self) else {
            print("无法解析出JSONString")
            return ""
        }
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return ""
        }
        let jsonString = String(data: data, encoding: .utf8)
        return jsonString ?? ""
    }
}

public extension Array {
    /// 字典转json
    var toJSONString: String {
        guard JSONSerialization.isValidJSONObject(self) else {
            print("无法解析出JSONString")
            return ""
        }
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return ""
        }
        let jsonString = String(data: data, encoding: .utf8)
        return jsonString ?? ""
    }
}
