//
//  DatePickerController.h
//  Homepwner
//
//  Created by Naum Puroski on 11/1/14.
//  Copyright (c) 2014 purocomputers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerController : UIViewController

- (id) initWithDate: (NSDate*) date;
- (NSDate*) selectedDate;

@end
