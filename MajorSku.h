//
//  MajorSku.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 10/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MinorSku;

@interface MajorSku : NSManagedObject

@property (nonatomic, retain) NSString * majorSkuName;
@property (nonatomic, retain) NSSet *minorSku;
@end

@interface MajorSku (CoreDataGeneratedAccessors)

- (void)addMinorSkuObject:(MinorSku *)value;
- (void)removeMinorSkuObject:(MinorSku *)value;
- (void)addMinorSku:(NSSet *)values;
- (void)removeMinorSku:(NSSet *)values;

@end
