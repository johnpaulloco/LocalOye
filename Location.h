//
//  Location.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 19/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * locationStr;
@property (nonatomic, retain) NSString * categoryService;

@end
