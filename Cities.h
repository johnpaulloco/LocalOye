//
//  Cities.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 10/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Cities : NSManagedObject

@property (nonatomic, retain) NSString * citiID;
@property (nonatomic, retain) NSString * citiName;

@end
