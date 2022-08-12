import SwiftUI

struct AddExpenseView: View {
  @Environment(\.presentationMode) var presentation
  var saveEntryHandler: SaveEntryProtocol

  @State var title: String = ""
  @State var time = Date()
  @State var comment: String = ""
  @State var price: String = ""
  @State var saveDisabled = true
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        Text("Title:")
        TextField("Entry Title", text: $title)
          .onChange(of: title) { _ in
            validateNonEmptyFields()
          }
          .padding(.bottom)
        Text("Amount:")
        TextField("Expense Amount", text: $price)
          .keyboardType(.numberPad)
          .onChange(of: price) { _ in
            validateNonEmptyFields()
          }
          .padding(.bottom)
        DatePicker(
          "Time:",
          selection: $time,
          displayedComponents: [.hourAndMinute])
          .padding(.bottom)
        Text("Comment:")
        TextEditor(text: $comment)
      }
      .padding(.all)
      .navigationBarTitle("Add Expense", displayMode: .inline)
      .navigationBarItems(
        leading: Button(action: cancelEntry) {
          Text("Cancel")
        },
        trailing: Button(action: saveEntry) {
          Text("Save")
        }.disabled(saveDisabled))
    }
  }

  func saveEntry() {
    guard let numericPrice = Double(price), numericPrice > 0 else {
      return
    }

    guard saveEntryHandler.saveEntry(
      title: title,
      price: numericPrice,
      date: time,
      comment: comment)
    else {
      print("Invalid entry.")
      return
    }
    cancelEntry()
  }

  func cancelEntry() {
    presentation.wrappedValue.dismiss()
  }

  func validateNonEmptyFields() {
    guard Double(price) != nil else {
      saveDisabled = true
      return
    }
    saveDisabled = title.isEmpty
  }
}

struct AddExpenseView_Previews: PreviewProvider {

  class PreviewSaveHandler: SaveEntryProtocol {
    func saveEntry(title: String, price: Double, date: Date, comment: String) -> Bool {
      return true
    }
  }

  static var previews: some View {
    AddExpenseView(saveEntryHandler: PreviewSaveHandler())
  }
}
