//
//  SCDetailViewController.swift
//  StepCounter
//
//

import UIKit
import CoreMotion

class SCDetailViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    static let calendar = NSCalendar.current
    static let activityManager = CMMotionActivityManager()
    static let pedoMeter = CMPedometer()
    var selectedDay = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.separatorStyle = .none
        self.navigationItem.title = selectedDay == 0
            ? "Today"
            : (SCUtility.getFormattedDate(date: Date.init(timeInterval: TimeInterval(-86400 * selectedDay), since: Date())))
        self.navigationItem.backBarButtonItem?.title = ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SCDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailTablleViewCell", for: indexPath) as! SCDetailTableViewCell
        let day = selectedDay
        let fromDate = Date.init(timeInterval: TimeInterval(-86400 * day), since: Date())
        let fromDateMidnight = SCUtility.getMidnightDateTime(date: fromDate)
        let toDate = Date.init(timeInterval: 86400, since: fromDate)
        let toDateMidnight = SCUtility.getMidnightDateTime(date: toDate)
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Walking + Running Distance"
            cell.unitLabel.text = "mi"
            if (CMPedometer.isDistanceAvailable()) {
                SCDetailViewController.pedoMeter.queryPedometerData(from: fromDateMidnight, to: toDateMidnight) { (data : CMPedometerData!, error) -> Void in
                    DispatchQueue.main.async(execute: { () -> Void in
                        if(error == nil){
                            let distance = Double(data.distance!) / 1609.344
                            cell.valueLabel.text = String(format: "%.2f",distance)
                        }
                    })
                    
                }
                
            }
            break
        case 1:
            cell.titleLabel.text = "Steps"
            cell.unitLabel.text = "steps"
            if(CMPedometer.isStepCountingAvailable()){
                SCHomeViewController.pedoMeter.queryPedometerData(from: fromDateMidnight, to: toDateMidnight) { (data : CMPedometerData!, error) -> Void in
                    DispatchQueue.main.async(execute: { () -> Void in
                            if(error == nil){
                                cell.valueLabel.text = String(describing: data.numberOfSteps)
                            }
                        })
                    
                    }
            }
            break
        case 2:
            cell.titleLabel.text = "Floors Ascended"
            if(CMPedometer.isFloorCountingAvailable()){
                SCHomeViewController.pedoMeter.queryPedometerData(from: fromDateMidnight, to: toDateMidnight) { (data : CMPedometerData!, error) -> Void in
                    DispatchQueue.main.async(execute: { () -> Void in
                        if(error == nil){
                            cell.valueLabel.text = String(describing: data.floorsAscended!)
                            cell.unitLabel.text = Int(data.floorsAscended!) > 1 ? "floors" : "floor"
                        }
                    })
                    
                }
            }

        default:
            break
        }
        return cell
    }
}
