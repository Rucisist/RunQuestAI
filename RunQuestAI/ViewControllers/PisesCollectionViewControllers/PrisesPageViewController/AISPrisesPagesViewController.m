//
//  PrisesPagesViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 18.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISPrisesPagesViewController.h"
#import "AISPrisesCollectionViewController.h"
#import "AISStatsViewController.h"
#import "AISTypeOfPersonViewController.h"

@interface AISPrisesPagesViewController ()

@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, strong) AISTypeOfPersonViewController *typeOfPersonViewController;
@property (nonatomic, strong) AISPrisesCollectionViewController *prisesCollectionViewController;

@end

@implementation AISPrisesPagesViewController

@synthesize PageViewController,arrPageTitles,arrPageImages;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.index = 0;
    
    self.typeOfPersonViewController = [AISTypeOfPersonViewController new];
    self.prisesCollectionViewController = [AISPrisesCollectionViewController new];
    
    [self configurePageViewController];
    
    [self configureControllersArrayInPageViewController];
    
    [self configurePageControll];
}

#pragma mark - configureView

-(void)configurePageViewController
{
    self.PageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.PageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    self.PageViewController.dataSource = self;
    
    [self addChildViewController:PageViewController];
    [self.view addSubview:PageViewController.view];
    [self.PageViewController didMoveToParentViewController:self];
}

-(void)configureControllersArrayInPageViewController
{
    NSArray *viewControllers = @[self.prisesCollectionViewController];
    
    [self.PageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

-(void)configurePageControll
{
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[AISPrisesCollectionViewController class]])
    {
        return nil;
    }
    else
    {
        return [AISPrisesCollectionViewController new];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[AISTypeOfPersonViewController class]])
    {
        return nil;
    }
    else
    {
        return [AISTypeOfPersonViewController new];
    }
}

#pragma mark - configure the controllers stack

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
