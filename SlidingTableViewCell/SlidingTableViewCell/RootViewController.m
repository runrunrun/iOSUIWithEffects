//
//  RootViewController.m
//  SlidingTableViewCell
//
//  Created by Hari Kunwar on 4/30/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "RootViewController.h"
#import "OverlayCell.h"

#define CELL_HEIGHT 80.0f;

@interface RootViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"%d%d",indexPath.section, indexPath.row];
    //inefficent solution not for real apps
    
    OverlayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[OverlayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.descriptionLabel.text = [NSString stringWithFormat:@"Section : %d, Row : %d", indexPath.section, indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 13;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

#pragma mark - OverlayCellDelegate

- (void)didFullOverlay:(BOOL)fullOverlay
{
    
}

@end
