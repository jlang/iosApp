//
//  CalendarViewController.swift
//  counterApp
//
//  Created by Julie Langmann on 11/28/17.
//  Copyright © 2017 Julie Langmann. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {

    let formatter = DateFormatter()
    
    @IBOutlet var calendarView: JTAppleCalendarView!
    @IBOutlet var year: UILabel!
    @IBOutlet var month: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendarView.scrollToDate(Date(), animateScroll: false)
        calendarView.selectDates([Date()])
        // Do any additional setup after loading the view.
        setupCalendarView()
    }
    
    func setupCalendarView() {
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        // setup labels
        calendarView.visibleDates {
            visibleDates in self.setupViews(from: visibleDates)
        }
    }
    
    func setupViews(from visibleDates:DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        formatter.dateFormat = "yyyy"
        year.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        month.text = formatter.string(from: date)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension CalendarViewController: JTAppleCalendarViewDataSource {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {

    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        //formatter.timeZone = calendar.currentSection().timeZone
        //formatter.locale = calendar.current.locale
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .year, value: 100, to: Date())
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate!)
        return parameters
    }
}

func setCellSelected(cell: CustomCell, cellState: CellState)
{
    if cellState.isSelected {
        cell.selectedView.isHidden = false
        cell.dateLabel.textColor = UIColor(white: 1.0, alpha: 1.0)
    }
    else {
        cell.selectedView.isHidden = true
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = UIColor(white: 0.0, alpha: 1.0)
        }
        else {
            cell.dateLabel.textColor = UIColor(white: 0.5, alpha: 1.0)
            
        }
    }
}

extension CalendarViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.dateLabel.text = cellState.text
        
        setCellSelected(cell: cell, cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCell else {return}
        
        setCellSelected(cell: validCell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCell else {return}
        
        setCellSelected(cell: validCell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViews(from: visibleDates)
        
    }
}







