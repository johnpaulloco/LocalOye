//
//  QuotesList.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 17/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QuotesList : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * category_type;
@property (nonatomic, retain) NSNumber * lead_id;
@property (nonatomic, retain) NSNumber * merchant_id;
@property (nonatomic, retain) NSString * merchant_image;
@property (nonatomic, retain) NSString * merchant_name;
@property (nonatomic, retain) NSNumber * no_of_quotes;
@property (nonatomic, retain) NSString * quote_price;
@property (nonatomic, retain) NSString * requirement;
@property (nonatomic, retain) NSString * server_timestamp;
@property (nonatomic, retain) NSNumber * time_delta;

@end
