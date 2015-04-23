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
    [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"DoubleSliderControl" owner:self options:nil] objectAtIndex:0]];
}



@end
