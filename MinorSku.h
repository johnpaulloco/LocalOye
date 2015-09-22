//
//  MinorSku.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 10/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Skus;

@interface MinorSku : NSManagedObject

@property (nonatomic, retain) NSString * minorSkuName;
@property (nonatomic, retain) NSSet *skus;
@end

@interface MinorSku (CoreDataGeneratedAccessors)

- (void)addSkusObject:(Skus *)value;
- (void)removeSkusObject:(Skus *)value;
- (void)addSkus:(NSSet *)values;
- (void)removeSkus:(NSSet *)values;

@end
