/*******************************************************************************
 * Copyright (c) 2016 TypeFox GmbH (http://www.typefox.io) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtend.ide.highlighting

import org.eclipse.xtend.ide.common.highlighting.XtendHighlightingStyles
import org.eclipse.xtext.ide.editor.syntaxcoloring.HighlightingStyles
import org.eclipse.xtext.ui.editor.syntaxcoloring.SyntaxColoringPreferencePage
import org.eclipse.xtext.ui.editor.utils.TextStyle
import org.eclipse.xtext.xbase.ide.highlighting.XbaseHighlightingStyles

/**
 * @author Christian Schneider - Initial contribution and API
 */
class XtendSyntaxColoringPreferencePage extends SyntaxColoringPreferencePage {
	
	/**
	 * Polishes the names of the inherited coloring profiles shown in the preference page.
	 */
	override acceptDefaultHighlighting(String id, String name, TextStyle style) {
		switch (id) {
			case XtendHighlightingStyles.INVALID_TOKEN_ID,
			case XtendHighlightingStyles.SEMANTIC_LINE_BREAK,
			case XtendHighlightingStyles.POTENTIAL_LINE_BREAK,
			case HighlightingStyles.COMMENT_ID:
				return
			case HighlightingStyles.KEYWORD_ID:
				super.acceptDefaultHighlighting(id, "Keywords", style)
			case HighlightingStyles.NUMBER_ID:
				super.acceptDefaultHighlighting(id, "Numbers", style)
			case HighlightingStyles.STRING_ID:
				super.acceptDefaultHighlighting(id, "Strings", style)
			case HighlightingStyles.PUNCTUATION_ID:
				super.acceptDefaultHighlighting(id, "Punctuation Characters", style)
			case HighlightingStyles.TASK_ID:
				super.acceptDefaultHighlighting(id, "Task Tags", style)
			case HighlightingStyles.DEFAULT_ID:
				super.acceptDefaultHighlighting(id, "Others", style)
			case XbaseHighlightingStyles.LOCAL_VARIABLE,
			case XbaseHighlightingStyles.LOCAL_VARIABLE_DECLARATION:
				super.acceptDefaultHighlighting(id, name + " (var)", style)
			case XbaseHighlightingStyles.LOCAL_FINAL_VARIABLE,
			case XbaseHighlightingStyles.LOCAL_FINAL_VARIABLE_DECLARATION:
				super.acceptDefaultHighlighting(id, name + " (val)", style)
			default: 
				super.acceptDefaultHighlighting(id, name, style)
		}
	}
}