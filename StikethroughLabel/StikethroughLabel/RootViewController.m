//
//  RootViewController.m
//  StikethroughLabel
//
//  Created by Hari Kunwar on 7/27/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "RootViewController.h"
#import "StrikeLabel.h"

@interface RootViewController ()

@property (nonatomic, strong) StrikeLabel *label;

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

    StrikeLabel *label1 = [[StrikeLabel alloc] init];
    label1.text = @"dfdfdfdfd";
    label1.strikeColor = [UIColor blueColor];
    label1.strikeHeight = 1.0f;
    label1.strikePosition = Middle;
    label1.frame = CGRectMake(30.0f, 100.0f, 200.0f, 80.0f);
    
    [self.view addSubview:label1];

    
    StrikeLabel *label2 = [[StrikeLabel alloc] initWithStrikePosition:Top strikeColor:[UIColor redColor] strikeHeight:1.0f];
    label2.text = @"dfdfdfdfd";
    label2.frame = CGRectMake(70.0f, 200.0f, 200.0f, 80.0f);
    
    [self.view addSubview:label2];
    
    
    StrikeLabel *label3 = [[StrikeLabel alloc] initWithFrame:CGRectMake(200.0f, 400.0f, 200.0f, 80.0f)
                                              strikePosition:Bottom
                                                 strikeColor:[UIColor blackColor]
                                                strikeHeight:1.0f];
    label3.text = @"dfdfdfdfd";
    
    [self.view addSubview:label3];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
