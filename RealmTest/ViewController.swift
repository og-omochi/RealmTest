//
//  ViewController.swift
//  RealmTest
//
//  Created by 小笠原啓太 on 2020/10/05.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var table: UITableView!
    
    // モデルクラスを使用し、取得データを格納する変数を作成
    var tableCells: Results<Memo>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Realmインスタンス取得
        let realm = try! Realm()
         
        // データ全権取得
        self.tableCells = realm.objects(Memo.self)
    }

    @IBAction func submitButton(_ sender: Any) {
        
        // モデルクラスのインスタンスを取得
        let MemoInstance:Memo = Memo()
         
        // テキスト入力値をインスタンスに詰める
        MemoInstance.memo = self.textField.text
         
        // Realmインスタンス取得
        let realm = try! Realm()
         
        // DB登録処理
        try! realm.write {
            realm.add(MemoInstance)
        }
         
        // テーブル再読み込み
        self.table.reloadData()
        
    }
    
    // cellの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableCells.count
    }
     
 
    // cellに値を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         
        let tmpCell: Memo = self.tableCells[(indexPath as NSIndexPath).row];
         
        cell.textLabel?.text = tmpCell.memo
         
        return cell;
    }
    
    
}

