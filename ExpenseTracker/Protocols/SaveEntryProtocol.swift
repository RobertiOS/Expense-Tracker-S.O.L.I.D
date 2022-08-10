import Foundation

protocol SaveEntryProtocol {
  func saveEntry(
    title: String,
    price: Double,
    date: Date,
    comment: String)
}
