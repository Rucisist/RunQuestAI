//
//  AISLoadViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 20.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISLoadViewController.h"

@interface AISLoadViewController ()

@property (nonatomic, strong) UIImageView *loadingImageView;

@end

@implementation AISLoadViewController

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
        _loadingImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _loadingImageView.image = [UIImage imageNamed:@"redSaberInitialImage"];
        _loadingImageView.backgroundColor = [UIColor blackColor];
        _loadingImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_loadingImageView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    UIView *helperCoverView = [[UIView alloc] initWithFrame:self.view.frame];
    helperCoverView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:helperCoverView];
    
    CGRect theFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0);
    
    [UIView animateWithDuration:3.0 animations:^{
        helperCoverView.frame = theFrame;
    } completion:^(BOOL Complete){
        NSLog(@"complete");
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
