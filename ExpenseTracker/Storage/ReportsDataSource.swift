import CoreData
import Combine

class ReportsDataSource: ReportReader, SaveEntryProtocol {
  var viewContext: NSManagedObjectContext
  let reportRange: ReportRange

  init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext, reportRange: ReportRange) {
    self.viewContext = viewContext
    self.reportRange = reportRange
    super.init()
    prepare()
  }

  override func prepare() {
    currentEntries = getEntries()
  }

  private func getEntries() -> [ExpenseModelProtocol] {
    let fetchRequest: NSFetchRequest<ExpenseModel> = ExpenseModel.fetchRequest()
    fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ExpenseModel.date, ascending: false)]
    
    let (startDate, endDate) = reportRange.timeRange()
    
    fetchRequest.predicate = NSPredicate(
      format: "%@ <= date AND date <= %@",
      startDate as CVarArg,
      endDate as CVarArg)
    do {
      let results = try viewContext.fetch(fetchRequest)
      return results
    } catch let error {
      print(error)
      return []
    }
  }

  func saveEntry(title: String, price: Double, date: Date, comment: String) -> Bool {
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
    return true
  }

  func delete(entry: ExpenseModel) {
    viewContext.delete(entry)
    try? viewContext.save()
  }
}
