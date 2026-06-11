package jp.s6n.idea.typespec.navigation

import com.intellij.codeInsight.navigation.actions.GotoDeclarationHandler
import com.intellij.openapi.editor.Editor
import com.intellij.openapi.fileEditor.FileDocumentManager
import com.intellij.openapi.vfs.LocalFileSystem
import com.intellij.psi.PsiElement
import com.intellij.psi.PsiManager
import jp.s6n.idea.typespec.lang.TypeSpecFileType
import jp.s6n.idea.typespec.lsp.LspServerUtil
import jp.s6n.idea.typespec.lsp.findServerForFile
import org.eclipse.lsp4j.DefinitionParams
import org.eclipse.lsp4j.Location
import org.eclipse.lsp4j.Position
import org.eclipse.lsp4j.TextDocumentIdentifier
import java.net.URI
import java.nio.file.Paths

class TypeSpecGotoDeclarationHandler : GotoDeclarationHandler {
    override fun getGotoDeclarationTargets(
        sourceElement: PsiElement?,
        offset: Int,
        editor: Editor?
    ): Array<PsiElement>? {
        val element = sourceElement ?: return null
        val file = element.containingFile?.virtualFile ?: return null
        if (!TypeSpecFileType.isMyFile(file)) return null

        val project = element.project
        val lspServer = LspServerUtil.getServerManager(project).findServerForFile(file) ?: return null

        val document = editor?.document ?: return null
        val line = document.getLineNumber(offset)
        val column = offset - document.getLineStartOffset(line)

        val params = DefinitionParams(
            TextDocumentIdentifier(lspServer.getDocumentIdentifier(file).uri),
            Position(line, column),
        )

        val response = lspServer.sendRequestSync { it.textDocumentService.definition(params) } ?: return null

        val locations = if (response.isLeft) {
            response.left
        } else {
            response.right?.map { link ->
                Location(link.targetUri, link.targetSelectionRange)
            }
        } ?: return null

        if (locations.isEmpty()) return null

        val psiManager = PsiManager.getInstance(project)
        return locations.mapNotNull { location ->
            val targetFile = LocalFileSystem.getInstance()
                .findFileByNioFile(Paths.get(URI(location.uri)))
                ?: return@mapNotNull null

            val targetPsiFile = psiManager.findFile(targetFile) ?: return@mapNotNull null
            val targetDoc = FileDocumentManager.getInstance().getDocument(targetFile)
                ?: return@mapNotNull null

            val startLine = location.range.start.line
            val startChar = location.range.start.character
            val targetOffset = if (startLine < targetDoc.lineCount) {
                targetDoc.getLineStartOffset(startLine) + startChar
            } else {
                0
            }

            targetPsiFile.findElementAt(targetOffset) ?: targetPsiFile
        }.toTypedArray().ifEmpty { null }
    }
}
