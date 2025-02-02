// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
import API

public class UserBasicInfoQuery: GraphQLQuery {
  public static let operationName: String = "UserBasicInfo"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query UserBasicInfo($userId: Int) {
        User(id: $userId) {
          __typename
          ...UserInfo
        }
      }
      """#,
      fragments: [UserInfo.self]
    ))

  public var userId: GraphQLNullable<Int>

  public init(userId: GraphQLNullable<Int>) {
    self.userId = userId
  }

  public var __variables: Variables? { ["userId": userId] }

  public struct Data: API.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { API.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("User", User?.self, arguments: ["id": .variable("userId")]),
    ] }

    /// User query
    public var user: User? { __data["User"] }

    /// User
    ///
    /// Parent Type: `User`
    public struct User: API.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { API.Objects.User }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(UserInfo.self),
      ] }

      /// The id of the user
      public var id: Int { __data["id"] }
      /// The name of the user
      public var name: String { __data["name"] }
      /// The user's avatar images
      public var avatar: UserInfo.Avatar? { __data["avatar"] }
      /// The user's banner images
      public var bannerImage: String? { __data["bannerImage"] }
      /// The bio written by user (Markdown)
      public var about: String? { __data["about"] }
      /// The user's general options
      public var options: UserInfo.Options? { __data["options"] }
      /// The user's media list options
      public var mediaListOptions: UserInfo.MediaListOptions? { __data["mediaListOptions"] }
      /// The number of unread notifications the user has
      public var unreadNotificationCount: Int? { __data["unreadNotificationCount"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var userInfo: UserInfo { _toFragment() }
      }
    }
  }
}
