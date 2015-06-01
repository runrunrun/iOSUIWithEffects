//
//  ParallaxCell.m
//  ParallaxTable
//
//  Created by Hari Kunwar on 5/27/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import "ParallaxCell.h"


@implementation ParallaxCell {
    __weak IBOutlet NSLayoutConstraint *_parallaxTop;
    __weak IBOutlet UIScrollView *_scrollView;
    NSMutableArray *_imageViews;
    __weak IBOutlet UIPageControl *_pageControl;
}

- (void)awakeFromNib {
    // Initialization code
    
    _imageViews = [NSMutableArray new];
}

- (void)setImages:(NSArray *)images {
    _images = images;
    
    _pageControl.numberOfPages = images.count;
    _pageControl.currentPage = 0;
    
    for (UIImage *image in self.images) {
        UIImageView *imageView = [UIImageView new];
        imageView.image = image;
        [_scrollView addSubview:imageView];
        [_imageViews addObject:imageView];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _pageControl.currentPage = currentPage;
    CGPoint point = _scrollView.contentOffset;
    CGFloat pageWidth = self.frame.size.width;
    point.x = pageWidth * currentPage;
    _scrollView.contentOffset = point;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    NSInteger i = 0;
    for (UIImageView *imageView in _imageViews) {
        CGRect frame;
        frame.origin.x = self.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.frame.size;
        imageView.frame = frame;
        i++;
    }
    
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * _imageViews.count, self.frame.size.height);
    
    self.layer.borderColor = [[UIColor yellowColor] CGColor];
    self.layer.borderWidth = 1.0f;
}

- (void)tableViewDidScroll:(UITableView *)tableView {
    CGFloat offset = tableView.contentOffset.y / CGRectGetHeight(tableView.bounds);
    CGFloat cellOffset = offset * CGRectGetHeight(self.bounds);
    _parallaxTop.constant = cellOffset > 0 ? cellOffset : 0.0f;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
    
    [self.delegate pageControl:_pageControl didUpdateCurrentPage:page];
}

@end
