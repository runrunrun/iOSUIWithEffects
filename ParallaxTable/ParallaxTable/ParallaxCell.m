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

- (void)tableViewDidScroll:(UITableView *)tableView {
    CGFloat offset = tableView.contentOffset.y / CGRectGetHeight(tableView.bounds);
    CGFloat cellOffset = offset * CGRectGetHeight(self.bounds);
    _parallaxImageViewTop.constant = cellOffset > 0 ? cellOffset : 0.0f;
}

@end
