//
//  ChildCategory.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 07/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ChildCategory : NSManagedObject

@property (nonatomic, retain) NSString * cat_type;
@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * slug;
@property (nonatomic, retain) NSString * landing_content;
@property (nonatomic, retain) NSString * landing_header;
@property (nonatomic, retain) NSString * banner;

@end
