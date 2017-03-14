//
//  PharmacyViewController.swift
//  onClinic
//
//  Created by MTMAC24 on 3/10/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PharmacyViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var medicines: [Medicine] = []
    var selected_medicine: Medicine = Medicine()
    var searchActive : Bool = false
    
    var filtered: [Medicine] = []
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addSlideMenuButton()
        self.title = "Pharmacy"
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        tableView.tableHeaderView = searchBar
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction))
        
    }
    
    func addButtonAction() {
        self.performSegue(withIdentifier: "pharmacyCreate", sender: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getMedicines()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchActive) {
            return filtered.count
        }
        return medicines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MedicineCell", for: indexPath) as! MedicineTableViewCell
        
        if (searchActive) {
            cell.lblName?.text = filtered[indexPath.row].name
            cell.lblType?.text = filtered[indexPath.row].type
            cell.lblPrice?.text = "Price : \(StringFormatter.formatCurrency(value: filtered[indexPath.row].price!))"
            cell.lblStock?.text = "Stock : \(filtered[indexPath.row].quantity!)"
        } else {
            cell.lblName?.text = medicines[indexPath.row].name
            cell.lblType?.text = medicines[indexPath.row].type
            cell.lblPrice?.text = "Price : \(StringFormatter.formatCurrency(value: medicines[indexPath.row].price!))"
            cell.lblStock?.text = "Stock : \(medicines[indexPath.row].quantity!)"
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected_medicine = medicines[indexPath.row] as Medicine
        
        self.performSegue(withIdentifier: "pharmacyDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        selected_medicine = medicines[indexPath.row] as Medicine

        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            let deleteAlert = UIAlertController(title: "Delete", message: "Are you sure", preferredStyle: UIAlertControllerStyle.alert)
            deleteAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                Alamofire.request(MedicineRouter.delete(self.selected_medicine.id!))
                    .responseJSON { (response) in
                        switch response.result {
                        case .success(let value):
                            let json = JSON(value)
                            if json["status"] == true {
                                self.showAlert(title: "Success", message: "Medicine deleted")
                                self.medicines.remove(at: indexPath.row)
                                self.tableView.reloadData()
                            }
                        case .failure(let error):
                            self.showAlert(title: "Error", message: "Something wrong");
                            print(error)
                        }
                
                }

            }))
            
            deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                print("cancel")
            }))
            
            self.present(deleteAlert, animated: true, completion: nil)
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            self.performSegue(withIdentifier: "pharmacyEdit", sender: nil)
        }
        
        return [deleteAction, editAction]
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    
    func getMedicines() {
        tableView.activityIndicatorView.startAnimating()
        Alamofire.request(MedicineRouter.index())
            .responseJSON { (response) in
                 debugPrint(response)
                self.tableView.activityIndicatorView.stopAnimating()
                if response.result.value == nil {
                    self.showAlert(title: "Error", message: "Something error with the server. Sorry for the inconvenience")
                } else {
                    if let responseJson = response.result.value as? [String: Any] {
                        if responseJson["status"] != nil {
                            let data = responseJson["data"] as! NSArray
                            for medicine in data {
                                let med = medicine as! [String: Any]
                                self.medicines.append(Medicine(json: med))
                            }
                            self.tableView.reloadData()
                        }
                    }
                }
                
                
        }
    }
    
    // MARK: SearchBar protocol
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.setShowsCancelButton(false, animated: true)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = medicines.filter({ (med) -> Bool in
            return med.name!.range(of: searchText, options: NSString.CompareOptions.caseInsensitive) != nil
        })
        
        if (filtered.count == 0) {
            searchActive = false
        } else {
            searchActive = true
        }
        
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pharmacyDetail" {
            if let pharmacyDetailVC = segue.destination as? PharmacyDetailViewController {
                pharmacyDetailVC.medicine = selected_medicine
            }
        }
        
        if segue.identifier == "pharmacyEdit" {
            if let pharmacyEditVC = segue.destination as? PharmacyEditViewController {
                pharmacyEditVC.medicine = selected_medicine
            }
        }
    }
    
    // MARK: View helper function
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }

}
