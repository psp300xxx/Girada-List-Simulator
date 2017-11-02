//
//  OrderDetailViewController.swift
//  Girada List Simulator
//
//  Created by Luigi De Marco on 01/11/17.
//  Copyright © 2017 Luigi De Marco. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GiradaOrderDelegate {
    
    
    
    var order : GiradaOrder!
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var fractionCompletedLabel : UILabel!
    @IBOutlet var timeCompleteLabel : UILabel!
    @IBOutlet var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadView()

        // Do any additional setup after loading the view.
    }
    
    private func reloadView(){
        DispatchQueue.main.async {
            if let order = self.order {
                self.nameLabel.text = order.description
                self.fractionCompletedLabel.text = "\(order.friendsGained())/\(GiradaOrder.ORDER_TO_COMPLETE)"
                if let timeToComplete = order.timeCompleted {
                    self.timeCompleteLabel.text = "\(Int(timeToComplete))"
                }
                else {
                    self.timeCompleteLabel.text = "Has still to complete"
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func order(friendsGained: GiradaOrder) {
        if friendsGained == order && order != nil {
            let order = self.order!
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.fractionCompletedLabel.text = "\(order.friendsGained())/3"
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell")
        if let order = order {
            cell?.textLabel?.text = order.friends[indexPath.row].description
        }
        cell?.detailTextLabel?.text = ""
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GiradaOrder.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.order = order.friends[indexPath.row]
        self.reloadView()
    }
    
    
    func orderCompleted(order: GiradaOrder) {
        if order == self.order {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            if let time = order.timeCompleted {
                DispatchQueue.main.async {
                    self.timeCompleteLabel.text = "\(Int(time))"
                    self.fractionCompletedLabel.text = "\(order.friendsGained())/\(GiradaOrder.ORDER_TO_COMPLETE)"
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let order = order {
            return order.friendsGained()
        }
        return 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
