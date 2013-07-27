//
//  StrikeLabel.h
//  StikethroughLabel
//
//  Created by Hari Kunwar on 7/27/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum StrikePosition{
    Middle,//default
    Top,
    Bottom
}StrikePosition;

@interface StrikeLabel : UILabel

@property (nonatomic, strong) UIColor *strikeColor;
@property (nonatomic, assign) StrikePosition strikePosition;
@property (nonatomic, assign) CGFloat strikeHeight;

- (id)initWithStrikePosition:(StrikePosition)position
                 strikeColor:(UIColor *)color
                strikeHeight:(CGFloat)height;

- (id)initWithFrame:(CGRect)frame
     strikePosition:(StrikePosition)position
        strikeColor:(UIColor *)color
       strikeHeight:(CGFloat)height;


@end
