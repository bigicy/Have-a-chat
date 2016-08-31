//
//  ApCollectionViewLayout.h
//  ApCollectionView
//
//  Created by wer_chen on 16/6/14.
//  Copyright © 2016年 wer_chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ApCollectionViewLayout;

@protocol ApFlowLayoutDelegate <NSObject>

//关键方法，此方法的作用是返回每一个item的size大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(ApCollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(ApCollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(ApCollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(ApCollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

@end

@interface ApCollectionViewLayout : UICollectionViewLayout

//瀑布流一共多少列
@property (nonatomic, assign) NSUInteger numberOfColumn;

// 代理⼈
@property (nonatomic, weak) id<ApFlowLayoutDelegate>delegate;

@end
