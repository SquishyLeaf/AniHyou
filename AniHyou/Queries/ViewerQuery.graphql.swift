// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
import API

public class ViewerQuery: GraphQLQuery {
  public static let operationName: String = "Viewer"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      query Viewer {
        Viewer {
          __typename
          ...UserInfo
        }
      }
      """,
      fragments: [UserInfo.self]
    ))

  public init() {}

  public struct Data: API.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { API.Objects.Query }
    public static var __selections: [Selection] { [
      .field("Viewer", Viewer?.self),
    ] }

    /// Get the currently authenticated user
    public var viewer: Viewer? { __data["Viewer"] }

    /// Viewer
    ///
    /// Parent Type: `User`
    public struct Viewer: API.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { API.Objects.User }
      public static var __selections: [Selection] { [
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

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public var userInfo: UserInfo { _toFragment() }
      }
    }
  }
}
