// Test file for LSP features (completion, hover, diagnostics)
// Requires typespec-language-server to be running

import "@typespec/http";

using TypeSpec.Http;

@service({
  title: "LSP Test",
  version: "0.1.0",
})
namespace LspTest;

// Completion test: type "@" and verify decorator candidates appear
// Hover test: place cursor on a type name and verify the tooltip appears
// Diagnostics test: introduce an intentional error and verify the red underline appears

scalar Uuid extends string;

@doc("A model representing a user")
model User {
  @doc("Unique identifier for the user")
  id: Uuid;

  @doc("Display name")
  @minLength(1)
  @maxLength(100)
  name: string;

  @doc("Email address")
  @format("email")
  email: string;

  @doc("Creation timestamp")
  createdAt: utcDateTime;
}

@route("/users")
@tag("Users")
interface Users {
  @summary("List users")
  @get list(
    @query skip?: int32,
    @query top?: int32,
  ): User[];

  @summary("Get a user")
  @get read(@path id: Uuid): User;

  @summary("Create a user")
  @post create(@body body: Omit<User, "id" | "createdAt">): User;
}
