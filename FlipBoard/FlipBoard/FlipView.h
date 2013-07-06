//
//  FlipView.h
//  FlipBoard
//
//  Created by Hari Kunwar on 7/4/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum FlipDirection{
    FlipNone,
    FlipUp,
    FlipDown,
    FlipLeft,
    FlipRight
}FlipDirection;

@interface FlipView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;

- (void)flipWithDirection:(FlipDirection)direction translation:(CGPoint)translation animated:(BOOL)animated;

@end
