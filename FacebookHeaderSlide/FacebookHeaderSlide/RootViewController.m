//
//  RootViewController.m
//  FacebookHeaderSlide
//
//  Created by Hari Kunwar on 12/2/13.
//  Copyright (c) 2013 Hari Kunwar. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *subHeaderView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGPoint gestureStartPoint;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    _subHeaderView = [[UIView alloc] init];
    _subHeaderView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_subHeaderView];
    
    _headerView = [[UIView alloc] init];
    _headerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_headerView];
    
    [_tableView.panGestureRecognizer addTarget:self action:@selector(panView:)];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect frame = self.view.bounds;
    frame.size.height = 50.0f;
    _headerView.frame = frame;
    
    frame.origin.y = frame.origin.y + frame.size.height;
    _subHeaderView.frame = frame;
    
//    frame.origin.y = frame.origin.y + frame.size.height;
//    frame.size.height = CGRectGetHeight(self.view.bounds) - frame.origin.y;
//    _tableView.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"table cells";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Section : %d row : %d", indexPath.section, indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

#pragma mark - private methods

- (void)panView:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *cardView = [gestureRecognizer view];
    
    UIGestureRecognizerState recognizerState = [gestureRecognizer state];
    
    CGPoint translatedPoint = [gestureRecognizer translationInView:self.view];
    //    translatedPoint = CGPointMake(_gestureStartPoint.x, _gestureStartPoint.y + translatedPoint.y);
    CGPoint velocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:self.view];
    NSLog(@"%f", translatedPoint.y);

    BOOL panUp = velocity.y < 0;

    if (panUp) {
        [self slideUpWithDisplacement:translatedPoint.y];
    }
    else{
        [self slideDownWithDisplacement:translatedPoint.y];
    }
    
    if(recognizerState == UIGestureRecognizerStateBegan){
        _gestureStartPoint = cardView.center;
    }
    else if (recognizerState == UIGestureRecognizerStateEnded){

        if(panUp){
            //animate header section closing.
            NSLog(@"Closing %f", translatedPoint.y);
          }
        else{
            //check if threshold distance moved.
            //if yes
            CGFloat panDownDistance = translatedPoint.y;
            BOOL panHeaderViews = panDownDistance > CGRectGetHeight(self.view.bounds)/3;
            if (panHeaderViews) {
                //animate header section opening.
                NSLog(@"Opening %f", translatedPoint.y);
            }
        }
    }
}

- (void)slideUpWithDisplacement:(CGFloat)displacement
{
    CGRect frame = _subHeaderView.frame;
    BOOL displaceSubHeaderView = CGRectGetMaxY(_subHeaderView.frame) >= CGRectGetMaxY(_headerView.frame);
    
    if (displaceSubHeaderView) {
        frame.origin.y = frame.origin.y + displacement/30;
        _subHeaderView.frame = frame;
    }
}

- (void)slideDownWithDisplacement:(CGFloat)displacement
{
    CGRect frame = _subHeaderView.frame;
    BOOL displaceSubHeaderView = CGRectGetMinY(_subHeaderView.frame) < CGRectGetMaxY(_headerView.frame);
    
    if (displaceSubHeaderView) {
        frame.origin.y = frame.origin.y + displacement/30;
        _subHeaderView.frame = frame;
    }
}

@end
