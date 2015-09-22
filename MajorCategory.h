//
//  MajorCategory.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 07/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ChildCategory;

@interface MajorCategory : NSManagedObject

@property (nonatomic, retain) NSString * banner;
@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * slug;
@property (nonatomic, retain) NSSet *childCategory;
@end

@interface MajorCategory (CoreDataGeneratedAccessors)

- (void)addChildCategoryObject:(ChildCategory *)value;
- (void)removeChildCategoryObject:(ChildCategory *)value;
- (void)addChildCategory:(NSSet *)values;
- (void)removeChildCategory:(NSSet *)values;

@end
