//
//  Questions.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 26/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Options;

@interface Questions : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * inputtype;
@property (nonatomic, retain) NSString * labelTxt;
@property (nonatomic, retain) NSString * questionDesc;
@property (nonatomic, retain) NSString * questionType;
@property (nonatomic, retain) NSNumber * sequenceNumber;
@property (nonatomic, retain) NSString * hintText;
@property (nonatomic, retain) NSSet *options;
@end

@interface Questions (CoreDataGeneratedAccessors)

- (void)addOptionsObject:(Options *)value;
- (void)removeOptionsObject:(Options *)value;
- (void)addOptions:(NSSet *)values;
- (void)removeOptions:(NSSet *)values;

@end
