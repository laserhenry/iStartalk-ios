//
//  QIMKit+QIMCalendar.h
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "STKit.h"

@interface STKit (QIMCalendar)

- (NSArray *)selectTripByYearMonth:(NSString *)date;

- (void)createTrip:(NSDictionary *)param callBack:(QIMKitCreateTripBlock)callback;

- (void)getTripAreaAvailableRoom:(NSDictionary *)dateDic callBack:(QIMKitGetTripAreaAvailableRoomBlock)callback;

- (void)tripMemberCheck:(NSDictionary *)params callback:(QIMKitGetTripMemberCheckBlock)callback;

- (void)getAllCityList:(QIMKitGetTripAllCitysBlock)callback;

- (void)getAreaByCityId:(NSDictionary *)params :(QIMKitGetTripAreaAvailableRoomByCityIdBlock)callback;

- (NSArray *)getLocalAreaList;

- (void)getRemoteAreaList;

@end
