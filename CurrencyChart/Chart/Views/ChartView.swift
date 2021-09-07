//
//  ChartView.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 06.09.2021.
//

import UIKit
import Charts
import SnapKit

class ChartView: UIView {
        
    private(set) lazy var lineChart: LineChartView = {
        let lineChart = LineChartView()
        lineChart.backgroundColor = .black
                        
        lineChart.rightAxis.enabled = false
        
        let yAxis = lineChart.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.labelPosition = .outsideChart
        yAxis.axisLineColor = .white
        
        lineChart.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        lineChart.xAxis.setLabelCount(6, force: false)
        lineChart.xAxis.labelTextColor = .white
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.axisLineColor = .white
                
        return lineChart
    }()
    
    private(set) lazy var passMessageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get last price", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.backgroundColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        setLineChart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func addSubviews() {
        addSubview(passMessageButton)
        addSubview(lineChart)
    }
    
    private func makeConstraints() {
        passMessageButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(60)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide).offset(100)
        }
        
        lineChart.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide)
            make.height.equalToSuperview().dividedBy(2)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-100)
            make.centerX.equalTo(passMessageButton.snp.centerX)
        }
    }
    
    private func setLineChart() {
        let set = LineChartDataSet()
        set.setCircleColor(.red)
//        set.drawCirclesEnabled = false
        set.mode = .cubicBezier
        set.lineWidth = 1
        set.setColor(.systemGreen)
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.highlightColor = .systemRed
        
        let data = LineChartData(dataSet: set)
        data.setValueTextColor(.white)
        lineChart.data = data
    }
    
    func update(entry: ChartDataEntry) {
        lineChart.data?.addEntry(entry, dataSetIndex: 0)
        lineChart.data?.notifyDataChanged()
        lineChart.notifyDataSetChanged()
    }
}
