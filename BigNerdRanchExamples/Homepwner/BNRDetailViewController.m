//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Naum Puroski on 10/30/14.
//  Copyright (c) 2014 purocomputers. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"

@interface BNRDetailViewController ()

@property (strong, nonatomic) BNRItem* item;

@property (weak, nonatomic) IBOutlet UITextField* nameField;
@property (weak, nonatomic) IBOutlet UITextField* serialField;
@property (weak, nonatomic) IBOutlet UITextField* valueField;
@property (weak, nonatomic) IBOutlet UILabel* dateLabel;

@end

@implementation BNRDetailViewController

-(id) initWithItem:(BNRItem *)item
{
    self = [super init];
    
    if (self)
    {
        _item = item;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_item)
    {
        [_nameField setText: _item.itemName];
        [_serialField setText: _item.serialNumber];
        [_valueField setText: [NSString stringWithFormat:@"%d", _item.valueInDollars]];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
