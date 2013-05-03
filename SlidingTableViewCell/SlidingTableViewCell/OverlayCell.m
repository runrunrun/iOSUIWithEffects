//
//  OverlayCell.m
//  SlidingTableViewCell
//
//  Created by Hari Kunwar on 4/30/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "OverlayCell.h"
#import <QuartzCore/QuartzCore.h>

#define OVERLAY_PIN_POSITION_X  70

@interface OverlayCell ()

@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) UIButton *buttonOne;
@property (nonatomic, strong) UIButton *buttonTwo;
@property (nonatomic, assign) BOOL isOverlayPinned;
@property (nonatomic, assign) CGFloat firstX;
@property (nonatomic, assign) CGFloat firstY;


@end

@implementation OverlayCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self setupButtons];
        
        [self addSubview:_buttonOne];
        [self addSubview:_buttonTwo];

        
        [self setupOverlay];
        [self addSubview:_overlayView];
        
        [self setupDescriptionLabel];
        [_overlayView addSubview:_descriptionLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _descriptionLabel.frame = [self descriptionLabelFrame];
    _buttonOne.frame = [self buttonOneFrame];
    _buttonTwo.frame = [self buttonTwoFrame];
}

- (void)setupButtons
{
    _buttonOne = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _buttonTwo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [_buttonOne addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonTwo addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _buttonOne.tag = 1;
    _buttonTwo.tag = 2;
}

- (void)setupOverlay
{
    _overlayView = [[UIView alloc] init];
    
    _overlayView.backgroundColor = [UIColor blueColor];
 
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOverlay:)];
    panRecognizer.delegate = self;
    
    [_overlayView addGestureRecognizer:panRecognizer];
    
    _overlayView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _overlayView.contentMode = UIViewContentModeScaleToFill;
    _overlayView.frame = [self overlayViewFrame];
}

- (void)setupDescriptionLabel
{
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.backgroundColor = [UIColor clearColor];
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;    
}

#pragma mark - Frame calculations

- (CGRect)overlayViewFrameWithHorizontalTranslation:(CGFloat)translation
{
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    CGFloat width = 50.0f + translation;
    CGFloat height = CGRectGetHeight(self.frame);
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)overlayViewFrame
{
    CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    CGFloat width =  CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)descriptionLabelFrame
{
    return _overlayView.bounds;
}

- (CGRect)buttonOneFrame
{
    CGFloat width = 20.0f;
    CGFloat height = self.bounds.size.height;
    CGFloat x = 5.0f;
    CGFloat y = 0.0f;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)buttonTwoFrame
{
    CGFloat width = 20.0f;
    CGFloat height = self.bounds.size.height;
    CGFloat x = CGRectGetMaxX(_buttonOne.frame) + 10;
    CGFloat y = 0.0f;
    
    return CGRectMake(x, y, width, height);
}

#pragma mark - Button Action
- (void)buttonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    NSString *title = button.tag == 1 ? @"Button one pressed" : @"Button two pressed";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - UITapGestureRecognizer action

- (void)panOverlay:(id)sender
{
    UIView *overlay = [sender view];
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer *)sender translationInView:self];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _firstX = [overlay center].x ;
        _firstY = [overlay center].y;
    }
    
    translatedPoint = CGPointMake(_firstX+translatedPoint.x, _firstY);
    [overlay setCenter:translatedPoint];
    
    if([(UIPanGestureRecognizer *)sender state] == UIGestureRecognizerStateEnded){
        
        BOOL shouldPinOverlay = overlay.frame.origin.x > OVERLAY_PIN_POSITION_X;
            
        CGPoint position;
        
        if(shouldPinOverlay){
           position = CGPointMake(self.center.x + OVERLAY_PIN_POSITION_X, _firstY);
            _isOverlayPinned = YES;
        }
        else {
            position = CGPointMake(self.center.x, _firstY);
        }
        
        [self animateOverlayCenterToPosition:(CGPoint)position];
    }
}

- (void)animateOverlayCenterToPosition:(CGPoint)position
{
    void (^animation) (void) = ^(void){
        _overlayView.center = position;
    };

    void (^completions) (BOOL finished) = ^(BOOL finished){
    };

    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:animation
                    completion:completions
     ];
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;
{
    CGPoint velocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:self];

    NSLog(@"%f  %f", velocity.y, velocity.x);
    
    BOOL isPanningHorizontally = (fabs(velocity.x) > fabs(velocity.y)) ? YES : NO;
    
    BOOL isPanningToRightSide = velocity.x > 0 ? YES : NO;
    
    BOOL gestureRecognizerShouldBegin;

    if(_isOverlayPinned) {
        gestureRecognizerShouldBegin = isPanningHorizontally;
        _isOverlayPinned = NO;
    }
    else {
        gestureRecognizerShouldBegin = isPanningHorizontally && isPanningToRightSide;
    }
    
    return gestureRecognizerShouldBegin;
}


@end
