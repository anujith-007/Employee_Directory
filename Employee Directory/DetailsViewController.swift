//
//  DetailsViewController.swift
//  Employee Directory
//
//  Created by Anujith on 28/05/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phne: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var companyAddress: UILabel!
    
    var employee = EmployeeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Image.sd_setImage(with: URL(string: employee.profileImage ?? ""), completed: {_,_,_,_ in
        })
        name.text = employee.name
        userName.text = employee.username
        email.text = employee.email
        phne.text = employee.phone
        address.text = "\(employee.address?.suite ?? "") \n \(employee.address?.street ?? "") \n \(employee.address?.city ?? "")"
        companyAddress.text = "\(employee.company?.name ?? "") \n \(employee.company?.catchPhrase ?? "") \n \(employee.company?.bs ?? "")"
    }
    


}
