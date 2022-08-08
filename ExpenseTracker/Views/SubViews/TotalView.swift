import SwiftUI

struct TotalView: View {
  var totalExpense: Double = 0
  var body: some View {
    HStack {
      Text("Total")
      Spacer()
      Text(String(format: "%.2f", totalExpense))
        .font(.title)
    }
    .padding(.horizontal)
  }
}

struct TotalView_Previews: PreviewProvider {
  static var previews: some View {
    TotalView(totalExpense: 123.45)
  }
}
