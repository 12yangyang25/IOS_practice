//
//  ViewController.swift
//  simpleTable
//
//  Created by 양가연 on 2023/01/12.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
//    @IBOutlet var pushBtn:UIButton!
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    let customCellIdentifier:String = "customCell"
    
    let Korean: [String] = ["가", "나", "다", "라", "마", "바", "사"]
    let English: [String] = ["A", "B", "C", "D", "E", "F", "G"]
    var dates:[Date] = []
    
    @IBAction func touchUpBtn(){
        dates.append(Date());
        self.tableView.reloadData()
    }
    
    let dateFormater: DateFormatter = {
        let formater: DateFormatter = DateFormatter()
        formater.dateStyle = .medium
        return formater
    }()
    
    let timeFormater: DateFormatter = {
        let formater: DateFormatter = DateFormatter()
        formater.timeStyle = .medium
        return formater
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //섹션에 몇개의 row를 표현해줘야 하냐
        switch section{
        case 0:
            return Korean.count
        case 1:
            return English.count
        case 2:
            return dates.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //row에 해당되는 cell을 달라
        
        if indexPath.section < 2{
            
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
            
            let text:String = indexPath.section == 0 ? Korean[indexPath.row] : English[indexPath.row];
            cell.textLabel?.text = text;
            
            return cell
        }
        
        else {
            guard let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell
            else {
            preconditionFailure("테이블 뷰 셀 가져오기 실패")
            }
            
            var text:String = self.dateFormater.string(from: self.dates[indexPath.row])
            cell.leftLabel?.text = text
            
            text = self.timeFormater.string(from: self.dates[indexPath.row])
            cell.rightLabel?.text = text
            
            print(timeFormater.string(from: self.dates[indexPath.row]))
            print(dateFormater.string(from: self.dates[indexPath.row]))
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < 2{
            return section == 0 ? "한글" : "영어"
        }
        else{
            return nil
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: SecondViewController = segue.destination as? SecondViewController else {
            return
        }
        
        guard let cell:UITableViewCell = sender as? UITableViewCell else{
            return
        }
        
        nextViewController.textToset = cell.textLabel?.text
        
    }
}


