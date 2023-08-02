//
//  ViewController.swift
//  UIBezierPath&Circle
//
//  Created by Howe on 2023/7/28.
//

import UIKit





class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        circle1()
        circle2()
        circle3()
    }
    
    
    func circle1(){
        let aDegree = Double.pi / 180 // 將數學角度轉換為弧度
        let lineWidth: Double = 10 // 定義線寬
        let radius: Double = 50 // 定義半徑
        let startDegree: Double = 270 // 起始角度
        
        // 創建一個表示圓形的 UIBezierPath
        let circlePath = UIBezierPath(ovalIn: CGRect(x: lineWidth, y: lineWidth, width: radius*2, height: radius*2))
        
        
        // 創建一個用於繪製圓形的 CAShapeLayer
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath // 設定形狀為先前定義的圓形
        circleLayer.strokeColor = UIColor(red: 199/255, green: 38/255, blue: 83/255, alpha: 0.5).cgColor
        circleLayer.lineWidth = lineWidth // 設定線條寬度
        circleLayer.fillColor = UIColor.clear.cgColor // 設定圓形內部顏色為透明
        
        let percentage: CGFloat = 80 // 要顯示的百分比
        let endDegree = startDegree + 360 * percentage / 100 // 根據百分比計算結束角度
        
        // 創建一個表示百分比的 UIBezierPath
        let percentagePath = UIBezierPath(arcCenter: CGPoint(x: lineWidth + radius, y: lineWidth + radius), radius: radius, startAngle: aDegree * startDegree, endAngle: aDegree * endDegree, clockwise: true)
        
        // 創建一個用於繪製百分比的 CAShapeLayer
        let percentageLayer = CAShapeLayer()
        percentageLayer.path = percentagePath.cgPath // 設定形狀為先前定義的百分比
        percentageLayer.strokeColor = UIColor(red: 199/255, green: 38/255, blue: 83/255, alpha: 1).cgColor // 設定線條顏色
        percentageLayer.lineWidth = lineWidth // 設定線條寬度
        percentageLayer.fillColor = UIColor.clear.cgColor // 設定內部顏色為透明
        percentageLayer.lineCap = .round // 設定線條的端點樣式為圓形
        
        let viewWidth = 2*(radius + lineWidth) // 計算視圖的寬度
        
        // 創建一個 UIView 來包含兩個 CAShapeLayer
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth))
        customView.layer.addSublayer(circleLayer) // 添加圓形層
        customView.layer.addSublayer(percentageLayer) // 添加百分比層
        
        // 創建一個 UILabel 來顯示百分比
        let label = UILabel(frame: customView.bounds)
        label.text = "\(percentage)%" // 設定標籤的文字為百分比
        label.textAlignment = .center // 設定文字對齊方式為居中
        customView.addSubview(label) // 將標籤添加到自定義視圖
        
        // 將自定義視圖添加到父視圖
        self.view.addSubview(customView)
        
        // 設定自定義視圖的位置，使其位於父視圖的中心的 1/6 處
        customView.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 6)
    }
    
    func circle2() {
        // 設定一個角度為圓周的 1/180，即一度所對應的弧度
        let aDegree = Double.pi / 180
        // 設定線寬為 25
        let lineWidth: Double = 25
        // 設定半徑為 50
        let radius: Double = 50
        // 設定起始角度為 270 度，這表示從圓的上方開始（0 度和 360 度位於圓的右側，90 度位於圓的下方，180 度位於圓的左側）
        var startDegree: Double = 270
        // 設定視圖寬度為兩倍的（半徑加上線寬）
        let viewWidth = 2*(radius + lineWidth)
        // 創建一個自定義的 UIView，大小由上述的 viewWidth 定義
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth))
        // 設定圓心為線寬加上半徑
        let center = CGPoint(x: lineWidth + radius, y: lineWidth + radius)
        // 定義一個陣列 percentages，裡面包含了每個段落的比例（百分比）
        let percentages: [Double] = [30, 30, 40]
        // 進行一個迴圈，每次迴圈根據 percentages 中的百分比來創建一個圓弧路徑
        for percentage in percentages {
        // 計算出結束的角度，起始角度加上該段落應有的角度
        let endDegree = startDegree + 360 * percentage / 100
        // 創建一個 UIBezierPath，這個路徑是一個從 startDegree 到 endDegree 的圓弧
        let percentagePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: aDegree * startDegree, endAngle: aDegree * endDegree, clockwise: true)
        // 創建一個 CAShapeLayer，將路徑設定為剛才創建的 percentagePath
        let percentageLayer = CAShapeLayer()
        percentageLayer.path = percentagePath.cgPath
        // 設定該 layer 的描繪顏色為隨機顏色
        percentageLayer.strokeColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1).cgColor
        // 設定該 layer 的線寬
        percentageLayer.lineWidth = lineWidth
        // 設定該 layer 的填充顏色為透明
        percentageLayer.fillColor = UIColor.clear.cgColor
        // 將該 layer 加到 customView 的 layer 上
        customView.layer.addSublayer(percentageLayer)
        // 將 startDegree 設定為 endDegree，讓下一個圓弧從這裡開始
        startDegree = endDegree
        }
        // 設定 customView 的背景色為藍色
        customView.backgroundColor = .blue
        // 將 customView 加到當前的 view 上
        self.view.addSubview(customView)
        // 將 customView 的中心點設定為當前 view 寬度的一半、高度的 2.5 分之一，即將 customView 放在上半部的中心位置
        customView.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2.5)

    }
    
    func circle3() {
        // 定義一度所對應的弧度值
        let aDegree = Double.pi / 180
        // 定義線寬為 25
        let lineWidth: Double = 25
        // 定義圓弧的半徑為 50
        let radius: Double = 50
        // 起始角度定義為 270度，這表示從圓的上方開始
        var startDegree: Double = 270
        // 視圖的寬度定義為兩倍的（半徑加線寬）
        let viewWidth = 2 * (radius + lineWidth)
        // 創建一個自定義的 UIView，大小由上述的 viewWidth 定義
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth))
        // 定義圓心點，其位置為半徑與線寬的和
        let center = CGPoint(x: radius + lineWidth, y: radius + lineWidth)
        // 定義一個陣列 percentages，裡面包含了每個圓弧的比例
        let percentages: [Double] = [30, 30, 40]
        
        // 定義一個函數來創建標籤，標籤顯示的是圓弧的比例，並位於每個圓弧的中心點
        func circle3CreateLabel(percentage: Double, startDegree: Double) -> UILabel {
            // 計算出標籤的中心點應在的角度，即起始角度加上該圓弧角度的一半
            let textCenterDegree = startDegree + 360 * percentage / 2 / 100
            // 用 UIBezierPath 創建一個路徑，該路徑是一個以圓心為中心，textCenterDegree 為角度，半徑為 radius 的點
            // 起始和結束點如果這兩個角度相同，就等於在畫一個點，而不是一條弧線，在這裡textPath並不是真正被用來創建顯示的弧線。它被用來計算出一個點的位置，這個點是標籤中心點應該在的位置。
            // textPath.currentPoint之後就能給我們這個點的座標，我們可以直接用這個座標來設置標籤的中心點。
            // 所以即使startAngle和endAngle相同，我們仍然能得到我們需要的結果：一個圓周上某個特定角度的點的座標。
            // label 在圓上的位置由 radius 這個參數決定。
            let textPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: aDegree * textCenterDegree, endAngle: aDegree * textCenterDegree, clockwise: true)
            // 創建一個標籤，並將其大小定義為 50x30
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
            // 設定標籤的背景為透明
            label.backgroundColor = .clear
            // 設定標籤的字體為系統字體，大小為 8
            label.font = .systemFont(ofSize: 8)
            // 設定標籤的文字為百分比
            label.text = "\(percentage)%"
            // 將標籤的大小調整為包裹其內容
            label.sizeToFit()
            // 將標籤的中心點設定為 textPath 的當前點，這樣標籤就會出現在每個圓弧的中心點
            label.center = textPath.currentPoint
            
            /*
            textCenterDegree 是文字所在位置的角度，計算方法是將起始角度 startDegree 加上 360 * percentage / 2 / 100。
            這個角度表示文字在甜甜圈圖表上的中心位置。

            270 是圓環起始位置的角度。這是由於原始的程式碼中，圓環起始位置被設定為 270 度。
            將這個角度用作參考點，以便計算標籤的旋轉角度。

            labelDegree 是標籤的旋轉角度，計算方法是將 textCenterDegree 減去 270。
            這樣做可以將標籤的角度轉換為相對於起始角度的偏移量。*/
            let labelDegree = textCenterDegree - 270
            label.transform = CGAffineTransform(rotationAngle: .pi / 180 * labelDegree)
            
            /*
            將標籤應用相應的旋轉角度。.pi / 180 是將角度轉換為弧度的因子，然後乘以 labelDegree 得到最終的旋轉角度。

            通過這段程式碼，我們可以根據文字所在的角度將標籤旋轉到相應的位置，使其與甜甜圈圖表的區域對齊。
            這樣可以確保標籤與圖表的對應部分保持一致並呈現正確的角度。*/
            
            
            // 返回標籤
            return label
        }
        
        // 進行一個迴圈，每次迴圈根據 percentages 中的百分比來創建一個圓弧
        for percentage in percentages {
            // 計算出結束的角度，起始角度加上該段落應有的角度
            let endDegree = startDegree + 360 * percentage / 100
            // 創建一個 UIBezierPath，這個路徑是一個從 startDegree 到 endDegree 的圓弧
            let percentagePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: aDegree * startDegree, endAngle: aDegree * endDegree, clockwise: true)
            // 創建一個 CAShapeLayer，將路徑設定為剛才創建的 percentagePath
            let percentageLayer = CAShapeLayer()
            percentageLayer.path = percentagePath.cgPath
            // 設定該 layer 的描繪顏色為隨機顏色
            percentageLayer.strokeColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1).cgColor
            // 設定該 layer 的線寬
            percentageLayer.lineWidth = lineWidth
            // 設定該 layer 的填充顏色為透明
            percentageLayer.fillColor = UIColor.clear.cgColor
            // 將該 layer 加到 customView 的 layer 上
            customView.layer.addSublayer(percentageLayer)
            // 使用 circle3CreateLabel 函數創建一個標籤，並添加到 customView 上
            let label = circle3CreateLabel(percentage: percentage, startDegree: startDegree)
            customView.addSubview(label)
            // 將 startDegree 設定為 endDegree，讓下一個圓弧從這裡開始
            startDegree = endDegree
            }
            // 設定 customView 的背景色為淺灰色
            customView.backgroundColor = UIColor.lightGray
            // 將 customView 加到當前的 view 上
            self.view.addSubview(customView)
            // 將 customView 的中心點設定為當前 view 寬度的一半、高度的 3/2，即將 customView 放在下半部的中心位置
            customView.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 1.5)
        
    }
        
}
    


