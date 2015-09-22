//
//  MyOrder.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 10/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Quotes;

@interface MyOrder : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * category_icon;
@property (nonatomic, retain) NSString * category_type;
@property (nonatomic, retain) NSString * created_at;
@property (nonatomic, retain) NSNumber * booking_id;
@property (nonatomic, retain) NSNumber * no_of_quotes;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * status_text;
@property (nonatomic, retain) NSSet *quotes;
@end

@interface MyOrder (CoreDataGeneratedAccessors)

- (void)addQuotesObject:(Quotes *)value;
- (void)removeQuotesObject:(Quotes *)value;
- (void)addQuotes:(NSSet *)values;
- (void)removeQuotes:(NSSet *)values;

@end
