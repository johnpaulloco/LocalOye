//
//  Skus.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 10/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Skus : NSManagedObject

@property (nonatomic, retain) NSString * skuName;
@property (nonatomic, retain) NSString * descriptionStr;
@property (nonatomic, retain) NSNumber * skuID;
@property (nonatomic, retain) NSString * skuImg;
@property (nonatomic, retain) NSString * skuPriceType;
@property (nonatomic, retain) NSString * skuPrice;
@property (nonatomic, retain) NSString * skuUnitType;

@end
