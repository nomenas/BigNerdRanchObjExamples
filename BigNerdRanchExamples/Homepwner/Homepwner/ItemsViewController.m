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
#import "BNRDetailViewController.h"

@interface ItemsViewController ()
@property (nonatomic, strong) NSMutableDictionary* itemDictionary;
@property (nonatomic, strong) NSNumber* under50Key;
@property (nonatomic, strong) NSNumber* over50Key;

@property (nonatomic, strong) IBOutlet UIView *headerView;

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
    
    UIView* header = self.headerView;
    [self.tableView setTableHeaderView:header];
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
    BNRItem *item = (items && indexPath.row < items.count) ? [items objectAtIndex: indexPath.row] : nil;
    
    if (item) {
        cell.textLabel.font = [UIFont fontWithName:cell.textLabel.font.fontName size:20];
        cell.textLabel.text = [item description];
    } else {
        cell.textLabel.text = @"No more items!";
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 2) ? 44 : 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSInteger numOfSections = [self numberOfSectionsInTableView:tableView];
    return section == numOfSections - 1 ? @"" : (section == numOfSections - 2 ? @"over 50$" : @"under 50$");
}

- (UIView*) headerView {
    if (!_headerView) {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    
    return _headerView;
}

- (IBAction)addNewItem:(id)sender
{
    BNRItem* item = [[BNRItemStore sharedStore] createItem];
 
    int section = (item.valueInDollars > 50) ? 1 : 0;
    NSMutableArray* array = [_itemDictionary objectForKey:[NSNumber numberWithInt:section]];
    [array addObject:item];
    
    NSIndexPath* path = [NSIndexPath indexPathForRow:(array.count - 1) inSection:section];
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
}

- (IBAction) toggleEditingMode:(id)sender
{
    if ([self.tableView isEditing]) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self.tableView setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self.tableView setEditing:YES animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray* array = [_itemDictionary objectForKey:[NSNumber numberWithLong:indexPath.section]];
        BNRItem* item = array && indexPath.row < array.count ? [array objectAtIndex:indexPath.row] : nil;
        
        if (item) {
            [[BNRItemStore sharedStore] removeItem:item];
            [array removeObject:item];
            
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

- (void)tableView:(UITableView *)tableView
        moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
        toIndexPath:(NSIndexPath *)destinationIndexPath
{
}

- (void) tableView: (UITableView*)tableView didSelectRowAtIndexPath: (NSIndexPath*)indexPath
{
    NSMutableArray* array = [_itemDictionary objectForKey:[NSNumber numberWithLong:indexPath.section]];
    BNRItem* item = array && indexPath.row < array.count ? [array objectAtIndex:indexPath.row] : nil;
    
    BNRDetailViewController* detailController = [[BNRDetailViewController alloc] initWithItem: item];
    [self.navigationController pushViewController: detailController animated: YES];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshDictionary];
    [self.tableView reloadData];
}

@end
