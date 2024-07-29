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
    
    // MARK: - CoreData Functions
    
    ///  Prepares container for use of loading data.
    ///
    ///  If an error  comes out, it suspends application on SplashScreen, otherwise it directs you to fetch data from database.
    func setContainer(){
        container.loadPersistentStores{[weak self] description, error in
            if let self = self {
                if let _ = error {
                    self.isErrorOccurred = true
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.fetchPasswords()
                }
            }
        }
    }
    
    /// Gets data and updates passwords array with it.
    ///
    /// If an error  comes out, it suspends application on SplashScreen.
    func fetchPasswords(){
        let request = NSFetchRequest<PasswordEntity>(entityName: "PasswordEntity")
        if let fetchedPasswords = try? container.viewContext.fetch(request) {
            passwords = fetchedPasswords
            isLoadingCompleted = true
        } else {
            isErrorOccurred = true
        }
    }
    
    func addPassword(username:String, password:String, comment:String) {
        let passwordEnt = PasswordEntity(context: container.viewContext)
            passwordEnt.name = username
            passwordEnt.password = password
            passwordEnt.comment = comment
       
        try? container.viewContext.save()
        fetchPasswords()
    }
    
    func deletePassword(deletedPassword:PasswordEntity) {
        container.viewContext.delete(deletedPassword)
        try? container.viewContext.save()
        fetchPasswords()
        
       
    }
}
