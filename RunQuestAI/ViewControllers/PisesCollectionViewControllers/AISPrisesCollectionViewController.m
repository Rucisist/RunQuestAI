//
//  PrisesCollectionViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 17.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISPrisesCollectionViewController.h"
#import "AISPrisesCollectionViewCell.h"
#import "AISPrisesDescription.h"

static const CGFloat AISitemSize = 150;
static const CGFloat AISMinimumLineSpacing = 20;
static const CGFloat AISMinimumInteritemSpacing = 20;
static const CGFloat AISCollectionItemCornerRadius = 20.0f;
static const double AISMetersInKM = 1000.0;
static NSString *AIScellIdentifier = @"AISprisesCollectionViewCell";


@interface AISPrisesCollectionViewController ()

@property (nonatomic, strong) NSNumber *allDistance;
@property (nonatomic, copy) NSArray *album;
@property (nonatomic, copy) NSArray *albumDescription;
@property (nonatomic, copy) NSArray *albumHelper;
@property (nonatomic, strong) AISPrisesDescription *prisesDescription;

@end

@implementation AISPrisesCollectionViewController

- (void)viewDidLoad
{
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

#pragma mark - configure cell

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

-(void)registerCellClass
{
    [self.collectionView registerClass:[AISPrisesCollectionViewCell class] forCellWithReuseIdentifier:AIScellIdentifier];
}

#pragma mark - display cells

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AISPrisesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AIScellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.albumDescription[indexPath.row];
    
    cell.contentView.layer.cornerRadius = AISCollectionItemCornerRadius;
    
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
