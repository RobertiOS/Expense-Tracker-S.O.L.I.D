import Foundation
import CoreData


extension ExpenseModel {
  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<ExpenseModel> {
    return NSFetchRequest<ExpenseModel>(entityName: "ExpenseModel")
  }

  @NSManaged public var title: String?
  @NSManaged public var price: Double
  @NSManaged public var comment: String?
  @NSManaged public var date: Date?
  @NSManaged public var id: UUID?
}

extension ExpenseModel: Identifiable {
}
