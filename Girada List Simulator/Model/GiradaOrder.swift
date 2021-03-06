//
//  Order.swift
//  Girada List Simulator
//
//  Created by Luigi De Marco on 27/10/17.
//  Copyright © 2017 Luigi De Marco. All rights reserved.
//

import Foundation

public protocol GiradaOrderDelegate {
    
    func orderCompleted(order : GiradaOrder)
    
    func order(friendsGained : GiradaOrder)
    
}

public class GiradaOrder : NSObject {
    
    public static var delegate : GiradaOrderDelegate!
    
    private static var ORDER_TO_COMPLETE_PVT = 3
    
    private static var observers : [GiradaList] = []
    
    public static var ORDER_TO_COMPLETE : Int {
        get {
            return ORDER_TO_COMPLETE_PVT
        }
        set {
            ORDER_TO_COMPLETE_PVT = newValue
            notify(ORDER_TO_COMPLETE_PVT)
        }
    }
    
    private static func notify(_ value : Int){
        for i in observers {
            i.update()
        }
    }
    
    public static func addObserver(newList : GiradaList){
        observers.append(newList)
    }
    
    private static var NEXT_ORDER_INDEX = 0
    
    let index : Int
    
    private var friendOrders : [GiradaOrder] = []
    
    public var friends : [GiradaOrder] {
        get {
            return friendOrders
        }
    }
    
    public var isCompleted : Bool {
        get {
            return friendOrders.count == GiradaOrder.ORDER_TO_COMPLETE
        }
    }
    
    public override var description: String {
        get {
            return "GiradaOrder:\(self.index)"
        }
    }
    
    public func friendsGained() -> Int {
        return friendOrders.count
    }
    
    public let dateCreation : Date
    
    private var dateCompletion : Date?
    
    public var timeCompleted : TimeInterval? {
        get {
            if let completion = dateCompletion {
                return completion.timeIntervalSince(dateCreation)
            }
            return nil
        }
    }
    
    public override init(){
        index = GiradaOrder.NEXT_ORDER_INDEX
        GiradaOrder.NEXT_ORDER_INDEX += 1
        dateCreation = Date()
    }
    
    public func add(friendOrder : GiradaOrder){
        self.friendOrders.append(friendOrder)
        if isCompleted {
            dateCompletion = Date()
            if let delegate = GiradaOrder.delegate {
                delegate.orderCompleted(order: self)
            }
        }
        else {
            if let delegate = GiradaOrder.delegate {
                delegate.order(friendsGained: self)
            }
        }
    }
    
}
