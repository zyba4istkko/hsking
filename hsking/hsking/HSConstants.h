//
//  HSConstants.h
//  hsking
//
//  Created by Иван Труфанов on 24.03.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

@import Foundation;
@import UIKit;

//Blocks
typedef void (^ActionBlock)(BOOL success, NSError *err);
typedef void (^ArrayLoadingBlock)(BOOL success, NSArray *array, NSError *err);
typedef void (^ArrayPaginationLoadingBlock)(BOOL success, NSArray *array, BOOL canLoadMore, NSError *err);
typedef void (^DictionaryLoadingBlock)(BOOL success, NSDictionary *dictionary, NSError *err);

//URLs
#define apiURL @"http://betch.at/"