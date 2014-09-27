//
//  HypnosisViewController.m
//  HypnoNerd
//
//  Created by Naum Puroski on 9/22/14.
//  Copyright (c) 2014 purocomputers. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisterView.h"

@interface HypnosisViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField* textField;
@property (nonatomic, strong) UILongPressGestureRecognizer* longPressRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer* tapGestureRecognizer;
@end

@implementation HypnosisViewController

- (void) loadView
{
    self.view = [[HypnosisterView alloc] init];
    
    _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.view addGestureRecognizer: _longPressRecognizer];
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.view addGestureRecognizer:_tapGestureRecognizer];
    
    _textField = [[UITextField alloc] init];
    _textField.delegate = self;
    _textField.hidden = YES;
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.placeholder = @"Hypnotize me";
    _textField.returnKeyType = UIReturnKeyDone;
    
    [self.view addSubview: _textField];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createLabelInPlaceOfTextField
{
    if (!_textField.hidden && _textField.text.length > 0)
    {
        UILabel* label = [[UILabel alloc] init];
        label.text = _textField.text;
        [label sizeToFit];
        CGRect textFieldFrame = _textField.frame;
        textFieldFrame.size = label.bounds.size;
        label.frame = textFieldFrame;
        
        [self.view addSubview: label];
        
        [_textField resignFirstResponder];
        _textField.hidden = YES;
    }
}

- (void) handleTapGesture : (UITapGestureRecognizer *)recognizer
{
    [self createLabelInPlaceOfTextField];
}

- (void) handleLongPress: (UITapGestureRecognizer *)recognizer
{
    if (UIGestureRecognizerStateBegan == recognizer.state)
    {
        [self createLabelInPlaceOfTextField];
        
        CGPoint pos = [recognizer locationInView: self.view];

        _textField.hidden = NO;
        _textField.text = @"";
        [_textField becomeFirstResponder];
        _textField.frame = CGRectMake(pos.x, pos.y, 240, 30);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self createLabelInPlaceOfTextField];
    return YES;
}




@end
