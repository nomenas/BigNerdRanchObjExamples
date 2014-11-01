//
//  DatePickerController.m
//  Homepwner
//
//  Created by Naum Puroski on 11/1/14.
//  Copyright (c) 2014 purocomputers. All rights reserved.
//

#import "DatePickerController.h"

@interface DatePickerController ()
@property (weak, nonatomic) IBOutlet UIDatePicker* datePicker;
@end

@implementation DatePickerController

- (id) initWithDate: (NSDate*) date
{
    self = [super init];
    
    if (self)
    {
        self.datePicker.date = date;
        self.navigationItem.title = @"Date Picker";
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDate*) selectedDate
{
    return self.datePicker.date;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
