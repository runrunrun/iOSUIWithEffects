//
//  DoubleSliderControl.m
//  DoubleSlider
//
//  Created by Hari Kunwar on 4/22/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import "DoubleSliderControl.h"

@interface DoubleSliderControl () <UIGestureRecognizerDelegate>

@end

@implementation DoubleSliderControl {
    __weak IBOutlet UIImageView *_sliderTrackBackground;
    __weak IBOutlet UIButton *_leftSlider;
    __weak IBOutlet UIButton *_rightSlider;
    __weak IBOutlet NSLayoutConstraint *_leftSliderLeadingConstraint;
    __weak IBOutlet NSLayoutConstraint *_rightSliderLeadingConstraint;
    UIPanGestureRecognizer *_leftSliderPanGestureRecognizer;
    UIPanGestureRecognizer *_rightSliderPanGestureRecognizer;
    CGPoint _leftSliderGestureStartingCenter;
    CGPoint _rightSliderGestureStartingCenter;
    
    CGPoint _leftSliderGestureStartingOrigin;
    CGPoint _rightSliderGestureStartingOrigin;

}

- (void)awakeFromNib {
    UIView *sliderView = [[[NSBundle mainBundle] loadNibNamed:@"DoubleSliderControl" owner:self options:nil] objectAtIndex:0];
    sliderView.frame = self.bounds;
    
    sliderView.layer.borderColor = [[UIColor greenColor] CGColor];
    sliderView.layer.borderWidth = 3.0f;
    
    [self addSubview:sliderView];
    
    
    _leftSliderPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panLeftSlider:)];
    _leftSliderPanGestureRecognizer.delegate = self;
    [_leftSlider addGestureRecognizer:_leftSliderPanGestureRecognizer];
    
    _rightSliderPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRightSlider:)];
    _rightSliderPanGestureRecognizer.delegate = self;
    [_rightSlider addGestureRecognizer:_rightSliderPanGestureRecognizer];
}


- (void)panLeftSlider:(UIPanGestureRecognizer *)panGestureRecognizer {
    UIGestureRecognizerState gestureState = [panGestureRecognizer state];
    
    if(gestureState == UIGestureRecognizerStateBegan) {
        _leftSliderGestureStartingCenter = _leftSlider.center ;
        _leftSliderGestureStartingOrigin = _leftSlider.frame.origin;
    }
    
    CGPoint translatedPoint = [panGestureRecognizer translationInView:self];
    CGPoint translatedOrigin = CGPointMake(_leftSliderGestureStartingOrigin.x + translatedPoint.x, _leftSliderGestureStartingOrigin.y);
    
    _leftSliderLeadingConstraint.constant = translatedOrigin.x;
    
    _rightSliderLeadingConstraint.constant = _rightSlider.frame.origin.x;
}

- (void)panRightSlider:(UIPanGestureRecognizer *)panGestureRecognizer {
    UIGestureRecognizerState gestureState = [panGestureRecognizer state];
    
    if(gestureState == UIGestureRecognizerStateBegan) {
        _rightSliderGestureStartingOrigin = _rightSlider.frame.origin ;
    }
    
    CGPoint translatedPoint = [panGestureRecognizer translationInView:self];
    CGPoint translatedOrigin = CGPointMake(_rightSliderGestureStartingOrigin.x + translatedPoint.x, _rightSliderGestureStartingOrigin.y);
    
    _rightSliderLeadingConstraint.constant = translatedOrigin.x;
}

@end
