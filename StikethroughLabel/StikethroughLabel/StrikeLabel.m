//
//  StrikeLabel.m
//  StikethroughLabel
//
//  Created by Hari Kunwar on 7/27/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "StrikeLabel.h"

@implementation StrikeLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithStrikePosition:(StrikePosition)position
                 strikeColor:(UIColor *)color
                strikeHeight:(CGFloat)height;
{
    self = [super init];
    if(self){
        _strikePosition = position;
        _strikeColor = color;
        _strikeHeight = height;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
     strikePosition:(StrikePosition)position
        strikeColor:(UIColor *)color
       strikeHeight:(CGFloat)height;
{
    self = [super initWithFrame:frame];
    if (self) {
        _strikePosition = position;
        _strikeColor = color;
        _strikeHeight = height;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGFloat strikeLength = [self textSize].width;
    CGFloat strikeHeight = _strikeHeight > 0.0f ? _strikeHeight : 1.0f;
    UIColor *strikeColor = _strikeColor != nil ? _strikeColor : [UIColor blackColor];
    
    CGFloat strikePositionY = [self strikePositionY];

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, [strikeColor CGColor]);
    CGContextSetLineWidth(ctx, strikeHeight);
    CGContextMoveToPoint(ctx, 0, strikePositionY);
    CGContextAddLineToPoint(ctx, strikeLength, strikePositionY);
    
    CGContextStrokePath(ctx);
    
    [super drawRect:rect];
}

- (CGSize)textSize
{    
    CGSize textSize = [self.text sizeWithFont:self.font];
    return textSize;
}

- (CGFloat)strikePositionY
{
    CGFloat y;
    CGFloat labelMidY = CGRectGetMidY(self.bounds);//Assumption is text is centered
    CGSize textSize = [self textSize];
    CGFloat margin = 2.0f;
    switch(_strikePosition){
        case Top:
            y = labelMidY - textSize.height/2 + margin;
            break;
        case Middle:
            y = labelMidY;
            break;
        case Bottom:
            y = labelMidY + textSize.height/2 + margin;
            break;
    }
    
    return y;
}


@end
