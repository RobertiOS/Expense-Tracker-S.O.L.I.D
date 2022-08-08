import CoreData
import Combine

class DailyReportsDataSource: ObservableObject {
  var viewContext: NSManagedObjectContext

  @Published private(set) var currentEntries: [ExpenseModel] = []

  init(viewContext: NSManagedObjectContext = AppMain.container.viewContext) {
    self.viewContext = viewContext
    prepare()
  }

  func prepare() {
    currentEntries = getEntries()
  }

  private func getEntries() -> [ExpenseModel] {
    let fetchRequest: NSFetchRequest<ExpenseModel> = ExpenseModel.fetchRequest()
    fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ExpenseModel.date, ascending: false)]
    fetchRequest.predicate = NSPredicate(
      format: "%@ <= date AND date <= %@",
      Date().startOfDay as CVarArg,
      Date().endOfDay as CVarArg)
    do {
      let results = try viewContext.fetch(fetchRequest)
      return results
    } catch let error {
      print(error)
      return []
    }
  }

  func saveEntry(title: String, price: Double, date: Date, comment: String) {
    let newItem = ExpenseModel(context: viewContext)
    newItem.title = title
    newItem.date = date
    newItem.comment = comment
    newItem.price = price
    newItem.id = UUID()

    if let index = currentEntries.firstIndex(where: { $0.date ?? Date() < date }) {
      currentEntries.insert(newItem, at: index)
    } else {
      currentEntries.append(newItem)
    }

    try? viewContext.save()
  }

  func delete(entry: ExpenseModel) {
    viewContext.delete(entry)
    try? viewContext.save()
  }
}
