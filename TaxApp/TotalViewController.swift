//
//  TotalViewController.swift
//  TaxApp
//
//  Created by user1 on 2021/11/10.
//

import UIKit

class TotalViewController: UIViewController {
    
    var total: Double = 0

    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "add") != nil {
            for number in userDefaults.object(forKey: "add") as! [String] {
                total = total + Double(number)!
            }
        }
        
        totalLabel.text = String(total)
        
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
