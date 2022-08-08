import SwiftUI
import Combine

struct DailyExpensesView: View {
  @State private var isAddPresented = false
  @ObservedObject var dataSource: DailyReportsDataSource

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
  static var previews: some View {
    let reportsDataSource = DailyReportsDataSource(viewContext: AppMain.previewContainer.viewContext)
    DailyExpensesView(dataSource: reportsDataSource)
  }
}
