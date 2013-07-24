//
//  PieMenuCG.m
//  PieMenu
//
//  Created by Hari Kunwar on 7/20/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "PieMenuCG.h"
#import <QuartzCore/QuartzCore.h>

@interface PieMenuCG ()

@property (nonatomic, strong) UIView *menu;
@property (nonatomic, strong) CAShapeLayer *menuInnerCircle;
@property (nonatomic, strong) CAShapeLayer *menuOuterCircle;
@property (nonatomic, assign) CGSize closedMenuSize;
@property (nonatomic, assign) CGSize openMenuSize;

@end

@implementation PieMenuCG

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _closedMenuSize = self.bounds.size;
        
        _menu = [[UIView alloc] init];
        _menu.frame = self.bounds;

        _menuOuterCircle = [self circleLayerInRect:self.bounds];
        _menuOuterCircle.fillColor =[[UIColor blueColor] CGColor];
        [_menu.layer addSublayer:_menuOuterCircle];

        _menuInnerCircle = [self circleLayerInRect:CGRectInset(self.bounds, 5.0f, 5.0f)];
        _menuInnerCircle.fillColor =[[UIColor redColor] CGColor];
        [_menu.layer addSublayer:_menuInnerCircle];
        
        [self addSubview:_menu];
        
        self.layer.borderColor = [[UIColor redColor] CGColor];
        self.layer.borderWidth = 2.0f;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuTapped:)];
        [_menu addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (CAShapeLayer *)circleLayerInRect:(CGRect)rect
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = [[UIBezierPath bezierPathWithOvalInRect:rect] CGPath];
    
    return layer;
}

- (void)menuTapped:(UITapGestureRecognizer *)tapGesture
{
//    self.frame = [self toggleFrame];
//    CGRect bounds = self.bounds;
//    bounds.size.width = 2 * bounds.size.width;
//    bounds.size.height = 2 * bounds.size.height;
//
//    _menuOuterCircle.bounds = bounds;
        
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
//    animation.fromValue = (__bridge id)[[UIBezierPath bezierPathWithOvalInRect:self.bounds] CGPath];
    animation.toValue = (id)[UIBezierPath bezierPathWithOvalInRect:[self menuFrame]].CGPath;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_menuOuterCircle addAnimation:animation forKey:@"path"];
    
    _menuOuterCircle.path = [UIBezierPath bezierPathWithOvalInRect:[self menuFrame]].CGPath;
}


- (CGRect)menuFrame
{
    BOOL openMenu = (CGRectGetWidth(self.bounds) >= 2*_closedMenuSize.width);
    CGFloat width = openMenu ? _closedMenuSize.width : 2 * _closedMenuSize.width;
    CGFloat height = width;
    CGFloat x = CGRectGetMidX(self.bounds) - width/2;
    CGFloat y = CGRectGetMidY(self.bounds) - height/2;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)toggleFrame
{
    CGFloat width = (CGRectGetWidth(self.bounds) >= 2*_closedMenuSize.width) ? _closedMenuSize.width : 2*_closedMenuSize.width;
    CGFloat height = width;
    CGFloat x = CGRectGetMidX(self.frame) - width/2;
    CGFloat y = CGRectGetMidY(self.frame) - height/2;
    
    return CGRectMake(x, y, width, height);
}

@end
