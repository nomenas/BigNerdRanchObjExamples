//
//  HypnosisterViewController.m
//  Hypnosister
//
//  Created by Naum Puroski on 9/21/14.
//  Copyright (c) 2014 purocomputers. All rights reserved.
//

#import "HypnosisterViewController.h"
#import "HypnosisterView.h"

@interface HypnosisterViewController ()

@end

@implementation HypnosisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.view = scrollView;
    
    CGRect boundsRect = [[UIScreen mainScreen] bounds];
    CGRect hypsterViewRect = CGRectMake(boundsRect.origin.x, boundsRect.origin.y, boundsRect.size.width * 2, boundsRect.size.height * 2);
    HypnosisterView* hypnosisterView = [[HypnosisterView alloc] initWithFrame: hypsterViewRect];
    hypnosisterView.backgroundColor = [UIColor clearColor];
    
    [scrollView addSubview: hypnosisterView];
//    scrollView.pagingEnabled = YES;
    scrollView.contentSize = hypsterViewRect.size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
