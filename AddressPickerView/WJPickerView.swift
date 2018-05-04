//
//  WJPickerView.swift
//  AddressPickerView
//
//  Created by WJ on 2018/5/4.
//  Copyright © 2018年 WJ. All rights reserved.
//

import UIKit

class WJPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
 
    // 省
    var provinceArr:NSArray = []
    // 市/区
    var citiesArr:NSArray = []
    // 县
    var areaArr:NSArray = []
    // 省
    var provinceStr = ""
    // 市
    var citiesStr = ""
    // 县
    var areaStr = ""
    // 选中的省 市 县
    var selectArr:NSArray = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpData()
        self.delegate = self
        self.dataSource = self
        
    }

    func setUpData() -> Void {
        // 获取本地数据plist文件
        if let path = Bundle.main.path(forResource: "area", ofType: "plist") {
            if let temProvinceArr = NSArray.init(contentsOfFile: path) {
                for (_, value) in temProvinceArr.enumerated() {
                    let temp = NSMutableArray.init(array: provinceArr)
                    let dict = value as! NSDictionary
                    temp.add(dict.value(forKey: "state") ?? "")
                    provinceArr = temp
                }
                let cityDict = temProvinceArr.firstObject as? NSDictionary
                let cityArr = cityDict?.value(forKey: "cities") as! NSArray
                let tempCitiesArr = NSMutableArray.init(array: cityArr)
                for(_, value) in tempCitiesArr.enumerated() {
                    let temp = NSMutableArray.init(array: citiesArr)
                    let dict = value as! NSDictionary
                    temp.add(dict.value(forKey: "city") ?? "")
                    citiesArr = temp
                }
                
                let areaDict = tempCitiesArr.firstObject as! NSDictionary
                let areaArray = areaDict.value(forKey: "areas") as! NSArray
                areaArr = NSMutableArray.init(array: areaArray)
                
                provinceStr = provinceArr.firstObject as! String
                citiesStr = citiesArr.firstObject as! String
                areaStr = ((areaArr.count == 0) ? "" : areaArr.firstObject as! String)
                
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return provinceArr.count
        } else if component == 1 {
            return citiesArr.count
        }
        return areaArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let path = Bundle.main.path(forResource: "area", ofType: "plist")
        let provinceArray = NSArray.init(contentsOfFile: path!)!
        if component == 0 {
            let tempDict = provinceArray[row] as! NSDictionary
            selectArr = tempDict.value(forKey: "cities") as! NSArray
            let tempArr = NSMutableArray.init(array: citiesArr)
            tempArr.removeAllObjects()
            citiesArr = tempArr
            for (_, value) in selectArr.enumerated() {
                let temp = NSMutableArray.init(array: citiesArr)
                let dict = value as! NSDictionary
                temp.add(dict.value(forKey: "city") ?? "")
                citiesArr = temp
            }
            
            let areaDict = selectArr.firstObject as! NSDictionary
            areaArr = areaDict.value(forKey: "areas") as! NSArray
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
        } else if component == 1 {
            if selectArr.count == 0  {
                selectArr = (provinceArray.firstObject as! NSDictionary).value(forKey: "cities") as! NSArray
            }
            areaArr = NSMutableArray.init(array: (selectArr[row] as! NSDictionary).value(forKey: "areas") as! NSArray)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }
        let provinceNum = pickerView.selectedRow(inComponent: 0)
        let cityNum = pickerView.selectedRow(inComponent: 1)
        let areaNum = pickerView.selectedRow(inComponent: 2)
        provinceStr = provinceArr[provinceNum] as! String
        citiesStr = citiesArr[cityNum] as! String
        if areaArr.count == 0 {
            areaStr = ""
        } else {
            areaStr = areaArr[areaNum] as! String
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let lable = UILabel()
        lable.frame = CGRect(x:0, y:0, width: 100, height:50)
        if  component == 0 {
            lable.text = provinceArr[row] as? String
        } else if component == 1 {
            lable.text = citiesArr[row] as? String
        } else {
            if areaArr.count == 0 {
                lable.text = ""
            } else {
                lable.text = areaArr[row] as? String
            }
        }
        
        lable.textAlignment = .center
        lable.font = UIFont.systemFont(ofSize: 17)
        return lable
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



