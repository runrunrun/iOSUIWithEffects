//
//  OverlayCell.m
//  TableCellOverlay
//
//  Created by Hari Kunwar on 4/30/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "OverlayCell.h"

#define PARTIAL_OVERLAY_WIDTH 50.0f;

@interface OverlayCell ()

@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, assign) BOOL isFullOverlay;

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
 
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleOverlay)];
    
    tapRecognizer.delegate = self;
    
    [_overlayView addGestureRecognizer:tapRecognizer];    
}

- (void)setupDescriptionLabel
{
    _descriptionLabel = [[UILabel alloc] init];
    
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - Frame calculations

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

- (void)toggleOverlay
{
    _isFullOverlay = !_isFullOverlay;

    void (^animation) (void) = ^(void){
        _overlayView.frame = [self overlayViewFrame];
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
