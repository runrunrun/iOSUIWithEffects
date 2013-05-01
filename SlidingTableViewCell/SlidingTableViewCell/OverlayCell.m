//
//  OverlayCell.m
//  SlidingTableViewCell
//
//  Created by Hari Kunwar on 4/30/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "OverlayCell.h"

#define PARTIAL_OVERLAY_WIDTH 50.0f;

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
        [self setupDescriptionLabel];
        [self addSubview:_descriptionLabel];

        [self setupOverlay];
        [self addSubview:_overlayView];

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
    
    _overlayView.frame = [self overlayViewFrame];
    _descriptionLabel.frame = [self descriptionLabelFrame];
}

- (void)setupOverlay
{
    _overlayView = [[UIView alloc] init];
    
    _overlayView.backgroundColor = [UIColor redColor];
 
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOverlay:)];
    panRecognizer.delegate = self;
    [_overlayView addGestureRecognizer:panRecognizer];
}

- (void)setupDescriptionLabel
{
    _descriptionLabel = [[UILabel alloc] init];
    
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
    CGFloat width = _isFullOverlay ? CGRectGetWidth(self.frame) : PARTIAL_OVERLAY_WIDTH;
    CGFloat height = CGRectGetHeight(self.frame);
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)descriptionLabelFrame
{
    CGFloat padding = 5.0f;
    CGFloat x = padding;
    CGFloat y = padding;
    CGFloat width = CGRectGetWidth(self.frame) - 2*padding;
    CGFloat height = CGRectGetHeight(self.frame) - 2*padding;
    
    return CGRectMake(x, y, width, height);
}

#pragma mark - UITapGestureRecognizer action

- (void)panOverlay:(id)sender
{
    
	[self bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];

    
    CGPoint translatedPoint = [(UIPanGestureRecognizer *)sender translationInView:self];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _firstX = [[sender view] center].x;
        _firstY = [[sender view] center].y;
    }
    
    translatedPoint = CGPointMake(_firstX+translatedPoint.x, _firstY);
    
    [[sender view] setCenter:translatedPoint];
    
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

@end
