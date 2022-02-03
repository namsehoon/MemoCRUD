//
//  DataManager.swift
//  MemoCRUD


import Foundation
import CoreData


class DataManager {
    
    //싱글톤 getInstance
    static let getInstance = DataManager()
    
    //하나의 인스턴으로 앱 전체에 공유를 위해
    private init() {
        
    }
    
    //coredata entity
    var memoList = [Memo]()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    //MARK: 모델에서 데이터를 가져오는 것을 fetch라고 한다.
    func fetchMemo() {
        //db에서 데이터를 읽기위해 요청할 객체를 만들어줌
        let request:NSFetchRequest<Memo> = Memo.fetchRequest()
        
        //데이터 정렬
        let sortByDateDesc = NSSortDescriptor(key: "savedDate", ascending: false)
        
        request.sortDescriptors = [sortByDateDesc]
        
        do {
            memoList = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    //MARK: 메모 insert
    func addNewMemo(_ memo:String?) {
        // 객체 초기화 및 insert
        let newMemo = Memo(context: mainContext)
        
        newMemo.savedContent = memo
        newMemo.savedDate = Date()
        
        //삽입
        memoList.insert(newMemo, at: 0)
        
        //메모저장
        saveContext()
    }
    
    
    
    
    
    
    //MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model"); container.loadPersistentStores(completionHandler:{(storeDescription,error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


    //MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                
            }
            
        }
        
    }

}





