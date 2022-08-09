import Foundation
import Combine

class ReportReader: ObservableObject {
  @Published var currentEntries: [ExpenseModelProtocol] = []
  func saveEntry(
    title: String,
    price: Double,
    date: Date,
    comment: String
  ) { }

  func prepare() {
    assertionFailure("Missing override: Please override this method in the subclass")
  }
}
