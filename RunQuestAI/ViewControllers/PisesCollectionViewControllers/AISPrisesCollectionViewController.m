//
//  PrisesCollectionViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 17.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISPrisesCollectionViewController.h"
#import "AISPrisesCollectionReusableView.h"
#import "AISPrisesCollectionViewCell.h"
#import "AISPrisesDescription.h"

static CGFloat AISitemSize = 150;
static CGFloat AISMinimumLineSpacing = 20;
static CGFloat AISMinimumInteritemSpacing = 20;
static double AISMetersInKM = 1000;

@interface AISPrisesCollectionViewController ()

@property (nonatomic, strong) NSNumber *allDistance;

@property (nonatomic, copy) NSArray *album;
@property (nonatomic, copy) NSArray *albumDescription;
@property (nonatomic, copy) NSArray *albumHelper;

@property (nonatomic, strong) AISPrisesDescription *prisesDescription;

@end

@implementation AISPrisesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.prisesDescription = [AISPrisesDescription new];
    
    self.album = self.prisesDescription.album;
    self.albumDescription = self.prisesDescription.albumDescription;
    self.albumHelper = self.prisesDescription.albumHelper;
    
    [self configureCells];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.allDistance = [NSNumber numberWithDouble:[userDefaults doubleForKey:@"allDistance"]];
}

-(void)registerCellClass
{
    [self.collectionView registerClass:[AISPrisesCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
}

-(void)configureCells
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(AISitemSize, AISitemSize);
    layout.minimumLineSpacing = AISMinimumLineSpacing;
    layout.minimumInteritemSpacing = AISMinimumInteritemSpacing;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame    collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.collectionView];
    
    [self registerCellClass];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AISPrisesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.textLabel.text = self.albumDescription[indexPath.row];
    
    cell.contentView.layer.cornerRadius = 20.0f;
    
    cell.contentView.layer.masksToBounds = YES;
    
    if (self.allDistance.doubleValue / AISMetersInKM >= [self.albumHelper[indexPath.row] doubleValue])
    {
        cell.priseImage.alpha = 1.0;
    }
    
    cell.priseImage.image = [UIImage imageNamed:[self.album objectAtIndex:indexPath.row]];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.album.count;
}


@end
