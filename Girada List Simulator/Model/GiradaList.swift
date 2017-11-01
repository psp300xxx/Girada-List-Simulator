//
//  GiradaList.swift
//  Girada List Simulator
//
//  Created by Luigi De Marco on 27/10/17.
//  Copyright © 2017 Luigi De Marco. All rights reserved.
//

import Foundation

public protocol GiradaListDelegate {
    
    func giradaList(orderAdded : GiradaOrder)
    
}

public class GiradaList {
    
    var delegate : GiradaListDelegate!
    
    private var token = 0
    
    private var orders : [GiradaOrder] = []
    private var completedOrders : [GiradaOrder] =  []
    
    public func add(newOrder : GiradaOrder){
        if let order = self.get(indexOrder: token) {
            order.add(friendOrder: newOrder)
            if order.isCompleted {
                token += 1
                completedOrders.append(order)
            }
        }
        orders.append(newOrder)
        if let delegate = self.delegate {
            delegate.giradaList(orderAdded: newOrder)
        }
    }
    
    public var completedCount : Int {
        return completedOrders.count
    }
    
    public func orderHasToken(order : GiradaOrder) -> Bool {
        return orders[token] == order
    }
    
     public func get(indexOrder : Int) -> GiradaOrder? {
        if indexOrder >= orders.count || indexOrder < 0 {
            return nil
        }
        return orders[indexOrder]
    }
    
    public func get(completedOrder index : Int) -> GiradaOrder {
        return completedOrders[index]
    }
    
    private  var listFillerPvt : GiradaListFiller!
    public  var listFiller : GiradaListFiller {
        get {
            if let thread = listFillerPvt {
                return thread
            }
            listFillerPvt = GiradaListFiller(list: self)
            return listFillerPvt!
        }
    }
    
    public func removeFirst() -> GiradaOrder? {
        if orders.count > 0 {
            token -= 1
            return orders.removeFirst()
        }
        return nil
    }
    
    public var count : Int {
        get {
            return orders.count
        }
    }
    
}

public class GiradaListFiller : Thread {
    
    let giradaList : GiradaList
    var TIME_BEETWEEN_ORDERS : TimeInterval = 1
    var isActive = true

    
    public init(list : GiradaList) {
        giradaList = list
    }
    
    public override func main() {
        while isActive {
            Thread.sleep(forTimeInterval: TIME_BEETWEEN_ORDERS)
            giradaList.add(newOrder: GiradaOrder())
        }
    }
    
}
