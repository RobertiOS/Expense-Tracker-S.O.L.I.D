import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      List {
        ForEach(ReportRange.allCases, id: \.self) { range in
          NavigationLink(
            range.rawValue,
            destination: expenseView(for: range).navigationTitle(range.rawValue)
          )
        }
      }
      .navigationTitle("Reports")
    }
  }

  func expenseView(for range: ReportRange) -> ExpensesView {
    let dataSource = ReportsDataSource(reportRange: range)
    return ExpensesView(dataSource: dataSource)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
