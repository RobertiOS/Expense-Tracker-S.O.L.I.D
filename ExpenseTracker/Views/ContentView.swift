import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink(
          "Today",
          destination: dailyReport
            .navigationTitle("Today"))
        NavigationLink(
          "This Month",
          destination: monthlyReport
            .navigationTitle("This Month"))
      }
      .navigationTitle("Reports")
    }
  }

  var dailyReport: DailyExpensesView {
    let dailyDataSource = DailyReportsDataSource()
    return DailyExpensesView(dataSource: dailyDataSource)
  }

  var monthlyReport: MonthlyExpensesView {
    let monthlyDataSource = MonthlyReportsDataSource()
    return MonthlyExpensesView(dataSource: monthlyDataSource)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
