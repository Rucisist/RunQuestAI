//
//  TypeOfPersonViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 20.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "TypeOfPersonViewController.h"
#import "AISHelperForCharactersSW.h"
#import "AISCaharcterSW.h"

@interface TypeOfPersonViewController ()

@property (nonatomic, strong) UIImageView *characterImageView;
@property (nonatomic, strong) UILabel *characterDescriptionLabel;

@end

@implementation TypeOfPersonViewController

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _characterImageView = [UIImageView new];
        _characterDescriptionLabel = [UILabel new];
        self.view.backgroundColor = [UIColor whiteColor];
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

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    double allDistance = [userDefaults doubleForKey:@"allDistance"];
    
    AISHelperForCharactersSW *characterHelper = [AISHelperForCharactersSW new];
    AISCaharcterSW *character = [characterHelper charactersForDistance:allDistance];
    
    self.characterImageView.frame = self.view.frame;
    self.characterImageView.image = character.characterImage;
    self.characterImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.characterImageView];
    
    self.characterDescriptionLabel.text = character.characterDescription;
    self.characterDescriptionLabel.frame = CGRectMake(0, 30, CGRectGetWidth(self.view.frame), 100);
    self.characterDescriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:32];
    self.characterDescriptionLabel.numberOfLines = 0;
    self.characterDescriptionLabel.textColor = [UIColor blackColor];
    self.characterDescriptionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.characterDescriptionLabel];
    
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
