import SwiftUI
import Combine

struct ExpensesView: View {
  @State private var isAddPresented = false
  @ObservedObject var dataSource: ReportReader

  var body: some View {
    VStack {
      List {
        ForEach(dataSource.currentEntries, id: \.id) { item in
          ExpenseItemView(expenseItem: item)
        }
      }
      TotalView(totalExpense: dataSource.currentEntries.reduce(0) { $0 + $1.price })
    }
    .toolbar {
      Button(action: {
        isAddPresented.toggle()
      }, label: {
        Image(systemName: "plus")
      })
    }
    .fullScreenCover(
      isPresented: $isAddPresented) {
      AddExpenseView { title, price, time, comment in
        dataSource.saveEntry(title: title, price: price, date: time, comment: comment)
      }
    }
    .onAppear {
      dataSource.prepare()
    }
  }
}

struct DailyExpensesView_Previews: PreviewProvider {
  
  struct PreviewExpenseEntry: ExpenseModelProtocol {
    var title: String?
    var price: Double
    var comment: String?
    var date: Date?
    var id: UUID? = UUID()
  }
  
  class PreviewReportsDataSource: ReportReader {
    override init() {
      super.init()
      for index in 1..<6 {
        saveEntry(
          title: "Test Title \(index)",
          price: Double(index + 1) * 12.3,
          date: Date(timeIntervalSinceNow: Double(index * -60)),
          comment: "Test Comment \(index)")
      }
    }

    override func prepare() {
    }

    override func saveEntry(
      title: String,
      price: Double,
      date: Date,
      comment: String
    ) {
      let newEntry = PreviewExpenseEntry(
        title: title,
        price: price,
        comment: comment,
        date: date)
      currentEntries.append(newEntry)
    }
  }


  static var previews: some View {
    ExpensesView(dataSource: PreviewReportsDataSource())
  }

}
