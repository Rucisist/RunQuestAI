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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 0;
    
    self.typeOfPersonViewController = [AISTypeOfPersonViewController new];
    self.prisesCollectionViewController = [AISPrisesCollectionViewController new];
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    self.PageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.PageViewController.dataSource = self;
    
    NSArray *viewControllers = @[self.prisesCollectionViewController];
    
    [self.PageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.PageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:PageViewController];
    [self.view addSubview:PageViewController.view];
    [self.PageViewController didMoveToParentViewController:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Other Methods

#pragma mark - No of Pages Methods
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
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
