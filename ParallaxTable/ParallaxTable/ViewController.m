//
//  ViewController.m
//  ParallaxTable
//
//  Created by Hari Kunwar on 5/27/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import "ViewController.h"
#import "ParallaxCell.h"

@interface ViewController ()

@end

@implementation ViewController {
    __weak IBOutlet UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        ParallaxCell *parallaxCell = (ParallaxCell *)[tableView dequeueReusableCellWithIdentifier:@"parallaxCell" forIndexPath:indexPath];
        parallaxCell.parallaxImageView.image = [UIImage imageNamed:@"mountains"];
        cell = parallaxCell;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"row %ld", indexPath.row];
    }
    
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    }
    else {
        return 80;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Get visible cells on table view.
    NSArray *visibleCells = [_tableView visibleCells];    
    for (ParallaxCell *cell in visibleCells) {
        if ([cell respondsToSelector:@selector(tableViewDidScroll:)]) {
            [cell tableViewDidScroll:_tableView];
        }
    }
}

@end
