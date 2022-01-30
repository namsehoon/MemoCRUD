//
//  UpdateMemoViewController.swift
//  MemoCRUD
//
//  Created by 남세훈 on 2022/01/28.
//

import UIKit

class UpdateMemoViewController: UIViewController {
    
    var memo:dummylist?
    
    let currentDate:DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
   


}

//viewControllerdptj tableViewDataSource를 채택해야 한다면,
extension UpdateMemoViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentPart", for: indexPath)
            
            cell.textLabel?.text = memo?.content
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "date", for: indexPath)
            cell.textLabel?.text = currentDate.string(for: memo?.date)
            
            return cell
            
        default:
            fatalError()
        }
        
    }
    
    
}
