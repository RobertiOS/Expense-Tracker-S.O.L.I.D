import SwiftUI

struct ExpenseItemView: View {
  let expenseItem: ExpenseModelProtocol

  static let dateFormatter: DateFormatter = {
    var dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    return dateFormatter
  }()

  static let timeFormatter: DateFormatter = {
    var dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .medium
    return dateFormatter
  }()

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(expenseItem.title ?? "")
        Spacer()
        Text(String(format: "%.2f", expenseItem.price))
      }
      Text(expenseItem.comment ?? "")
        .font(.caption)
      HStack {
        Text("\(expenseItem.date ?? Date(), formatter: Self.dateFormatter)")
        Spacer()
        Text("\(expenseItem.date ?? Date(), formatter: Self.timeFormatter)")
      }
    }
  }
}

struct ExpenseItemView_Previews: PreviewProvider {
  struct PreviewExpenseModel: ExpenseModelProtocol {
    var title: String? = "Preview Item"
    var price: Double = 123.0
    var comment: String? = "This is a preview item"
    var date: Date? = Date()
    var id: UUID? = UUID()
  }
  
  static var previews: some View {
    ExpenseItemView(expenseItem: PreviewExpenseModel())
  }
}
