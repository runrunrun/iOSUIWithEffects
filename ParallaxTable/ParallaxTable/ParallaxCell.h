//
//  ParallaxCell.h
//  ParallaxTable
//
//  Created by Hari Kunwar on 5/27/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ParallaxPageDelegate <NSObject>

- (void)pageControl:(UIPageControl *)control didUpdateCurrentPage:(NSInteger)currentPage;

@end

@interface ParallaxCell : UITableViewCell

@property (nonatomic, assign) id<ParallaxPageDelegate> delegate;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) NSInteger currentPage;

- (void)tableViewDidScroll:(UITableView *)tableView;

@end
