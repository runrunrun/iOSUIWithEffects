//
//  OverlayCell.m
//  SlidingTableViewCell
//
//  Created by Hari Kunwar on 4/30/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "OverlayCell.h"
#import <QuartzCore/QuartzCore.h>

#define PARTIAL_OVERLAY_WIDTH 50.0f
#define OVERLAY_MAX_TRANSLATION 100.0F

@interface OverlayCell ()

@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, assign) BOOL isFullOverlay;
@property (nonatomic, assign) CGFloat firstX;
@property (nonatomic, assign) CGFloat firstY;

@end

@implementation OverlayCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

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

#pragma mark - UITapGestureRecognizer action

- (void)panOverlay:(id)sender
{
    UIView *overlay = [sender view];
    
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer *)sender translationInView:self];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _firstX = [overlay center].x;
        _firstY = [overlay center].y;
    }
    
    translatedPoint = CGPointMake(_firstX+translatedPoint.x, _firstY);
    
    CGFloat translation = translatedPoint.x - _firstX;
    
//    BOOL isPaningOutOfRightBound = overlay.center.x < _firstX;
    
//    if(isPaningOutOfRightBound){
//        if(overlay.frame.origin.x > OVERLAY_MAX_TRANSLATION) {
//            [overlay setCenter:CGPointMake(OVERLAY_MAX_TRANSLATION, _firstY)];
//        }
//        else{
            [overlay setCenter:translatedPoint];
//        }
//    }
    
    if([(UIPanGestureRecognizer *)sender state] == UIGestureRecognizerStateEnded){
        BOOL isOverlayOutOfBounds = overlay.frame.origin.x > OVERLAY_MAX_TRANSLATION;
        
        if(isOverlayOutOfBounds){
            CGPoint position = CGPointMake(160.0f, _firstY);
            [self animateOverlayToPosition:(CGPoint)position];
        }
        
    }
    
//    CGFloat xTranslation = translatedPoint.x - _firstX;

//    CGRect translatedFrame = [self overlayViewFrameWithHorizontalTranslation:xTranslation];
//    
//    [[sender view] setBounds:translatedFrame];

    
//    void (^animation) (void) = ^(void){
//        _overlayView.frame = [self overlayViewFrameWithHorizontalTranslation:xTranslation];
//    };
//    
//    void (^completions) (BOOL finished) = ^(BOOL finished){
//    };
//    
//    [UIView animateWithDuration:0.5f
//                          delay:0.0f
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:animation
//                    completion:completions
//     ];
}

- (void)animateOverlayToPosition:(CGPoint)position
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

@end
