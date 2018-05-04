//
//  ViewController.swift
//  AddressPickerView
//
//  Created by WJ on 2018/5/4.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pickView = WJPickerView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupPickView()
        setupButton()
    }

    func setupPickView() {
        pickView = WJPickerView.init(frame: CGRect(x:10, y:100, width:self.view.frame.size.width - 20, height:150))
        self.view.addSubview(pickView)
    }
    
    func setupButton()  {
        let button = UIButton.init(type: .custom)
        button .setTitle("done", for: .normal)
        button .setTitleColor(UIColor .black, for: .normal)
        button.frame = CGRect(x:40, y:300, width:self.view.frame.size.width - 80, height:44)
        button.backgroundColor = UIColor.orange
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        
    }
    
    @objc func buttonClick() {
        let address = String.init(format: "%@ -- %@ -- %@", pickView.provinceStr, pickView.citiesStr, pickView.areaStr)
        
        print("\(address)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

