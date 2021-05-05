public enum IntTimeUnit {
    case seconds, minutes, hours
}

public extension Int {
    
    /// int转时间格式化
    /// - Parameter dateformatter: 时间的格式
    /// - Returns: 时间字符串
    func toTimeFormatter(_ units: IntTimeUnit = .seconds, dateformatter: String = "HH:mm:ss") -> String {
        if self == 0 {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = dateformatter
        var c = DateComponents()
        switch units {
        case .seconds:
            c.second = self
        case .minutes:
            c.minute = self
        default:
            c.hour = self
        }
        let d: Date = Calendar.current.date(from: c) ?? Date()
        let str = formatter.string(from: d)
        return str
    }
}
