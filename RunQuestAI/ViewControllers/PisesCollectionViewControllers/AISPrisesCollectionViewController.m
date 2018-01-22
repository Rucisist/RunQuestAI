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

@interface AISPrisesCollectionViewController ()

@property (nonatomic, strong) NSNumber *allDistance;

@end

@implementation AISPrisesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.album = @[@"alliance",@"GELogo",@"runbuttonImage",@"SWLogo"];
    self.albumDescription = @[@"пробежать 1 км", @"пробежать 10 км", @"пробежать 50 км", @"пробежать 100 км"];
    self.albumHelper = @[@1, @10, @50, @100];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(150, 150);
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 20;

    [layout setFooterReferenceSize:CGSizeMake(100, 50)];
    [layout setHeaderReferenceSize:CGSizeMake(150, 25)];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame    collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[AISPrisesCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    [self.collectionView registerClass:[AISPrisesCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self.collectionView registerClass:[AISPrisesCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.collectionView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.allDistance = [NSNumber numberWithDouble:[userDefaults doubleForKey:@"allDistance"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AISPrisesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.textLabel.text = self.albumDescription[indexPath.row];
    
    cell.contentView.layer.cornerRadius = 20.0f;
    
    cell.contentView.layer.masksToBounds = YES;
    
    if (self.allDistance.doubleValue / 1000 >= [self.albumHelper[indexPath.row] doubleValue])
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
