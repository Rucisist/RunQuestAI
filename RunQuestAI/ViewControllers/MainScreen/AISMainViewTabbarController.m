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

static const double AISSaberAppearAnimationDuration = 2.0;
static const double AISSaberDissapearAnimationDuration = 2.0;
static const double AISDelayAnimationDuration = 2.0;

@interface AISMainViewTabbarController ()

@property (nonatomic, strong) UIImageView *loadingImageView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) AISBeginRunViewController *beginRunViewController;
@property (nonatomic, strong) AISStatsViewController *statsViewController;
@property (nonatomic, strong) AISPrisesCollectionViewController *prisesCollectionViewController;
@property (nonatomic, strong) AISPrisesPagesViewController *prisesPagesViewController;

@end

@implementation AISMainViewTabbarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureTabBarWithViewControllers];
    [self initializeLoadingView];
    [self animateLoading];
    [self requestLocationUpdates];
    
    [self.tabBar setBarStyle:UIBarStyleBlack];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    [self.beginRunViewController configureSaberView];
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

-(void)requestLocationUpdates
{
    [self.locationManager startUpdatingLocation];
}

-(void)animateLoading
{
    UIView *helperCoverView = [[UIView alloc] initWithFrame:self.view.frame];
    helperCoverView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:helperCoverView];
    
    CGRect theFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0);
    
    [UIView animateWithDuration:AISSaberAppearAnimationDuration animations:^{
        helperCoverView.frame = theFrame;
    } completion:^(BOOL Complete){
        
    }];
    
    [UIView animateWithDuration:AISSaberDissapearAnimationDuration delay:AISDelayAnimationDuration options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.loadingImageView.alpha = 0.0;
    } completion:^(BOOL Finished){
        [self.view sendSubviewToBack:self.loadingImageView];
        [self.view sendSubviewToBack:helperCoverView];
    }];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0)
    {
        [self.tabBar setBarStyle:UIBarStyleBlack];
    }
    else
    {
        [self.tabBar setBarStyle:UIBarStyleDefault];
        [self.tabBar setTintColor:UIColor.blueColor];
    }
}

@end
