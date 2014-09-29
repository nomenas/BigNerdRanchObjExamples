//
//  ViewController.m
//  Homepwner
//
//  Created by Naum Puroski on 9/28/14.
//  Copyright (c) 2014 purocomputers. All rights reserved.
//

#import "ItemsViewController.H"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface ItemsViewController ()

@end

@implementation ItemsViewController

- (id) init {
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        for (int i = 0; i < 5; ++i) {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    
    return self;
}

- (id) initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get a new or recycled cell
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    BNRItem *item = [[BNRItemStore sharedStore] itemAt: indexPath.row];
    if (item) {
        cell.textLabel.text = [item description];
    }
    
    return cell;
}

@end
