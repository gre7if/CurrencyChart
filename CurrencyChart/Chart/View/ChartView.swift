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
        addSubview(lineChart)
    }
    
    private func makeConstraints() {
        lineChart.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
    }
    
    private func setLineChart() {
        let set = LineChartDataSet()
        set.setCircleColor(.red)
        set.mode = .cubicBezier
        set.lineWidth = 1
        set.setColor(.systemGreen)
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.highlightColor = .systemRed
        
        let data = LineChartData(dataSet: set)
        data.setValueTextColor(.white)
        lineChart.data = data
    }
    
    func update(viewModel: ChartViewModel) {
        let entry = ChartDataEntry(x: viewModel.x, y: viewModel.y)
        lineChart.data?.addEntry(entry, dataSetIndex: 0)
        lineChart.data?.notifyDataChanged()
        lineChart.notifyDataSetChanged()
    }
}
