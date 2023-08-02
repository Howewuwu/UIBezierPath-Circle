//
//  CircleApplicationViewController.swift
//  UIBezierPath&Circle
//
//  Created by Howe on 2023/7/31.
//

import UIKit

var sliderInstance: Float = -90

/*
 在這裡，sliderInstance 的初始值被設置為 -90，這是因為在繪製圓形時，我們通常會把圓形的開始點（也就是0度）設置在圓形的最頂點。
 這個開始點對應於我們常說的「三點鐘方向」。然而，在繪圖的坐標系中，0度通常是指「三點鐘方向」，而不是「十二點鐘方向」。
 所以，我們將 sliderInstance 初始設置為 -90，是為了讓圓形的開始點從「十二點鐘方向」開始，這樣就能更直觀地對應我們對於圓形度數的一般理解。
 這裡的 -90 度就是在數學上的負90度位置，也就是「十二點鐘方向」。
 這種設定在創建像時鐘、計時器或任何其他需要從「十二點鐘方向」開始的圓形介面的應用程序時都很常見。
 */


let circleLayer = CAShapeLayer()
let circleLayer2 = CAShapeLayer()
let circleLayer3 = CAShapeLayer()

let percentageLabel = UILabel()

class CircleApplicationViewController: UIViewController {

    @IBOutlet weak var sliderOut: UISlider!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        circle()
        upLabel()
        
        
    }
    
    
    func circle(){
        let aDegree: CGFloat = .pi / 180
        let startPoint = CGPoint(x: 190, y: 300)
        let radius: CGFloat = 50
        
        //circle 1
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addArc(withCenter: startPoint, radius: radius, startAngle: aDegree * 0, endAngle: aDegree * 360, clockwise: true)
        path.close()
        
        circleLayer.removeFromSuperlayer()
        /*
         .removeFromSuperlayer()
         這個方法的作用是從它的父層(superlayer)中移除 circleLayer。
         在這個程式碼中，每當滑動條的值改變時，circle() 函數就會被調用，這意味著新的圓形路徑和形狀層會被創建並添加到視圖的層上。
         如果你不先從父層中移除舊的 circleLayer，新的圓形路徑就會被添加到舊的圓形路徑上，可能導致顏色，大小或位置的重疊和混亂。
         因此，每次創建新的圓形路徑前，我們先把舊的 circleLayer 從它的父層中移除，這樣就能保證每次只有新的圓形路徑被添加到視圖的層上。
         另外，這也是一種很好的內存管理策略，因為這樣可以確保任何不再需要的 circleLayer 都會被適時地移除，釋放出它所使用的資源。
         */
        circleLayer.path = path.cgPath
        circleLayer.fillColor = CGColor(red: 144/255, green: 64/255, blue: 173/255, alpha: 1)
        
        
        
        
        //circle2 dynamic
        let path2 = UIBezierPath()
        //path2.move(to: startPoint)
        path2.addArc(withCenter: startPoint, radius: radius+10, startAngle: aDegree * -90, endAngle: aDegree * CGFloat(sliderInstance), clockwise: true)
        //path2.close()
        
        circleLayer2.removeFromSuperlayer()
        circleLayer2.path = path2.cgPath
        circleLayer2.fillColor = UIColor.clear.cgColor
        circleLayer2.lineWidth = 15
        circleLayer2.strokeColor = CGColor(red: 1, green: 0, blue: 1, alpha: 1)
        
        
        //circle3
        let path3 = UIBezierPath()
        path3.addArc(withCenter: startPoint, radius: radius+10, startAngle: aDegree * 0, endAngle: aDegree * 360, clockwise: true)
        
        circleLayer3.removeFromSuperlayer()
        circleLayer3.path = path3.cgPath
        circleLayer3.fillColor = UIColor.clear.cgColor
        circleLayer3.lineWidth = 15
        circleLayer3.strokeColor = UIColor.systemBackground.cgColor
        
        
        view.layer.addSublayer(circleLayer)
        view.layer.addSublayer(circleLayer3)
        view.layer.addSublayer(circleLayer2)
        upLabel()
        
        
        
    }
    
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        sliderInstance = sliderOut.value
        circle()
    }
    
    func upLabel() {
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 20, height: 40)
        percentageLabel.backgroundColor = .clear
        percentageLabel.textColor = .label
        percentageLabel.textAlignment = .center
        percentageLabel.font = .systemFont(ofSize: 8)
        percentageLabel.sizeToFit()
        percentageLabel.center = CGPoint(x: 190, y: 300)
        
        let sliderInstancePercentage = (sliderInstance+90) / 360 * 100
        percentageLabel.text = "\(String(format: "%.0f", sliderInstancePercentage))%"
        view.addSubview(percentageLabel)
    }
    
    
    
}
