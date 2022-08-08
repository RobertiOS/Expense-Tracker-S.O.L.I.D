import SwiftUI
import CoreData

@main
struct AppMain: App {
  static var container: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "ExpensesModel")
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()

  static var previewContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "ExpensesModel")
    container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }

    for index in 0..<5 {
      let newItem = ExpenseModel(context: container.viewContext)
      newItem.title = "Test Title \(index)"
      newItem.date = Date(timeIntervalSinceNow: Double(index * 60))
      newItem.comment = "Test Comment \(index)"
      newItem.price = Double(index + 1) * 12.3
      newItem.id = UUID()
    }
    do {
      try container.viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }

    return container
  }()

  static let previewItem: ExpenseModel = {
    let newItem = ExpenseModel(context: AppMain.previewContainer.viewContext)
    newItem.title = "Preview Item Title"
    newItem.date = Date(timeIntervalSinceNow: 60)
    newItem.comment = "Preview Item Comment"
    newItem.price = 12.34
    newItem.id = UUID()
    return newItem
  }()

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
