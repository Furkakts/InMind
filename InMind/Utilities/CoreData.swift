import Foundation
import CoreData

class CoreData:ObservableObject {
    @Published private(set) var passwords:[PasswordEntity] = []
    @Published private var isErrorOccurred = false
    @Published private var isLoadingCompleted = false
    private var container = NSPersistentContainer()
    
    init(){
        setContainer()
        fetchPasswords()
    }
    
    private func setContainer(){
        container = NSPersistentContainer(name: "Passwords")
        container.loadPersistentStores{[weak self] description, error in
            if let _ = error {
                self?.isErrorOccurred = true
            }
        }
    }
    
    private func fetchPasswords(){
        let request = NSFetchRequest<PasswordEntity>(entityName: "PasswordEntity")
        if let fetchedPasswords = try? container.viewContext.fetch(request) {
            passwords = fetchedPasswords
            isLoadingCompleted = true
        } else {
            isErrorOccurred = true
        }
    }
}
