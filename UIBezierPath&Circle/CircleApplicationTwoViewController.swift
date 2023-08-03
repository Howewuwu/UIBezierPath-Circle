//
//  CircleApplicationTwoViewController.swift
//  UIBezierPath&Circle
//
//  Created by Howe on 2023/8/1.
//

import UIKit

class CircleApplicationTwoViewController: UIViewController {
    
    
    @IBOutlet weak var deviceTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var mealsTextField: UITextField!
    @IBOutlet weak var photographyTextField: UITextField!
    @IBOutlet weak var lightingTextField: UITextField!
    @IBOutlet weak var audioTextField: UITextField!
    
    @IBOutlet weak var totalCost: UILabel!
    
    var devicePercentage = 0.0
    var placePercentage = 0.0
    var mealsPercentage = 0.0
    var photographyPercentage = 0.0
    var lightingPercentage = 0.0
    var audioPercentage = 0.0
    
    let aDegree: Double = .pi / 180
    let radius: Double = 80
    
    var startDegree: Double = 270
    var customview = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    @IBAction func calculate(_ sender: UIButton) {
        let radiuses = [radius, radius+10, radius+20, radius+30, radius+40, radius+50]
        let colors: [UIColor] = [.cyan, .brown, .magenta, .orange, .purple, .label]
        
        
        let deviceNum = Double(deviceTextField.text!)
        let placeNum = Double(placeTextField.text!)
        let mealsNum = Double(mealsTextField.text!)
        let photographyNum = Double(photographyTextField.text!)
        let lightingNum = Double(lightingTextField.text!)
        let audioNum = Double(audioTextField.text!)
        
        if deviceNum != nil, placeNum != nil, mealsNum != nil, photographyNum != nil, lightingNum != nil, audioNum != nil {
            let totalSpend = deviceNum! + placeNum! + mealsNum! + photographyNum! + lightingNum! + audioNum!
            
            devicePercentage = deviceNum! / totalSpend * 100
            placePercentage = placeNum! / totalSpend * 100
            mealsPercentage = mealsNum! / totalSpend * 100
            photographyPercentage = photographyNum! / totalSpend * 100
            lightingPercentage = lightingNum! / totalSpend * 100
            audioPercentage = audioNum! / totalSpend * 100
            
            totalCost.text = "總支出\(String(format: "%.f", totalSpend))"
            
        }
        
        customview.removeFromSuperview()
        customview = UIView(frame: CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2))
        let percentages: [Double] = [devicePercentage, placePercentage, mealsPercentage, photographyPercentage, lightingPercentage, audioPercentage]
        var arrayIndex = -1
        var radiusIndex = -1
        var colorIndex = -1
        var colorTextIndex = -1
        
        func labelCreate(percentage: Double, startDegree: Double) -> UILabel {
            let textCenterDegree = startDegree + (percentage * 360) / 100 / 2
            let textPath = UIBezierPath()
            radiusIndex += 1
            textPath.addArc(withCenter: customview.center, radius: radiuses[radiusIndex] , startAngle: aDegree * textCenterDegree, endAngle: aDegree * textCenterDegree, clockwise: true)
            let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                    
            let labelArrays = ["器材", "場地", "餐費", "攝影", "燈光", "收音"]
            arrayIndex += 1
                    
            label.text = "\(String(format: "%.f", percentage))%"+"\(labelArrays[arrayIndex])"
            colorTextIndex += 1
            label.textColor = colors[colorTextIndex]
            label.backgroundColor = .black
            label.font = .systemFont(ofSize: 8)
            label.sizeToFit()
            label.center = textPath.currentPoint
                    
            let labelDegree = textCenterDegree - 270
            label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 180 * labelDegree)
                    
            return label
            
        }
        
        for percentage in percentages {
            let endDegree = startDegree + 360 * percentage / 100
            let percentagePath = UIBezierPath()
            percentagePath.move(to: customview.center)
            percentagePath.addArc(withCenter: customview.center, radius: radius - 10, startAngle: aDegree * startDegree, endAngle: aDegree * endDegree, clockwise: true)
                    
            let percentageLayer = CAShapeLayer()
            percentageLayer.path = percentagePath.cgPath
            colorIndex += 1
            percentageLayer.fillColor = colors[colorIndex].cgColor
            let label = labelCreate(percentage: percentage, startDegree: startDegree)
            customview.layer.addSublayer(percentageLayer)
            customview.addSubview(label)
            startDegree = endDegree
            
        }
        self.view.addSubview(customview)
        customview.center = CGPoint(x: 150, y: 400)
        
    }
    
}
    
