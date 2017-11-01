//
//  ViewController.swift
//  Girada List Simulator
//
//  Created by Luigi De Marco on 27/10/17.
//  Copyright © 2017 Luigi De Marco. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , GiradaOrderDelegate, GiradaListDelegate{
    
    let deleteOrderFrequency = 5
    var orderCount = 1
    
    
    func giradaList(orderAdded: GiradaOrder) {
        if orderCount % deleteOrderFrequency == 0 {
            giradaList.removeFirst()
        }
        orderCount += 1
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    
    func orderCompleted(order: GiradaOrder) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    var isHere = false
    @IBOutlet var tableView : UITableView!
    let giradaList : GiradaList = GiradaList()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        GiradaOrder.delegate = self
        giradaList.listFiller.start()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        giradaList.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        isHere = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return giradaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "giradaCell") as! GiradaListTableViewCell
        if let order = giradaList.get(indexOrder: indexPath.row){
            cell.nameLabel.text = "\(order)"
            cell.fractionLabel.text = "\(order.friendsGained())/3"
            if giradaList.orderHasToken(order: order) {
                cell.backgroundColor = UIColor.red
            }
            else {
                cell.backgroundColor = UIColor.clear
            }
            if let time = order.timeCompleted {
                cell.timeCompletedLabel.text = "\(Int(time))"
            }
            else {
                cell.timeCompletedLabel.text = "NA"
            }
        }
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCompleted" {
            let vc = segue.destination as! CompletedOrderTableTableViewController
            vc.giradaList = self.giradaList
        }
    }


}

