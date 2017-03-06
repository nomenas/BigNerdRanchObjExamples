//
//  HypnosisterView.m
//  Hypnosister
//
//  Created by Naum Puroski on 9/16/14.
//  Copyright (c) 2014 purocomputers. All rights reserved.
//

#import "HypnosisterView.h"
	
@implementation HypnosisterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.circleColor = [UIColor lightGrayColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    
    // Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    UIBezierPath* path1 = [[UIBezierPath alloc] init];
    
    void (^addCircleBlock)(UIBezierPath*, CGPoint, float) = ^(UIBezierPath* path, CGPoint center, float radius)
    {
        [path moveToPoint:CGPointMake(center.x + radius, center.y)];
        [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle: M_PI * 2 clockwise:YES];
    };
    for (float radius = (MAX(bounds.size.width, bounds.size.height) / 2.0) + 20; radius > 10; radius -= 20)
    {
        addCircleBlock(path, center, radius);
        addCircleBlock(path1, center, radius);
    }
    
    path.lineWidth = 10;
    [self.circleColor setStroke];
    [path stroke];
    path1.lineWidth = 2;
    [[UIColor blackColor] setStroke];
    [path1 stroke];
    
    UIImage* image = [UIImage imageNamed:@"Earth_Western_Hemisphere_transparent_background"];
    CGSize imageSize = CGSizeMake(20, 20);
    [image drawInRect: CGRectMake(center.x - imageSize.width / 2, center.y - imageSize.height / 2, imageSize.width, imageSize.height)];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    float red = ((float) (arc4random() % 100)) / 100.0;
    float green = ((float) (arc4random() % 100)) / 100.0;
    float blue = ((float) (arc4random() % 100)) / 100.0;

    self.circleColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    [self setNeedsDisplay];
}
@end
