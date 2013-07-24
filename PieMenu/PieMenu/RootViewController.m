//
//  RootViewController.m
//  PieMenu
//
//  Created by Hari Kunwar on 7/20/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "RootViewController.h"
#import "PieMenu.h"
#import "PieMenuCG.h"

@interface RootViewController ()

@property (nonatomic, strong) PieMenuCG *pieMenuCG;
@property (nonatomic, strong) PieMenu *pieMenu;

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
    
    self.view.backgroundColor = [UIColor grayColor];
    
    _pieMenu = [[PieMenu alloc] initWithFrame:CGRectMake(200, 300, 60, 60)];
    _pieMenuCG = [[PieMenuCG alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];

    [self.view addSubview:_pieMenu];
    [self.view addSubview:_pieMenuCG];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
