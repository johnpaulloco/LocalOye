//
//  Quotes.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 31/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Quotes : NSManagedObject

@property (nonatomic, retain) NSNumber * lead_id;
@property (nonatomic, retain) NSNumber * merchant_id;
@property (nonatomic, retain) NSString * merchant_image;
@property (nonatomic, retain) NSString * merchant_name;

@end
