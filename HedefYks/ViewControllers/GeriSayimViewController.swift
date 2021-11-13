//
//  GeriSayimViewController.swift
//  HedefYks
//
//  Created by K. Sergen ÖZEL on 30.03.2021.
//

import UIKit
import Foundation

class GeriSayimViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var hourLabel: UILabel!
    
    @IBOutlet weak var minuteLabel: UILabel!
    
    @IBOutlet weak var segmentedControlStatus: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        progressView.setProgress(0, animated: true)
        getTime1()

    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            getTime1()
            break
        case 1:
            getTime2()
            break
        case 2:
            getTime3()
            break
        default:
            break
        }
    }
    
    func getTime1() {
        
        // here we set the current date

            let date = NSDate()
            let calendar = Calendar.current

            let components = calendar.dateComponents([.hour, .minute, .month, .year, .day], from: date as Date)

            let currentDate = calendar.date(from: components)

            let userCalendar = Calendar.current

            // here we set the due date. When the timer is supposed to finish
            let competitionDate = NSDateComponents()
            competitionDate.year = 2021
            competitionDate.month = 6
            competitionDate.day = 26
            competitionDate.hour = 10
            competitionDate.minute = 15
            let competitionDay = userCalendar.date(from: competitionDate as DateComponents)!

            //here we change the seconds to hours,minutes and days
            let CompetitionDayDifference = calendar.dateComponents([.day, .hour, .minute], from: currentDate!, to: competitionDay)

            //finally, here we set the variable to our remaining time
            let daysLeft = CompetitionDayDifference.day
            let hoursLeft = CompetitionDayDifference.hour
            let minutesLeft = CompetitionDayDifference.minute
        
        let days = Float(CompetitionDayDifference.day!)
        
        let value : Float = Float(1-Float(days/365))
        
        print(value)
            
            dayLabel.text = String(daysLeft!)
            hourLabel.text = String(hoursLeft!)
            minuteLabel.text = String(minutesLeft!)

        progressView.setProgress(value, animated: true)
            
    }
    
    func getTime2() {
        
        // here we set the current date

            let date = NSDate()
            let calendar = Calendar.current

            let components = calendar.dateComponents([.hour, .minute, .month, .year, .day], from: date as Date)

            let currentDate = calendar.date(from: components)

            let userCalendar = Calendar.current

            // here we set the due date. When the timer is supposed to finish
            let competitionDate = NSDateComponents()
            competitionDate.year = 2022
            competitionDate.month = 6
            competitionDate.day = 26
            competitionDate.hour = 10
            competitionDate.minute = 15
            let competitionDay = userCalendar.date(from: competitionDate as DateComponents)!

            //here we change the seconds to hours,minutes and days
            let CompetitionDayDifference = calendar.dateComponents([.day, .hour, .minute], from: currentDate!, to: competitionDay)

            //finally, here we set the variable to our remaining time
            let daysLeft = CompetitionDayDifference.day
            let hoursLeft = CompetitionDayDifference.hour
            let minutesLeft = CompetitionDayDifference.minute
            
        let days = Float(CompetitionDayDifference.day!)
        
        let value : Float = Float(1-Float(days/365))
        
        print(value)
        
        dayLabel.text = String(daysLeft!)
        hourLabel.text = String(hoursLeft!)
        minuteLabel.text = String(minutesLeft!)
        
        progressView.setProgress(value, animated: true)
    }
    
    func getTime3() {
        
        // here we set the current date

            let date = NSDate()
            let calendar = Calendar.current

            let components = calendar.dateComponents([.hour, .minute, .month, .year, .day], from: date as Date)

            let currentDate = calendar.date(from: components)

            let userCalendar = Calendar.current

            // here we set the due date. When the timer is supposed to finish
            let competitionDate = NSDateComponents()
            competitionDate.year = 2023
            competitionDate.month = 6
            competitionDate.day = 26
            competitionDate.hour = 10
            competitionDate.minute = 15
            let competitionDay = userCalendar.date(from: competitionDate as DateComponents)!

            //here we change the seconds to hours,minutes and days
            let CompetitionDayDifference = calendar.dateComponents([.day, .hour, .minute], from: currentDate!, to: competitionDay)

            //finally, here we set the variable to our remaining time
            let daysLeft = CompetitionDayDifference.day
            let hoursLeft = CompetitionDayDifference.hour
            let minutesLeft = CompetitionDayDifference.minute
        
        let days = Float(CompetitionDayDifference.day!)
        
        let value : Float = Float(1-Float(days/365))
        
        print(value)
            
        dayLabel.text = String(daysLeft!)
        hourLabel.text = String(hoursLeft!)
        minuteLabel.text = String(minutesLeft!)
            
        progressView.setProgress(value, animated: true)
    }
    
}
