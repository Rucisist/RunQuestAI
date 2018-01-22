//
//  MainViewTabbarController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 16.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISMainViewTabbarController.h"
#import "AISBeginRunViewController.h"
#import "AISStatsViewController.h"
#import "AISPrisesCollectionViewController.h"
#import "AISPrisesPagesViewController.h"

@interface AISMainViewTabbarController ()

@property (nonatomic, strong) UIImageView *loadingImageView;
@property (nonatomic, strong) AISBeginRunViewController *beginRunViewController;
@property (nonatomic, strong) AISStatsViewController *statsViewController;
@property (nonatomic, strong) AISPrisesCollectionViewController *prisesCollectionViewController;
@property (nonatomic, strong) AISPrisesPagesViewController *prisesPagesViewController;

@end

@implementation AISMainViewTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTabBarWithViewControllers];
    [self initializeLoadingView];
    [self animateLoading];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    [self.beginRunViewController configureSaberView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureTabBarWithViewControllers
{
    self.beginRunViewController = [AISBeginRunViewController new];
    self.statsViewController = [AISStatsViewController new];
    self.prisesPagesViewController = [AISPrisesPagesViewController new];
    
    UITabBarItem *firstItem = [[UITabBarItem alloc] initWithTitle:@"run" image:[UIImage imageNamed:@"road"] tag:0];
    UITabBarItem *rightTabBarItem = [[UITabBarItem alloc] initWithTitle:@"stats" image:[UIImage imageNamed:@"runbuttonImageLittle"] tag:1];
    UITabBarItem *thirdTabBarItem = [[UITabBarItem alloc] initWithTitle:@"prises" image:[UIImage imageNamed:@"medal"] tag:2];
    
    self.beginRunViewController.tabBarItem = firstItem;
    
    self.statsViewController.tabBarItem = rightTabBarItem;

    self.prisesPagesViewController.tabBarItem = thirdTabBarItem;
    
    NSArray *tabBarControllers = @[self.beginRunViewController, self.statsViewController, self.prisesPagesViewController];
    
    self.viewControllers = tabBarControllers;
}

-(void)initializeLoadingView
{
    self.loadingImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.loadingImageView.image = [UIImage imageNamed:@"redSaberInitialImage"];
    self.loadingImageView.backgroundColor = [UIColor blackColor];
    self.loadingImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.loadingImageView];
}

-(void)animateLoading
{
    UIView *helperCoverView = [[UIView alloc] initWithFrame:self.view.frame];
    helperCoverView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:helperCoverView];
    
    CGRect theFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0);
    
    [UIView animateWithDuration:2.0 animations:^{
        helperCoverView.frame = theFrame;
    } completion:^(BOOL Complete){
        
    }];
    
    [UIView animateWithDuration:2.0 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.loadingImageView.alpha = 0.0;
    } completion:^(BOOL Finished){
        [self.view sendSubviewToBack:self.loadingImageView];
        [self.view sendSubviewToBack:helperCoverView];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
