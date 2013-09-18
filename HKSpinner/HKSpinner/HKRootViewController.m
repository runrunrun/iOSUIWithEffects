//
//  HKRootViewController.m
//  HKSpinner
//
//  Created by Hari Kunwar on 9/17/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "HKRootViewController.h"
#import "HKActivityIndicatorView.h"

@interface HKRootViewController ()

@end

@implementation HKRootViewController

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
    
    HKActivityIndicatorView *spinner = [[HKActivityIndicatorView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:spinner];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
