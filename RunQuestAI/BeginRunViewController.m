//
//  BeginRunViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 14.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "BeginRunViewController.h"
#import "AILModelForFirstController.h"

static CGFloat startRunButtonDiameter = 50;

@interface BeginRunViewController ()

@property (nonatomic, strong) UIButton *startRunButton;
@property (nonatomic, strong) AILModelForFirstController *model;

@end

@implementation BeginRunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [AILModelForFirstController new];
    [self configureUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureUI
{
    self.view.backgroundColor = [UIColor blackColor];
    
    CGRect screenFrame = self.view.frame;
    CGFloat frameWidth = CGRectGetWidth(screenFrame);
    CGFloat frameHeight = CGRectGetHeight(screenFrame);
    
    CGRect startButtonFrame = CGRectMake(frameWidth / 2 - startRunButtonDiameter / 2, frameHeight - 100, startRunButtonDiameter, startRunButtonDiameter);
    self.startRunButton = [[UIButton alloc] initWithFrame:startButtonFrame];
    
    self.startRunButton.backgroundColor = [UIColor redColor];
    
    [self.startRunButton setTitle:@"run!" forState:UIControlStateNormal];
    [self.startRunButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:self.startRunButton];
    [self.startRunButton addTarget:self action:@selector(changeBackgroundColor) forControlEvents:UIControlEventTouchUpInside];

    
}

-(void)changeBackgroundColor
{
    self.view.backgroundColor = [UIColor whiteColor];
    //[self.model backgroundColorChange:self.view toColor:[UIColor whiteColor]];
    //[self.model.viewController colorUpdate];
}

-(void)colorUpdate
{
    NSLog(@"motherfucker");
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
