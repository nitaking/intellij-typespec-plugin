# Examples

Sample TypeSpec files for verifying plugin features.

## Files

| File | Feature |
|------|---------|
| `basic.tsp` | Syntax highlighting, basic TypeSpec syntax |
| `navigation.tsp` | Go to Declaration — single-file baseline (Cmd+Click / Ctrl+Click) |
| `folding.tsp` | Code folding (namespace / model / interface blocks) |
| `structure.tsp` | Structure View (file outline) |
| `lsp.tsp` | LSP features (completion, hover, diagnostics, `@doc`) |

### Cross-file navigation (`github/`)

A multi-file GitHub Issues API example for testing Go to Declaration across files.

| File | Responsibility |
|------|---------------|
| `github/common.tsp` | Scalars and enums (jump targets from both other files) |
| `github/models.tsp` | Domain models and request bodies (imports `common.tsp`) |
| `github/navigation.tsp` | HTTP interface — all symbol references are cross-file jumps |

## Prerequisites

LSP features (`lsp.tsp`) require `@typespec/compiler` to be installed:

```bash
npm install
```

## Usage

1. Build and launch the plugin: `mise run run`
2. Open the `examples/` directory as a project
3. Open each file and verify the corresponding feature
