//
//  ViewController.swift
//  TaxApp
//
//  Created by user1 on 2021/11/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var numberTextFiled: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var numbers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "add") != nil {
            numbers = userDefaults.object(forKey: "add") as! [String]
        }
    }

    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        if numberTextFiled.text != "" {
            if isNumber(number: numberTextFiled.text!) {
                print("is number")
                switch sender.selectedSegmentIndex {
                case 0:
                    resultLabel.text = String(calcTax(number: numberTextFiled.text!, tax: 1.1))
                case 1:
                    resultLabel.text = String(calcTax(number: numberTextFiled.text!, tax: 1.08))
                default:
                    break
                }
            } else {
                print("error...")
            }
        }
    }
    
    func calcTax(number:String, tax:Double) -> Double{
        return Double(number)! * tax
    }
    
    @IBAction func addButton(_ sender: Any) {
        if resultLabel.text != "" {
            let userDefaults = UserDefaults.standard
            numbers.append(resultLabel.text!)
            userDefaults.set(numbers, forKey: "add")
            tableView.reloadData()
        }
    }
    
    func isNumber(number: String) ->Bool {
        let pattern = "^[0-9]*$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let matches = regex.matches(in: number, range: NSRange(location:0, length:number.count))
        return matches.count == 1 ? true : false
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = numbers[indexPath.row]
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            numbers.remove(at: indexPath.row)
            let userDefaults = UserDefaults.standard
            userDefaults.set(numbers, forKey: "add")
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}
