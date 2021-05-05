import UIKit

public class ZPHGCDTimer {

    /// 单例
    static public let share = ZPHGCDTimer()

    var timerContainer = [String: DispatchSourceTimer]()
    
    public init() {}

    /// 创建name的定时
    /// - Parameters:
    ///   - name: 名字
    ///   - queue: 队列
    ///   - deadline: 开始时间
    ///   - repeating: 重复
    public func createTimer(name: String, queue: DispatchQueue = DispatchQueue.global(), deadline: DispatchTime = .now(), repeating: DispatchTimeInterval = .never, eventCallback: @escaping () -> Void) {
        if name.isEmpty {
            return
        }
        var timer = timerContainer[name]
        if !timerContainer.keys.contains(name) {
            timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
            timer?.resume()
            timerContainer[name] = timer
        }
        timer?.schedule(deadline: deadline, repeating: repeating)
        timer?.setEventHandler {
            eventCallback()
        }
    }

    /// 销毁name定时
    /// - Parameter name: 名字
    public func cancelTimer(name: String) {
        if timerContainer.keys.contains(name) {
            let timer = timerContainer[name]
            timer?.cancel()
            timerContainer.removeValue(forKey: name)
        }
    }
}
