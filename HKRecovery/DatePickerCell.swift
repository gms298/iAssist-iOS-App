/*
 Copyright 2015 Manoj
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import UIKit

public class DatePickerCell: UITableViewCell {

    
    
    public enum DateCellInputMode
    {
        case Date, Time
        
    }
    
    public var inputMode:DateCellInputMode = .Date  {
        
        didSet {
            switch inputMode {
            case .Date:
                datePicker.datePickerMode = .Date
            case .Time:
                datePicker.datePickerMode = .Time
                break
            }
        }
    }
    
    
    var date:NSDate {
        
        get { return datePicker.date }
        
        set (newDate) {
            datePicker.date = newDate
            updateDateTimeLabel()
        }
        
    }
        
    lazy var dateFormatter:NSDateFormatter = {
        
        let formatter = NSDateFormatter()
        formatter.timeStyle = .NoStyle
        formatter.dateStyle = .MediumStyle
        return formatter;
        
    }()

    lazy var timeFormatter:NSDateFormatter = {
        
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        formatter.dateStyle = .NoStyle
        return formatter;
        }()
    
    lazy var datePicker:UIDatePicker = {
        
        let picker = UIDatePicker()
        picker.addTarget(self, action: Selector("datePickerValueChanged"), forControlEvents: UIControlEvents.ValueChanged)
        return picker
    }()
    
    func updateDateTimeLabel() {
        
        var dateText = ""
        var date = datePicker.date
        switch inputMode {
        case .Date:
            dateText = dateFormatter.stringFromDate(date)
        case .Time:
            dateText = timeFormatter.stringFromDate(date)
            break
        }
        self.detailTextLabel?.text = dateText;

    }
    
    func datePickerValueChanged( ) {
        
        updateDateTimeLabel()
    }

    
    public override func canBecomeFirstResponder() -> Bool {
        return true;
    }
    
    public override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if( selected ) {
            self.becomeFirstResponder()
        }
        
    }
    public override var inputView: UIView! {
        get {
            return datePicker
        }
    }
    
    
    
    
    
}
