// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
import API

public class ReviewDetailsQuery: GraphQLQuery {
  public static let operationName: String = "ReviewDetails"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query ReviewDetails($reviewId: Int) {
        Review(id: $reviewId) {
          __typename
          id
          body(asHtml: true)
          score
          rating
          ratingAmount
          user {
            __typename
            name
            avatar {
              __typename
              medium
            }
          }
        }
      }
      """#
    ))

  public var reviewId: GraphQLNullable<Int>

  public init(reviewId: GraphQLNullable<Int>) {
    self.reviewId = reviewId
  }

  public var __variables: Variables? { ["reviewId": reviewId] }

  public struct Data: API.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { API.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("Review", Review?.self, arguments: ["id": .variable("reviewId")]),
    ] }

    /// Review query
    public var review: Review? { __data["Review"] }

    /// Review
    ///
    /// Parent Type: `Review`
    public struct Review: API.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { API.Objects.Review }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("body", String?.self, arguments: ["asHtml": true]),
        .field("score", Int?.self),
        .field("rating", Int?.self),
        .field("ratingAmount", Int?.self),
        .field("user", User?.self),
      ] }

      /// The id of the review
      public var id: Int { __data["id"] }
      /// The main review body text
      public var body: String? { __data["body"] }
      /// The review score of the media
      public var score: Int? { __data["score"] }
      /// The total user rating of the review
      public var rating: Int? { __data["rating"] }
      /// The amount of user ratings of the review
      public var ratingAmount: Int? { __data["ratingAmount"] }
      /// The creator of the review
      public var user: User? { __data["user"] }

      /// Review.User
      ///
      /// Parent Type: `User`
      public struct User: API.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { API.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String.self),
          .field("avatar", Avatar?.self),
        ] }

        /// The name of the user
        public var name: String { __data["name"] }
        /// The user's avatar images
        public var avatar: Avatar? { __data["avatar"] }

        /// Review.User.Avatar
        ///
        /// Parent Type: `UserAvatar`
        public struct Avatar: API.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { API.Objects.UserAvatar }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("medium", String?.self),
          ] }

          /// The avatar of user at medium size
          public var medium: String? { __data["medium"] }
        }
      }
    }
  }
}
