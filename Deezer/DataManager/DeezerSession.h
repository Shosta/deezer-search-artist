//--------------------------------------------------------
// Rémi Lavedrine Corp
//--------------------------------------------------------
// Project     : Deezer
// File        : DeezerSession.h
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
// Singleton class that describing the objects tree which describes all the Objects needed to fill the UI.
//

#import <Foundation/Foundation.h>

//! @brief Singleton class that describing the objects tree which describes all the Objects needed to fill the UI.
//! @class AppData
//! @ingroup DataManager
//! @author Rémi Lavedrine
@interface DeezerSession : NSObject

typedef void(^SearchActionCompletionBlock)(NSURLResponse *response, NSData *data, NSError *connectionError);


#pragma mark - Public methods
+ (DeezerSession *)sharedInstance;

#pragma mark - Search Artist
//! @brief Search all the album for an given artist id.
//! @param[in] artistName : The Artist name we will search for.
//! @param[in] completionHandler : The completion handler that will handle the reponse of the NSURLRequest.
- (void)searchAsynchronouslyArtist:(NSString *)artistName
                 completionHandler:(SearchActionCompletionBlock)completionHandler;

#pragma mark - Search Artist Album
//! @brief Search all the album for an given artist id.
//! @param[in] artistId : The Artist id we want to retrieve the albums.
//! @param[in] completionHandler : The completion handler that will handle the reponse of the NSURLRequest
- (void)searchAsynchronouslyArtistAlbum:(NSString *)artistId
                      completionHandler:(SearchActionCompletionBlock)completionHandler;

#pragma mark - Search Album Tracks
//! @brief Search all the album for an given artist id.
//! @param[in] albumId : The Album id we want to retrieve the tracks.
//! @param[in] completionHandler : The completion handler that will handle the reponse of the NSURLRequest
- (void)searchAsynchronouslyAlbumTracks:(NSString *)albumId
                      completionHandler:(SearchActionCompletionBlock)completionHandler;

@end
