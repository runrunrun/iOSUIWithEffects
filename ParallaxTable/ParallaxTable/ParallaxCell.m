//
//  ParallaxCell.m
//  ParallaxTable
//
//  Created by Hari Kunwar on 5/27/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import "ParallaxCell.h"

@implementation ParallaxCell {
    __weak IBOutlet NSLayoutConstraint *_parallaxImageViewTop;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)tableView:(UITableView *)tableView didScrollOnView:(UIView *)view {
    
    CGRect rectInSuperview = [tableView convertRect:self.frame toView:view];
    
    float distanceFromCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperview);
    float difference = CGRectGetHeight(self.parallaxImageView.frame) - CGRectGetHeight(self.frame);
    float move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
    
//    CGRect imageRect = self.parallaxImageView.frame;
//    imageRect.origin.y = -(difference/2)+ move;
    _parallaxImageViewTop.constant = -(difference/2)+ move;
//    self.parallaxImageView.frame = imageRect;
}

@end
