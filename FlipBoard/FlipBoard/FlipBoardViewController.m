//
//  FlipBoardViewController.m
//  FlipBoard
//
//  Created by Hari Kunwar on 7/4/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "FlipBoardViewController.h"
#import "FlipView.h"


@interface FlipBoardViewController ()


@property (nonatomic, strong) FlipView *mainView;
@property (nonatomic, strong) FlipView *leftView;
@property (nonatomic, strong) FlipView *rightView;
@property (nonatomic, strong) FlipView *upView;
@property (nonatomic, strong) FlipView *downView;

@end

@implementation FlipBoardViewController

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

    _mainView = [[FlipView alloc] init];
    _mainView.imageView.image = [UIImage imageNamed:@"Lenna"];
    _mainView.frame = self.view.bounds;

    _leftView = [[FlipView alloc] init];
    _leftView.textLabel.text = @"Left Left Left Left Left Left";
    _leftView.frame = self.view.bounds;

    _rightView = [[FlipView alloc] init];
    _rightView.textLabel.text = @"Right Right Right Right Right Right";
    _rightView.frame = self.view.bounds;

    _upView = [[FlipView alloc] init];
    _upView.textLabel.text = @"Up Up Up Up Up Up Up Up Up Up Up Up Up";
    _upView.frame = self.view.bounds;

    _downView = [[FlipView alloc] init];
    _downView.textLabel.text = @"Down Down Down Down Down Down Down Down Down";
    _downView.frame = self.view.bounds;

//    [self.view addSubview:_leftView];
//    [self.view addSubview:_rightView];
//    [self.view addSubview:_upView];
//    [self.view addSubview:_downView];
    [self.view addSubview:_mainView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
