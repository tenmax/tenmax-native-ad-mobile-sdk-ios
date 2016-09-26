//
// Created by liq on 8/25/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import "CollectionViewController.h"
#import "OysterContentAdCell.h"

@interface CollectionViewController()<OysterContentAdLoaderDelegate>

@property (nonatomic, readwrite, strong) NSMutableArray* datas;
@property (nonatomic, readwrite, strong) NSMutableArray* adIndexs;
@end

@implementation CollectionViewController

- (void) viewDidLoad {
  [super viewDidLoad];

  [self.collectionView registerClass:[OysterContentAdCell class]
          forCellWithReuseIdentifier:NSStringFromClass([OysterContentAdCell class])];
  self.adIndexs = [NSMutableArray arrayWithArray:@[@(10), @(18)]];

  self.datas = [NSMutableArray array];
  for (int i = 0; i < 30; ++i) {
    [self.datas addObject:@(i)];
  }

  for (int j = 0; j < self.adIndexs.count; ++j) {
    [self requestAds];
  }

}

- (void) requestAds {
  NSMutableArray* adType = [NSMutableArray array];
  [adType addObject:kOysterAdLoaderAdTypeContent];

  OysterAdLoaderOptions* options = [[OysterAdLoaderOptions alloc] init];
  options.imageSize = MIDDLE;

  OysterAdLoader* adLoader = [[OysterAdLoader alloc]
      initWithAdUnitID:@"c145f1cd389e49a5" rootViewController:self adTypes:adType options:options];

  adLoader.delegate = self;
  [adLoader loadRequest];
}

- (NSInteger) collectionView:(UICollectionView*) collectionView numberOfItemsInSection:(NSInteger) section {
  return self.datas.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView*) collectionView
                  cellForItemAtIndexPath:(NSIndexPath*) indexPath {

  if ([self.datas[(NSUInteger) indexPath.row] isKindOfClass:[OysterContentAd class]]) {

    OysterContentAdCell* oysterContentAdCell = (OysterContentAdCell*) [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(
            [OysterContentAdCell class])
                                                                                                                forIndexPath:indexPath];
    OysterContentAd* oysterContentAd = (OysterContentAd*) self.datas[(NSUInteger) indexPath.row];
    oysterContentAdCell.oysterContentAdView.oysterContentAd = oysterContentAd;

    ((UILabel*) oysterContentAdCell.oysterContentAdView.headlineView).text = oysterContentAd.headline;
    ((UILabel*) oysterContentAdCell.oysterContentAdView.bodyView).text = oysterContentAd.headline;
    ((UILabel*) oysterContentAdCell.oysterContentAdView.advertiserView).text = oysterContentAd.advertiser;
    ((UIImageView*) oysterContentAdCell.oysterContentAdView.imageView).image = oysterContentAd.adImage.image;
    ((UIImageView*) oysterContentAdCell.oysterContentAdView.logoView).image = oysterContentAd.adLogo.image;

    return oysterContentAdCell;
  } else {
    static NSString* identifier = @"Cell";

    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                           forIndexPath:indexPath];
    UILabel* label = [cell viewWithTag:100];
    label.text = [NSString stringWithFormat:@"%@", self.datas[(NSUInteger) indexPath.row]];
    return cell;
  }

}

- (void) adLoader:(OysterAdLoader*) adLoader didReceiveNativeContentAd:(OysterContentAd*) nativeContentAd {
  if ([self.adIndexs count] > 0) {
    [self.datas insertObject:nativeContentAd atIndex:[self.adIndexs[0] unsignedIntegerValue]];
    [self.adIndexs removeObjectAtIndex:0];
    [self.collectionView reloadData];
  }
}

- (void) adLoader:(OysterAdLoader*) adLoader didFailToReceiveAdWithError:(NSError*) error {
  NSLog(@"%@ failed with error: %@", adLoader, [error localizedDescription]);
}

@end