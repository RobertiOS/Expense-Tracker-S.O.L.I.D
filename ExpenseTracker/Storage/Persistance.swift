import CoreData

struct PersistenceController {
  static let shared = PersistenceController()
  
  let container: NSPersistentContainer

  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "ExpensesModel")
    if inMemory {
      container.persistentStoreDescriptions.first?.url = URL(
        fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }
  
  static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext
    for index in 1..<6 {
      let newItem = ExpenseModel(context: viewContext)
      newItem.title = "Test Title \(index)"
      newItem.date = Date(timeIntervalSinceNow: Double(index * -60))
      newItem.comment = "Test Comment \(index)"
      newItem.price = Double(index + 1) * 12.3
      newItem.id = UUID()
    }
    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
  }()

  static let previewItem: ExpenseModel = {
    let newItem = ExpenseModel(context: preview.container.viewContext)
    newItem.title = "Preview Item Title"
    newItem.date = Date(timeIntervalSinceNow: 60)
    newItem.comment = "Preview Item Comment"
    newItem.price = 12.34
    newItem.id = UUID()
    return newItem
  }()


}
