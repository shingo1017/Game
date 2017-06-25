/*!
 @header Place.h
 @abstract 地点实体类
 @author 尹楠
 @version 1.00 2014/05/13 创建
 */

#import <Foundation/Foundation.h>

#define k_myPlaceId                     @"myPlaceId"
#define k_landArea                      @"landArea"
#define k_buildingArea                  @"buildingArea"
#define k_defence                       @"defence"
#define k_trap                          @"trap"
#define k_zombieInside                  @"zombieInside"
#define k_zombieOutside                 @"zombieOutside"
#define k_peace                         @"peace"
#define k_food                          @"food"
#define k_water                         @"water"
#define k_medicine                      @"medicine"
#define k_material                      @"material"
#define k_ammunition                    @"ammunition"
#define k_nattiness                     @"nattiness"
#define k_sanitation                    @"sanitation"
#define k_isBuilding                    @"isBuilding"
#define k_isFief                        @"isFief"
#define k_isLead                        @"isLead"
#define k_searched                      @"searched"

/*!
 @class
 @abstract 地点实体类。
*/
@interface Place : Entity

@property (nonatomic, strong) NSArray *survivors;
@property (nonatomic, assign) NSInteger numberOfWorkingSurvivors;

+ (CGFloat)burdenOfFood:(NSInteger)food;
+ (NSInteger)foodOfBurden:(CGFloat)burden;
+ (CGFloat)burdenOfWater:(NSInteger)water;
+ (NSInteger)waterOfBurden:(CGFloat)burden;
+ (CGFloat)burdenOfMedicine:(NSInteger)medicine;
+ (NSInteger)medicineOfBurden:(CGFloat)burden;
+ (CGFloat)burdenOfAmmunition:(NSInteger)ammunition;
+ (NSInteger)ammunitionOfBurden:(CGFloat)burden;
+ (CGFloat)burdenOfMaterial:(NSInteger)material;
+ (NSInteger)materialOfBurden:(CGFloat)burden;

- (CGFloat)resourceBurden;
- (CGFloat)survivorsBurden;

- (NSInteger)numberOfSurvivorsWorkingOnExcutiveClassName:(NSString *)excutiveClassName;

@end
