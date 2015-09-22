//
//  QuestionRateCard+CoreDataProperties.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 20/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "QuestionRateCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuestionRateCard (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *added_cart;
@property (nullable, nonatomic, retain) NSString *category;
@property (nullable, nonatomic, retain) NSString *descriptionStr;
@property (nullable, nonatomic, retain) NSString *major_sku_name;
@property (nullable, nonatomic, retain) NSString *minor_sku_name;
@property (nullable, nonatomic, retain) NSNumber *sku_id;
@property (nullable, nonatomic, retain) NSString *sku_img;
@property (nullable, nonatomic, retain) NSString *sku_name;
@property (nullable, nonatomic, retain) NSString *sku_price;
@property (nullable, nonatomic, retain) NSString *sku_price_type;
@property (nullable, nonatomic, retain) NSString *sku_unit_type;
@property (nullable, nonatomic, retain) NSNumber *minimum_order_value;

@end

NS_ASSUME_NONNULL_END
