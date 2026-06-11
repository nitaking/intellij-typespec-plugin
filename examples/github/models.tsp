import "@typespec/http";
import "./common.tsp";

using TypeSpec.Http;

// ---------------------------------------------------------------------------
// Base models
// Jump here from: navigation.tsp (route return types and body params)
// ---------------------------------------------------------------------------

/** GitHub user (author or assignee). */
model User {
  id: UserId;           // verify jump to UserId in common.tsp
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
  id: IssueId;              // verify jump to IssueId in common.tsp
  number: int32;
  title: string;
  state: IssueState;        // verify jump to IssueState in common.tsp
  body: string;
  user: User;               // verify jump to User (same file)
  labels: Label[];          // verify jump to Label (same file)
  createdAt: IsoTimestamp;  // verify jump to IsoTimestamp in common.tsp
  updatedAt: IsoTimestamp;
}

/** A comment posted on an issue. */
model IssueComment {
  id: int32;
  user: User;               // verify jump to User (same file)
  body: string;
  createdAt: IsoTimestamp;  // verify jump to IsoTimestamp in common.tsp
}

// ---------------------------------------------------------------------------
// Request bodies
// Jump here from: navigation.tsp (@body params)
// ---------------------------------------------------------------------------

/** Request body for creating a new issue. */
model CreateIssueRequest {
  title: string;
  body?: string;
  labels?: string[];
  assignees?: string[];
}

/** Request body for adding a comment to an issue. */
model CreateCommentRequest {
  body: string;
}
