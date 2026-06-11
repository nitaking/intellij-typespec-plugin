import "@typespec/http";
import "./common.tsp";
import "./models.tsp";

using TypeSpec.Http;

// ---------------------------------------------------------------------------
// HTTP interface
//
// Every symbol reference below is a cross-file jump. Use Cmd+Click on any
// highlighted type to verify Go to Declaration navigates to the correct file.
// ---------------------------------------------------------------------------

@route("/repos/{owner}/{repo}/issues")
interface Issues {
  /** List open or closed issues for a repository. */
  @get
  list(
    @path owner: string,
    @path repo: string,
    @query state?: IssueState,      // verify jump to IssueState in common.tsp
  ): Issue[];                       // verify jump to Issue in models.tsp

  /** Fetch a single issue by its number. */
  @get
  @route("/{issueNumber}")
  get(
    @path owner: string,
    @path repo: string,
    @path issueNumber: IssueId,     // verify jump to IssueId in common.tsp
  ): Issue;                         // verify jump to Issue in models.tsp

  /** Open a new issue. */
  @post
  create(
    @path owner: string,
    @path repo: string,
    @body body: CreateIssueRequest, // verify jump to CreateIssueRequest in models.tsp
  ): Issue;                         // verify jump to Issue in models.tsp

  /** List all comments on an issue. */
  @get
  @route("/{issueNumber}/comments")
  listComments(
    @path owner: string,
    @path repo: string,
    @path issueNumber: IssueId,     // verify jump to IssueId in common.tsp
  ): IssueComment[];                // verify jump to IssueComment in models.tsp

  /** Post a new comment on an issue. */
  @post
  @route("/{issueNumber}/comments")
  addComment(
    @path owner: string,
    @path repo: string,
    @path issueNumber: IssueId,          // verify jump to IssueId in common.tsp
    @body body: CreateCommentRequest,    // verify jump to CreateCommentRequest in models.tsp
  ): IssueComment;                       // verify jump to IssueComment in models.tsp
}
