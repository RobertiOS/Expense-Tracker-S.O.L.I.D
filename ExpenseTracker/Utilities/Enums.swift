import Foundation

enum ReportRange: String, CaseIterable {
case monthly = "This month"
case daily = "Today"

  func timeRange() -> (Date, Date) {
    let now = Date()
    switch self {
    case .monthly:
      return (now.startOfMonth, now.endOfMonth)
    case .daily:
      return (now.startOfDay, now.endOfDay)
    }
  }
}
