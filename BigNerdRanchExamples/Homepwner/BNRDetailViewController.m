//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Naum Puroski on 10/30/14.
//  Copyright (c) 2014 purocomputers. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "DatePickerController.h"

@interface BNRDetailViewController ()

@property (strong, nonatomic) BNRItem* item;

@property (weak, nonatomic) IBOutlet UITextField* nameField;
@property (weak, nonatomic) IBOutlet UITextField* serialField;
@property (weak, nonatomic) IBOutlet UITextField* valueField;
@property (weak, nonatomic) IBOutlet UILabel* dateLabel;
@property (strong, nonatomic) DatePickerController* datePicker;

@end

@implementation BNRDetailViewController

-(id) initWithItem:(BNRItem *)item
{
    self = [super init];
    
    if (self)
    {
        _item = item;
        self.navigationItem.title = _item.itemName;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissKeyboard)];
        
        [self.view addGestureRecognizer:tap];
    }
    
    return self;
}

- (void) updateDateCreated
{
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    // Use filtered NSDate object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate: _item.dateCreated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_item)
    {
        [_nameField setText: _item.itemName];
        [_serialField setText: _item.serialNumber];
        [_valueField setText: [NSString stringWithFormat:@"%d", _item.valueInDollars]];
        [self updateDateCreated];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    
    _item.itemName = _nameField.text;
    _item.serialNumber = _serialField.text;
    _item.valueInDollars = [_valueField.text intValue];
    
}

-(void) dismissKeyboard
{
    void (^resignFirstResponderBlock)(UIControl* view) = ^(UIControl* view)
    {
        if ([view isFirstResponder])
        {
            [view resignFirstResponder];
        }
    };
    
    resignFirstResponderBlock(self.valueField);
    resignFirstResponderBlock(self.serialField);
    resignFirstResponderBlock(self.nameField);
}

- (IBAction) changeCreateDate:(id)sender
{
    self.datePicker = [[DatePickerController alloc] initWithDate: _item.dateCreated];
    [self.navigationController pushViewController:self.datePicker animated: YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    if (self.datePicker)
    {
        [self.item setDateCreated: self.datePicker.selectedDate];
        [self updateDateCreated];
        self.datePicker = nil;
    }
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
