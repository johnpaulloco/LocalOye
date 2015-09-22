//
//  RateCard.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 10/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MajorSku;

@interface RateCard : NSManagedObject

@property (nonatomic, retain) NSNumber * minimum_order_value;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSSet *majorSkus;
@end

@interface RateCard (CoreDataGeneratedAccessors)

- (void)addMajorSkusObject:(MajorSku *)value;
- (void)removeMajorSkusObject:(MajorSku *)value;
- (void)addMajorSkus:(NSSet *)values;
- (void)removeMajorSkus:(NSSet *)values;

@end
