//
//  PieMenu.m
//  PieMenu
//
//  Created by Hari Kunwar on 7/20/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//


#import "PieMenu.h"
#import <QuartzCore/QuartzCore.h>

#define PieCoreRadius 25.0f

@interface PieMenu() <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *core;
@property (nonatomic, strong) UIView *menu;
@property (nonatomic, strong) CALayer *menuLayer;


@end


@implementation PieMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _core = [[UIView alloc] initWithFrame:[self pieCoreFrame]];
        _core.backgroundColor = [UIColor redColor];
        _core.layer.cornerRadius = PieCoreRadius;

        _menu = [[UIView alloc] initWithFrame:self.bounds];
        _menu.backgroundColor = [UIColor blueColor];
        _menu.layer.cornerRadius = CGRectGetWidth(self.bounds)/2;
        
        [self addSubview:_menu];
        [self addSubview:_core];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pieMenuTapped:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)addCircleLayer:(UIView *)view
{
    _menuLayer = [CALayer layer];
    
    [_menuLayer setBounds:view.bounds];
    [_menuLayer setPosition:CGPointMake(view.center.x, view.center.y)];
    [_menuLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
    [_menuLayer setCornerRadius:CGRectGetWidth(self.bounds)/2];
    [view.layer addSublayer:_menuLayer];
}

- (void)pieMenuTapped:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self];
    
    CGRect pieCoreFrame = [self pieCoreFrame];
    BOOL pieCoreTapped = CGRectContainsPoint(pieCoreFrame, tapLocation);
    
    if(pieCoreTapped){
        [self togglePieMenu];
    }
}

#pragma mark -
- (void)togglePieMenu
{
    CGFloat width = (CGRectGetWidth(self.bounds) > 3*PieCoreRadius) ? CGRectGetWidth(self.bounds)/2 : 2*CGRectGetWidth(self.bounds);
    CGFloat height = width;
    CGFloat x = CGRectGetMidX(self.frame) - width/2;
    CGFloat y = CGRectGetMidY(self.frame) - height/2;
    
    self.frame = CGRectMake(x, y, width, height);
    
    _core.frame = [self pieCoreFrame];

    _menu.layer.position = _core.center;
    
    CABasicAnimation *resizeAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    [resizeAnimation setToValue:[NSValue valueWithCGSize:CGSizeMake(CGRectGetWidth(self.bounds),CGRectGetHeight(self.bounds))]];
    resizeAnimation.fillMode = kCAFillModeForwards;
    resizeAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *cornerAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    cornerAnimation.fromValue = [NSNumber numberWithFloat:CGRectGetWidth(_menu.frame)/2];
    cornerAnimation.toValue = [NSNumber numberWithFloat:CGRectGetWidth(self.bounds)/2];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:resizeAnimation, cornerAnimation,nil];
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion=NO;
    animationGroup.duration = 1.0f;
    
    [_menu.layer addAnimation:animationGroup forKey:@"animations"];

}

#pragma mark - Frames

- (CGRect)pieCoreFrame
{
    CGFloat x = CGRectGetMidX(self.bounds) - PieCoreRadius;
    CGFloat y = CGRectGetMidY(self.bounds) - PieCoreRadius;
    CGFloat width = 2*PieCoreRadius;
    CGFloat height = width;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)menuFrame
{
    return self.bounds;
}

//- (CGRect)pieMenuOpenedFrame
//{
//    
//    return CGRectMake(x, y, width, height);
//}


@end
