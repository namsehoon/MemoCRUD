//
//  TableViewController.swift
//  MemoCRUD
//
//  Created by 남세훈 on 2022/01/26.
//

import UIKit

class TableViewController: UITableViewController {
    
    //옵저버 등록과 해제를 위한. object-c 메소드 그룹
    var token:NSObjectProtocol?
    
    let currentTime:DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    //옵저버 해제.
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        token = NotificationCenter.default.addObserver(forName: TableViewController.newMemoInsert, object: nil, queue: OperationQueue.main) {
            [weak self] (noti) in
            //테이블 뷰 reload
            self?.tableView.reloadData()
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dummylist.memoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "part", for: indexPath)

        let target = dummylist.memoList[indexPath.row]
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = currentTime.string(for: target.date)
        
        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
