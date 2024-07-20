import Foundation
import CoreData

class CoreData:ObservableObject {
    @Published private(set) var passwords:[PasswordEntity] = []
    @Published private(set) var isErrorOccurred = false
    @Published private(set) var isLoadingCompleted = false
    private let container:NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "Passwords")
    }
    
    func setContainer(){
        container.loadPersistentStores{[weak self] description, error in
            if let _ = error {
                self?.isErrorOccurred = true
            }
        }
    }
    
    func fetchPasswords(){
        let request = NSFetchRequest<PasswordEntity>(entityName: "PasswordEntity")
        if let fetchedPasswords = try? container.viewContext.fetch(request) {
            passwords = fetchedPasswords
            isLoadingCompleted = true
        } else {
            isErrorOccurred = true
        }
    }
}
