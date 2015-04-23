//
//  DoubleSliderControl.m
//  DoubleSlider
//
//  Created by Hari Kunwar on 4/22/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import "DoubleSliderControl.h"

@implementation DoubleSliderControl {
    __weak IBOutlet UIImageView *_sliderTrackBackground;
    __weak IBOutlet UIButton *_leftSlider;
    __weak IBOutlet UIButton *_rightSlider;
    __weak IBOutlet NSLayoutConstraint *_leftSliderLeadingConstraint;
    __weak IBOutlet NSLayoutConstraint *_rightSliderLeadingConstraint;
}

- (void)awakeFromNib {
    UIView *sliderView = [[[NSBundle mainBundle] loadNibNamed:@"DoubleSliderControl" owner:self options:nil] objectAtIndex:0];
    sliderView.frame = self.bounds;
    
    sliderView.layer.borderColor = [[UIColor greenColor] CGColor];
    sliderView.layer.borderWidth = 3.0f;
    
    [self addSubview:sliderView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}


@end
