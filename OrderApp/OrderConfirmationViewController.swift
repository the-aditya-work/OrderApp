//
//  OrderConfirmationViewController.swift
//  OrderApp
//
//  Created by Aditya Rai on 15/06/25.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    let minutesToPrepare: Int
    init?(coder: NSCoder , minutesToPrepare: Int){
        self.minutesToPrepare = minutesToPrepare
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBOutlet weak var confirmationlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmationlabel.text = "Thank you for Your order! Your wait time is approximately \(minutesToPrepare) minutes"

        // Do any additional setup after loading the view.
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
