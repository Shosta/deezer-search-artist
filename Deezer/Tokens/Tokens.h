//--------------------------------------------------------
// Rémi Lavedrine Corp
//--------------------------------------------------------
// Project     : Deezer
// File        : Tokens.h
// Created     : $ 19/01/2014 $
// Maintainer  : $ Rémi LAVEDRINE $
//
// Copyright Rémi Lavedrine 2004-2012, All Rights Reserved
//
// This software is the confidential and proprietary
// information of Rémi Lavedrine.
// You shall not disclose such Confidential Information
// and shall use it only in accordance with the terms
// of the license agreement you entered into with
// Rémi Lavedrine.
//--------------------------------------------------------
//
// @brief
// A class that contains all the tokens needed for the app in order to described it in one single location in the project.
// This class is imported in all project's classes through the "Deezer-Prefix.pch" file.
//

#import <Foundation/Foundation.h>
#import "BaseTokens.h"

@interface Tokens : NSObject

#pragma mark - Artist Dictionary Key

extern NSString *kArtistIdKey;
extern NSString *kArtistNameKey;
extern NSString *kArtistImageUrlKey;


#pragma mark - Album Dictionary Key

extern NSString *kAlbumIdKey;
extern NSString *kAlbumTitleKey;
extern NSString *kAlbumCoverKey;


#pragma mark - Track Dictionary Key

extern NSString *kTrackTitleKey;
extern NSString *kTrackPreviewKey;

@end
