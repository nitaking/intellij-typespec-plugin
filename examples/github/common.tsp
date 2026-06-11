import "@typespec/http";

using TypeSpec.Http;

// ---------------------------------------------------------------------------
// Scalars
// Jump here from: models.tsp (Issue.id, User.id, Issue.createdAt, etc.)
//                 navigation.tsp (route params)
// ---------------------------------------------------------------------------

/** Numeric GitHub issue identifier. */
scalar IssueId extends int32;

/** Numeric GitHub user identifier. */
scalar UserId extends int32;

/** ISO 8601 UTC timestamp string. */
scalar IsoTimestamp extends string;

// ---------------------------------------------------------------------------
// Enums
// Jump here from: models.tsp (Issue.state)
//                 navigation.tsp (list query param)
// ---------------------------------------------------------------------------

/** Open/closed lifecycle state of an issue. */
enum IssueState {
  Open: "open",
  Closed: "closed",
}
