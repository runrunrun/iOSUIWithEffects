//
//  HKActivityIndicatorView.m
//  HKSpinner
//
//  Created by Hari Kunwar on 9/17/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "HKActivityIndicatorView.h"

@implementation HKActivityIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor redColor];
        
        NSInteger numberOfBars = 14;

        CGFloat rotationAngle = 0.0f;
        
        CGFloat width = 4.0f;
        CGFloat height = 40.0f;
        CGFloat x = CGRectGetMidX(self.bounds) - width/2;
        CGFloat y = CGRectGetMidY(self.bounds) - height/2;

        NSInteger count = numberOfBars;
        
        while (count > 0) {
        
            CGRect frame = CGRectMake(x, y, width, height);
            UIView *transparentView = [[UIView alloc] initWithFrame:frame];
            UIView *colorView = [[UIView alloc] initWithFrame:CGRectInset(transparentView.bounds, 0, height/3)];
            colorView.backgroundColor = [UIColor whiteColor];
            [transparentView addSubview:colorView];
            
            colorView.layer.cornerRadius = width/2;
            
            //antialias
            colorView.layer.borderWidth = 3.0f;
            colorView.layer.borderColor = [[UIColor clearColor] CGColor];
            colorView.layer.shouldRasterize = YES;

            //anchor point cannot be outside the view, therefore using a transparent container with anchor point at bottom.
            transparentView.layer.anchorPoint = CGPointMake(0.5f, 0.0f);
            transparentView.transform = CGAffineTransformRotate(transparentView.transform, rotationAngle);
        
            [self addSubview:transparentView];
            
            rotationAngle = rotationAngle + 2*M_PI/numberOfBars;
            
            count = count - 1;
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end
