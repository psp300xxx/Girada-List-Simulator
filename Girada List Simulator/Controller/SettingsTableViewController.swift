//
//  SettingsTableViewController.swift
//  Girada List Simulator
//
//  Created by Luigi De Marco on 02/11/17.
//  Copyright © 2017 Luigi De Marco. All rights reserved.
//

import UIKit

enum PickerSource {
    case numberOrders
    case timeOrders
    
    func assign(value : Int) {
        switch self {
        case  .numberOrders:
            assignNumberOrders(value)
        default:
            assignTimeOrders(value)
        }
    }
    
    func formatStringValue(_ value : Int) -> String{
        switch self {
        case .numberOrders:
            return "\(value)"
        default:
            return "\(value) sec"
        }
    }
    
    private func assignNumberOrders(_ value : Int) {
        GiradaOrder.ORDER_TO_COMPLETE = value
    }
    
    private func assignTimeOrders(_ value : Int) {
        if let viewController = AppDelegate.startingVC, let value : TimeInterval = TimeInterval(value) {
            viewController.giradaList.listFiller.TIME_BEETWEEN_ORDERS = value
        }
    }
}

class SettingsTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    let picker : UIPickerView = UIPickerView()
    var buttonActive : UIButton!
    var pickerSource : PickerSource = .numberOrders
    var dictIntervals : [PickerSource : CountableRange<Int>] = [.numberOrders : (2..<11), .timeOrders : (1..<61)]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override var canBecomeFirstResponder: Bool  {
        return true
    }
    
    override var inputView: UIView? {
        return picker
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let range = dictIntervals[pickerSource] {
            let selectedValue = row + range.first!
            pickerSource.assign(value : selectedValue)
            if let button = buttonActive {
                DispatchQueue.main.async {
                    button.titleLabel?.text = self.pickerSource.formatStringValue(selectedValue)
                }
            }
            DispatchQueue.main.async {
                self.resignFirstResponder()
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let result : String!
        if let range = dictIntervals[pickerSource] {
            result = "\(row+range.first!)"
        }
        else {
            result = "NO"
        }
        let attResult = NSAttributedString(string: result!)
        return attResult
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dictIntervals[pickerSource]!.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        picker.delegate = self
        picker.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeTime(_ sender: UIButton) {
        buttonActive = sender
        pickerSource = .timeOrders
        picker.reloadAllComponents()
        self.becomeFirstResponder()
    }
    // MARK: - Table view data source
    
    @IBAction func changeOrdersToComplete(_ sender: UIButton) {
        buttonActive = sender
        pickerSource = .numberOrders
        picker.reloadAllComponents()
        self.becomeFirstResponder()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
