//
//  TypeOfPersonViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 20.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISTypeOfPersonViewController.h"
#import "AISHelperForCharactersSW.h"
#import "AISCaharcterSW.h"

static const CGFloat AIScharacterDescriptionLabelXoffset = 0;
static const CGFloat AIScharacterDescriptionLabelYoffset = 30;
static const CGFloat AIScharacterDescriptionLabelHeight = 100;
static const CGFloat AIStextSize = 32;
static const CGFloat AIScharacterDescriptionLabelNumberOfLines = 0;

@interface AISTypeOfPersonViewController ()

@property (nonatomic, strong) UIImageView *characterImageView;
@property (nonatomic, strong) UILabel *characterDescriptionLabel;
@property (nonatomic, strong) AISCaharcterSW *character;

@end

@implementation AISTypeOfPersonViewController

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

-(void)viewWillAppear:(BOOL)animated
{
    double allDistance = [self allDistanceUserDefaultsResults];
    
    AISHelperForCharactersSW *characterHelper = [AISHelperForCharactersSW new];
    self.character = [characterHelper charactersForDistance:allDistance];

    [self configureUI];
}

-(void)configureUI
{
    [self configureCharacterDescriptionLabel];
    [self configureCharacterImageView];
}

-(void)configureCharacterDescriptionLabel
{
    self.characterDescriptionLabel.text = self.character.characterDescription;
    self.characterDescriptionLabel.frame = CGRectMake(AIScharacterDescriptionLabelXoffset, AIScharacterDescriptionLabelYoffset, CGRectGetWidth(self.view.frame), AIScharacterDescriptionLabelHeight);
    
    self.characterDescriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:AIStextSize];
    
    self.characterDescriptionLabel.numberOfLines = AIScharacterDescriptionLabelNumberOfLines;
    
    self.characterDescriptionLabel.textColor = [UIColor blackColor];
    self.characterDescriptionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.characterDescriptionLabel];
}

-(void)configureCharacterImageView
{
    self.characterImageView.frame = self.view.frame;
    self.characterImageView.image = self.character.characterImage;
    self.characterImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.characterImageView];
}

-(double)allDistanceUserDefaultsResults
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    double allDistance = [userDefaults doubleForKey:@"allDistance"];
    
    return allDistance;
}

@end
