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
@property (nonatomic, strong) NSMutableDictionary* itemDictionary;
@property (nonatomic, strong) NSNumber* under50Key;
@property (nonatomic, strong) NSNumber* over50Key;
@end

@implementation ItemsViewController

- (NSArray*) itemsWithKey:(NSNumber*) key {
    return [_itemDictionary objectForKey:key];
}

- (void) refreshDictionary {
    _itemDictionary = [[NSMutableDictionary alloc] init];
    [_itemDictionary setObject: [[NSMutableArray alloc] init] forKey: _under50Key];
    [_itemDictionary setObject: [[NSMutableArray alloc] init] forKey: _over50Key];

    for (BNRItem* item in [[BNRItemStore sharedStore] allItems]) {
        NSMutableArray* array = [_itemDictionary objectForKey:[NSNumber numberWithInt:(item.valueInDollars > 50) ? 1 : 0]];
        
        if (array) {
            [array addObject:item];
        }
    }
    
}

- (id) init {
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        for (int i = 0; i < 5; ++i) {
            [[BNRItemStore sharedStore] createItem];
            _under50Key = [NSNumber numberWithInt: 0];
            _over50Key = [NSNumber numberWithInt: 1];
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
    
    [self refreshDictionary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numOfSections = [self numberOfSectionsInTableView:tableView];
    NSInteger returnValue = 0;
    
    if (section == numOfSections - 1) {
        returnValue = 1;
    } else {
        returnValue = [[self itemsWithKey:[NSNumber numberWithLong:section]] count];
    }
    
    return returnValue;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get a new or recycled cell
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray* items = [self itemsWithKey:[NSNumber numberWithLong:indexPath.section]];
    if (items) {
        BNRItem *item = [items objectAtIndex: indexPath.row];
        if (item) {
            cell.textLabel.font = [UIFont fontWithName:cell.textLabel.font.fontName size:20];
            cell.textLabel.text = [item description];
        }
    } else {
        cell.textLabel.text = @"No more items!";
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 2) ? 44 : 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return ([[self itemsWithKey:_under50Key] count] > 0 && [[self itemsWithKey:_over50Key] count] > 0) ? 3 : 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSInteger numOfSections = [self numberOfSectionsInTableView:tableView];
    return section == numOfSections - 1 ? @"" : (section == numOfSections - 2 ? @"over 50$" : @"under 50$");
}

@end
