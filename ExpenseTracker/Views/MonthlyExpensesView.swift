import SwiftUI
import Combine

struct MonthlyExpensesView: View {
  @State private var isAddPresented = false
  @ObservedObject var dataSource: MonthlyReportsDataSource

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

struct MonthlyExpensesView_Previews: PreviewProvider {
  static var previews: some View {
    let reportsDataSource = MonthlyReportsDataSource(viewContext: AppMain.previewContainer.viewContext)
    MonthlyExpensesView(dataSource: reportsDataSource)
  }
}
