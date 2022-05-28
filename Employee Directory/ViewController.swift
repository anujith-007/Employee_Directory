//
//  ViewController.swift
//  Employee Directory
//
//  Created by Anujith on 28/05/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    let utility = Utilities()
    var employeeArray : [EmployeeModel]?
    var filteredData : [EmployeeModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let array = DatabaseHandler().getEmployeeData()
        filteredData = array
        employeeArray = array
        print("sdfsfd")
        fetchEmployeeAPI()
    }
    
    //MARK:- UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.filteredData?.removeAll()
            self.filteredData = employeeArray
            self.tableView.reloadData()
        } else {
            filteredData = employeeArray!.filter { (item) in
                ((item.name?.lowercased().contains(searchText.lowercased()) ?? false) || (item.email?.lowercased().contains(searchText.lowercased()) ?? false))
            }
            self.tableView.reloadData()
        }
    }
    
    //MARK:- Button Click
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    //MARK:- TableView Delegte
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeListTableViewCell
        if let item = filteredData?[indexPath.row] {
            cell.profileImageView.sd_setImage(with: URL(string: item.profileImage ?? ""), completed: {_,_,_,_ in
            })
            cell.nameLabel.text = item.name
            cell.companyNameLabel.text = item.company?.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = filteredData?[indexPath.row] {
            if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
                vc.employee = item
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
       
    }
    

    //API
    func fetchEmployeeAPI() {
        let reachability = NetworkReachabilityManager()
        if reachability?.isReachable == true {
            
            DataGenerator.fetchEmployeeListApi() { (success , response, Authsuccess) in

                if !Authsuccess{
                    self.utility.ToastWith(message: "We are working on it. Please try after sometime.", view: self.view, viewDuration: 2, viewLenght: 150, viewHeight: 60.0, color: .black)
                }else if success {
                    let json = JSON(response)
                    if json != JSON.null {
                        let jsonString = "\(json)"
                        print("json string\(jsonString)")
                        let jsonData = jsonString.data(using: .utf8)!
                        let employeeModel = try? JSONDecoder().decode([EmployeeModel].self, from: jsonData)
                        if let modelArray = employeeModel {
                            for employeeItem in modelArray {
                                DatabaseHandler().saveEmployeeData(data: employeeItem)
                            }
                            
                            let array = DatabaseHandler().getEmployeeData()
                            self.employeeArray = array
                            self.filteredData = array
                            
                            self.tableView.reloadData()
                        }
                        
                    }
                } else{
                    self.utility.ToastWith(message: "Something went wrong!!", view: self.view, viewDuration: 2, viewLenght: 150, viewHeight: 60.0, color: .black)
                }
            }
        }
    }
    
}

class EmployeeListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

