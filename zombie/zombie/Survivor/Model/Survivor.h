/*!
 @header Survivor.h
 @abstract 幸存者实体类
 @author 尹楠
 @version 1.00 2014/05/13 创建
 */

#import <Foundation/Foundation.h>
//#import "BagItem.h"
//#import "Event.h"

#define k_avatar                        @"avatar"
#define k_gender                        @"gender"
#define k_age                           @"age"
#define k_maxHealth                     @"health_max"
#define k_health                        @"health"
#define k_maxStamina                    @"stamina_max"
#define k_stamina                       @"stamina"
#define k_prestige                      @"prestige"
#define k_status                        @"status"
#define k_combat                        @"combat"
#define k_shooting                      @"shooting"
#define k_survival                      @"survival"
#define k_logistics                     @"logistics"
#define k_courage                       @"courage"
#define k_strength                      @"strength"
#define k_agility                       @"agility"
#define k_strategy                      @"strategy"
#define k_eq                            @"eq"
#define k_goodness                      @"goodness"
#define k_hungry                        @"hungry"
#define k_thirsty                       @"thirsty"
#define k_burden                        @"burden"
#define k_excutiveClassName             @"excutiveClassName"

/*!
 @class
 @abstract 幸存者实体类。
*/
@interface Survivor : Entity

#pragma mark 构造方法

#pragma mark 成员方法

- (NSString *)genderText;
- (NSString *)statusText;
- (CGFloat) burden;

#pragma mark 指令方法

@end
