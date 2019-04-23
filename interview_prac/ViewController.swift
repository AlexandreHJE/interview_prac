//
//  ViewController.swift
//  interview_prac
//
//  Created by Alexhu on 2019/4/23.
//  Copyright © 2019 Alexhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    weak var dramaTableVC: DramaTableViewController?
    var selectedRow = 0
    
    @IBOutlet weak var dramaPic: UIImageView!
    @IBOutlet weak var dramaName: UILabel!
    @IBOutlet weak var dramaRating: UILabel!
    @IBOutlet weak var dramaPudDate: UILabel!
    @IBOutlet weak var dramaTotalViews: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        selectedRow = self.dramaTableVC?.currentRow ?? 0
        self.dramaPic.image = UIImage(named: "notFound.png")
        self.dramaName.text = "戲劇名稱：\((self.dramaTableVC?.filteredData[selectedRow].name)!)"
        self.dramaRating.text = "觀眾評分：\(String((self.dramaTableVC?.filteredData[selectedRow].rating)!))"
        let dateStr = ((self.dramaTableVC?.filteredData[selectedRow].created_at)! as NSString).substring(to: 10)
        self.dramaPudDate.text = "播映日期：\(dateStr)"
        self.dramaTotalViews.text = "觀看次數：\(String((self.dramaTableVC?.filteredData[selectedRow].total_views)!))"
    }
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: screenSize.width, height: 60))
        let navItem = UINavigationItem(title: "CCC")
        let backItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dissmissVC))
        navItem.leftBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    @objc func dissmissVC()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}

