//
//  FlipView.m
//  FlipBoard
//
//  Created by Hari Kunwar on 7/4/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "FlipView.h"

@interface FlipView ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGPoint gestureStartPoint;
@property (nonatomic, assign) FlipDirection flipDirection;
@property (nonatomic, assign) float initialXRotation, initialYRotation, initialZRotation;

@end

@implementation FlipView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(flipView:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
    _textLabel.frame = self.bounds;
}

- (void)flipView:(UIPanGestureRecognizer*)gesture
{
    CGPoint translation = [gesture translationInView:self];
    UIGestureRecognizerState state = [gesture state];
    
    if(state == UIGestureRecognizerStateBegan){
        _initialXRotation = 0.0f;
        _initialYRotation = 0.0f;
    }
    else if (state==UIGestureRecognizerStateChanged)
    {
        float xRotation = self.initialXRotation + translation.y;
        float yRotation = self.initialYRotation + translation.x;
        
        [self flipWithDirection:_flipDirection animated:NO];
    }
    else if(state == UIGestureRecognizerStateEnded){
        _flipDirection = FlipNone;
    }
}

- (FlipDirection)flipDirectionForPanVelocity:(CGPoint)velocity
{
    FlipDirection direction;
    
    BOOL horizontalDirection = abs(velocity.x) > abs(velocity.y);

    if(horizontalDirection){
        BOOL leftDirection = velocity.x < 0;
        direction = leftDirection ? FlipLeft : FlipRight;
    }
    else{
        BOOL upDirection = velocity.y < 0;
        direction = upDirection ? FlipUp : FlipDown;
    }
    
    return direction;
}

- (void)flipWithDirection:(FlipDirection)direction animated:(BOOL)animated
{
    CGFloat xAnchor = 0.5f;
    CGFloat yAnchor = 0.5f;
    CGPoint anchor = CGPointMake(xAnchor, yAnchor);
    
    self.layer.anchorPoint = anchor;

    CATransform3D transformation = [self transformForDirection:direction];

    self.layer.transform = transformation;
}

- (CATransform3D)transformForDirection:(FlipDirection)direction
{
    CATransform3D transformation = CATransform3DIdentity;
    transformation.m34 = -0.0012f;
    
    CGFloat angle = 0.0f;    

    CGFloat xTranslation = [_xRotationSliderView value];
    CGFloat yTranslation = [_yRotationSliderView value];

    CGFloat x = 0.0f , y = 0.0f , z = 0.0f;

    switch(direction){
        case FlipLeft:
            y = -1.0f;
            angle = xTranslation * M_PI/180;
            break;
        case FlipRight:
            y = 1.0f;
            angle = xTranslation * M_PI/180;
            break;
        case FlipUp:
            x = 1.0f;
            angle = yTranslation * M_PI/180;
            break;
        case FlipDown:
            x = -1.0f;
            angle = yTranslation * M_PI/180;
            break;
        case FlipNone:
            angle = 0.0f;
    }
    
    transformation = CATransform3DRotate(transformation , angle, x, y, z);

    return transformation;
}

- (CGFloat)normalizeValue:(CGFloat)value max:(CGFloat)max min:(CGFloat)min
{
    if(max > min){
        value = value > max ? max : value;
        value = value < min ? min : value;
    }
    {
        NSLog(@"Invalid values");
    }
    
    return value;
}

@end
