//
//  MenuItemDetailViewViewController.swift
//  OrderApp
//
//  Created by Aditya Rai on 11/06/25.
//

import UIKit

@MainActor
class MenuItemDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pricelabel: UILabel!
    
    @IBOutlet weak var detailTextLabel: UILabel!
    
    @IBOutlet weak var AddToOrderButton: UIButton!
    
    let menultem: MenuItem
    
    init? (coder: NSCoder, menuItem: MenuItem) {
        self.menultem = menuItem
        super.init (coder: coder)
    }
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    

   func updateUI() {
        nameLabel.text = menultem.name
       pricelabel.text = menultem.price.formatted(.currency(code: "USD"))
        detailTextLabel.text = menultem.detailText
    }
    
    
    @IBAction func orderbuttonTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            self.AddToOrderButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.AddToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0) }, completion: nil)
        MenuController.shared.order.menuItems.append(menultem)
    
    }
    
    
}
