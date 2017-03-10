//
//  DrawerActions.swift
//  onClinic
//
//  Created by MTMAC24 on 3/10/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import Foundation
import UIKit

class DrawerActions {
    
    private var baseVC: BaseViewController
    private var user: User
    
    init(vc: BaseViewController, user: User) {
        self.baseVC = vc
        self.user = user
        
        print("action initialized")
    }
    
    func drawerActions(index: Int32) {
        print(user.role)
        switch user.role {
        case "Doctor":
            drawerActionDoctor(index: index)
            break
        case "Nurse":
            drawerActionNurse(index: index)
            break
        case "Patient":
            drawerActionPatient(index: index)
            break
        default:
            break
        }
    }
    
    private func drawerActionPatient(index: Int32) {
        let topViewController : UIViewController = baseVC.navigationController!.topViewController!
        print("View Controller is : \(topViewController) \n", terminator: "")
        
        switch(index){
        case 0:
            print("Home\n", terminator: "")
            
            baseVC.openViewControllerBasedOnIdentifier("MainVC")
            
            break
        case 1:
            print("Appointment\n", terminator: "")
            
            baseVC.openViewControllerBasedOnIdentifier("AppointmentVC")
            
            break
        case 2:
            print("Examination\n", terminator: "")
            baseVC.openViewControllerBasedOnIdentifier("ExaminationVC")
            break
        case 3:
            print("Logout")
            session.logout()
            baseVC.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        default:
            print("default\n", terminator: "")
        }
    }
    
    private func drawerActionDoctor(index: Int32) {
        let topViewController : UIViewController = baseVC.navigationController!.topViewController!
        print("View Controller is : \(topViewController) \n", terminator: "")
        
        switch(index){
        case 0:
            print("Home\n", terminator: "")
            
            baseVC.openViewControllerBasedOnIdentifier("MainVC")
            
            break
        case 1:
            print("Appointment\n", terminator: "")
            
            baseVC.openViewControllerBasedOnIdentifier("AppointmentVC")
            
            break
        case 2:
            print("Complaint\n", terminator: "")
            baseVC.openViewControllerBasedOnIdentifier("ComplaintVC")
            break
        case 3:
            print("Logout")
            session.logout()
            baseVC.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        default:
            print("default\n", terminator: "")
        }
    }
    
    private func drawerActionNurse(index: Int32) {
        let topViewController : UIViewController = baseVC.navigationController!.topViewController!
        print("View Controller is : \(topViewController) \n", terminator: "")
        
        switch(index){
        case 0:
            print("Home\n", terminator: "")
            
            baseVC.openViewControllerBasedOnIdentifier("MainVC")
            
            break
        case 1:
            print("Pharmacy\n", terminator: "")
            
            baseVC.openViewControllerBasedOnIdentifier("PharmacyVC")
            
            break
        case 2:
            print("Cashier\n", terminator: "")
            baseVC.openViewControllerBasedOnIdentifier("CashierVC")
            break
        case 3:
            print("Logout")
            session.logout()
            baseVC.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        default:
            print("default\n", terminator: "")
        }
    }
    
}
