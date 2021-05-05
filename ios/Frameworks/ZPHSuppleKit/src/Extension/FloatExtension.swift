public extension Float {

    // 四舍五入
    var toInt: Int {
        Int(self.rounded())
    }
    // 舍
    var toIntDown: Int {
        Int(self.rounded(.down))
    }
    // 入
    var toIntUp: Int {
        Int(self.rounded(.up))
    }
    /// 保留对应的小数位
    /// 123.123123 -> 123.123
    /// 123.01 -> 123.0
    /// - Parameter mult: 位数
    /// - Parameter rule: 规则
    /// - Returns: float
    func toRounded(mult: Int, rule: FloatingPointRoundingRule) -> Float {
        guard mult > 0 else {
            return self.rounded()
        }
        let div: Decimal = pow(10, mult)
        let m: Float = Float(String(div.description)) ?? 0
        return (self * m).rounded(rule) / m
    }
}
