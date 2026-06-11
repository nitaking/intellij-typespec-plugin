import "@typespec/http";

using TypeSpec.Http;

// ---------------------------------------------------------------------------
// Scalars — verify jump to IssueId, UserId, IsoTimestamp from usage sites
// ---------------------------------------------------------------------------

/** Numeric GitHub resource identifier. */
scalar IssueId extends int32;

/** Numeric GitHub user identifier. */
scalar UserId extends int32;

/** ISO 8601 UTC timestamp string. */
scalar IsoTimestamp extends string;

// ---------------------------------------------------------------------------
// Enums — verify jump to IssueState from Issue.state
// ---------------------------------------------------------------------------

/** Open/closed lifecycle state of an issue. */
enum IssueState {
  Open: "open",
  Closed: "closed",
}

// ---------------------------------------------------------------------------
// Models — verify jump to User, Label, Issue from property types and body params
// ---------------------------------------------------------------------------

/** GitHub user (author or assignee). */
model User {
  id: UserId;           // verify jump to UserId
  login: string;
  avatarUrl: string;
}

/** A label attached to an issue. */
model Label {
  id: int32;
  name: string;
  color: string;
}

/** A GitHub issue. */
model Issue {
  id: IssueId;              // verify jump to IssueId
  number: int32;
  title: string;
  state: IssueState;        // verify jump to IssueState
  body: string;
  user: User;               // verify jump to User
  labels: Label[];          // verify jump to Label
  createdAt: IsoTimestamp;  // verify jump to IsoTimestamp
  updatedAt: IsoTimestamp;
}

/** Request body for creating an issue. */
model CreateIssueRequest {
  title: string;
  body?: string;
  labels?: string[];
  assignees?: string[];
}

/** A comment on an issue. */
model IssueComment {
  id: int32;
  user: User;               // verify jump to User
  body: string;
  createdAt: IsoTimestamp;  // verify jump to IsoTimestamp
}

/** Request body for adding a comment. */
model CreateCommentRequest {
  body: string;
}

// ---------------------------------------------------------------------------
// API interface — verify jump to Issue, IssueId, CreateIssueRequest, IssueComment
// ---------------------------------------------------------------------------

@route("/repos/{owner}/{repo}/issues")
interface Issues {
  /** List issues for a repository. */
  @get
  list(
    @path owner: string,
    @path repo: string,
    @query state?: IssueState,       // verify jump to IssueState
  ): Issue[];                        // verify jump to Issue

  /** Get a single issue by number. */
  @get
  @route("/{issueNumber}")
  get(
    @path owner: string,
    @path repo: string,
    @path issueNumber: IssueId,      // verify jump to IssueId
  ): Issue;                          // verify jump to Issue

  /** Create a new issue. */
  @post
  create(
    @path owner: string,
    @path repo: string,
    @body body: CreateIssueRequest,  // verify jump to CreateIssueRequest
  ): Issue;                          // verify jump to Issue

  /** List comments on an issue. */
  @get
  @route("/{issueNumber}/comments")
  listComments(
    @path owner: string,
    @path repo: string,
    @path issueNumber: IssueId,      // verify jump to IssueId
  ): IssueComment[];                 // verify jump to IssueComment

  /** Add a comment to an issue. */
  @post
  @route("/{issueNumber}/comments")
  addComment(
    @path owner: string,
    @path repo: string,
    @path issueNumber: IssueId,         // verify jump to IssueId
    @body body: CreateCommentRequest,   // verify jump to CreateCommentRequest
  ): IssueComment;                      // verify jump to IssueComment
}
