//
//  NewMemoViewController.swift
//  MemoCRUD
//
//  Created by 남세훈 on 2022/01/27.
//

import UIKit

class NewMemoViewController: UIViewController {

    //todo
    // 1. 작성한 글 save 누르면 이벤트 받고, notifi -> observer -> 메모리스트에 전달
    // 2. cancel 버튼 클릭 시, dismiss
    
    //작성 메모
    @IBOutlet weak var editText: UITextView!
    
    //취소 버튼
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //저장 버튼
    @IBAction func save(_ sender: Any) {
        
        //editText의 text가 null이 아닌지 확인
        guard let memo = editText.text, memo.count > 0 else {
            alert(message: "메모를 입력해 주세요.")
            return
        }
        
        //메모리스트에 새메모 저장
        let newMemo = dummylist(content: memo)
        dummylist.memoList.append(newMemo)
        
        //view를 종료하기 전에 broadcasting
        NotificationCenter.default.post(name: TableViewController.newMemoInsert, object: nil)
    
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
}

//클래스 확장
extension TableViewController {
    //브로드캐스트로 모든 옵저버들에게 등록하기 위함.
    static let newMemoInsert = Notification.Name(rawValue: "newMemoInsert")
}
