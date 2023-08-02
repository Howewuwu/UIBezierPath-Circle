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
    let radius: Double = 150
    var startDegree: Double = 270
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    

    
    
    func circle1 () {
        
        let customview = UIView(frame: CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2))
        var percentages: [Double] = [devicePercentage, placePercentage, mealsPercentage, photographyPercentage, lightingPercentage, audioPercentage]
        var arrayIndex = -1
        
        func labelCreate(percentage: Double, startDegree: Double) -> UILabel {
            let textCenterDegree = startDegree + (percentage * 360) / 100 / 2
            let textPath = UIBezierPath()
            textPath.addArc(withCenter: customview.center, radius: radius / 2, startAngle: aDegree * textCenterDegree, endAngle: aDegree * textCenterDegree, clockwise: true)
            let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            
            let labelArrays = ["器材", "場地", "餐費", "攝影", "燈光", "收音"]
            arrayIndex += 1
            
            label.text = "\(String(format: "%.f", percentage))%"+"\(labelArrays[arrayIndex])"
            
            label.textColor = .white
            label.backgroundColor = .black
            label.font = .systemFont(ofSize: 8)
            label.sizeToFit()
            label.center = textPath.currentPoint
            
            //let labelDegree = textCenterDegree - 270
            //label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 180 * labelDegree)
            
            return label
        }
        
        
        for percentage in percentages {
            let endDegree = startDegree + 360 * percentage / 100
            
            let percentagePath = UIBezierPath()
            percentagePath.move(to: customview.center)
            percentagePath.addArc(withCenter: customview.center, radius: radius, startAngle: aDegree * startDegree, endAngle: aDegree * endDegree, clockwise: true)
            let percentageLayer = CAShapeLayer()
            percentageLayer.path = percentagePath.cgPath
            percentageLayer.fillColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1).cgColor
            let label = labelCreate(percentage: percentage, startDegree: startDegree)
            customview.layer.addSublayer(percentageLayer)
            customview.addSubview(label)
            startDegree = endDegree
        }
        self.view.addSubview(customview)
        customview.center = CGPoint(x: 150, y: 400)
    }
    
    
    
    
    @IBAction func calculate(_ sender: UIButton) {
        
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
            
            view.endEditing(true)
            circle1()
        }

        
            
    }
    
    
    
    
    
    

}
