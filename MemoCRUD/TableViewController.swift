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
            //(noti) : 매개변수
            [weak self] (noti) in
            //실행코드
            self?.tableView.reloadData()
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataManager.getInstance.memoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "part", for: indexPath)

        let target = DataManager.getInstance.memoList[indexPath.row]
        cell.textLabel?.text = target.savedContent
        cell.detailTextLabel?.text = currentTime.string(for: target.savedDate)
        
        return cell
    }
    
        
    //데이터 전달(세그웨이 방식)
    //네이게이션 전에 약간의 준비를 하는 것이 좋을 것이다. : view 전환전에 할일 여기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //각 셀
        if let cell = sender as? UITableViewCell,
           //각 셀의 index
           let indexPath = self.tableView.indexPath(for: cell) {
            
            //목적지
            if let vc = segue.destination as? UpdateMemoViewController {
                //데이터 넣어주기
                vc.memo = DataManager.getInstance.memoList[indexPath.row]
            }
        }
    }

}
