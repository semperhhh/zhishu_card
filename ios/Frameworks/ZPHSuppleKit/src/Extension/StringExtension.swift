// MARK: - String

public enum DateTimeStampType {
    case TimeStampTypeHaveMS    // 有毫秒
    case TimeStampTypeNotHaveMS // 没有毫秒
}

public extension String {

    /// 时间戳转字符串格式
    /// - Parameter dateFormatter: 格式
    /// - Parameter timeStampType: 时间戳格式
    /// - Returns: 字符串
    func toDateString(dateFormatter: String = "yyyy.MM.dd", timeStampType: DateTimeStampType = .TimeStampTypeNotHaveMS) -> String {
        let interval: Int
        switch timeStampType {
        case .TimeStampTypeHaveMS:
            interval = (Int(self) ?? 1) / 1000
        default:
            interval = (Int(self) ?? 1)
        }
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatter
        let date = Date(timeIntervalSince1970: TimeInterval(interval))
        let result = formatter.string(from: date)
        return result
    }

    /// 时间戳转时间格式 example: 今天 10:00, 昨天 11:00
    /// - Returns: 字符串
    func toTimeChangeNow() -> String {
        guard !self.isEmpty else {
            return ""
        }
        let interval = self.prefix(10)
        // 日期
        let lhsDate = Date().phDate
        let rhsDate = Date(timeIntervalSince1970: TimeInterval(interval) ?? 0).phDate

        // 年
        guard lhsDate.year == rhsDate.year else {
            return self.toDateString(dateFormatter: "yyyy.MM.dd HH:mm")
        }
        // 月
        guard lhsDate.month == rhsDate.month else {
            return self.toDateString(dateFormatter: "MM.dd HH:mm")
        }
        // 天
        if lhsDate.day == rhsDate.day {
            return "今天 \(self.toDateString(dateFormatter: "HH:mm"))"
        } else if lhsDate.day - 1 == rhsDate.day {
            return "昨天 \(self.toDateString(dateFormatter: "HH:mm"))"
        } else {
            return self.toDateString(dateFormatter: "MM.dd HH:mm")
        }
    }
}
