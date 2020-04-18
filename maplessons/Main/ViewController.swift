//
//  ViewController.swift
//  maplessons
//
//  Created by iMac on 01/12/2019.
//  Copyright © 2019 protodimbo. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {
    
    @IBOutlet weak var fromTextField: UITextField!    //поднять экран когда вфыезжает клавиатура
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // clear navbar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        UITabBar.appearance().barTintColor = UIColor.clear
        UITabBar.appearance().backgroundImage = UIImage()
        
        //textfield did pressed
        fromTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChangeStartLocation)))
    }
    
    @objc fileprivate func handleChangeStartLocation() {
        let vc = LocationSearchController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func calculateRoute(_ sender: Any) {
    }
    
}

