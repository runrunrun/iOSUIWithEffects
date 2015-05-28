//
//  ParallaxCell.h
//  ParallaxTable
//
//  Created by Hari Kunwar on 5/27/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParallaxCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *parallaxImageView;

- (void)tableViewDidScroll:(UITableView *)tableView;

@end
