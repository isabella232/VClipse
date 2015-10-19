/** 
 * Copyright (c) 2010 - 2015 webXcerpt Software GmbH.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * Contributors:
 * webXcerpt Software GmbH - initial creator
 * www.webxcerpt.com
 */
package org.vclipse.idoc.conversion

import org.eclipse.xtext.common.services.DefaultTerminalConverters
import org.eclipse.xtext.conversion.IValueConverter
import org.eclipse.xtext.conversion.ValueConverter
import org.eclipse.xtext.conversion.ValueConverterException
import org.eclipse.xtext.conversion.impl.AbstractNullSafeConverter
import org.eclipse.xtext.nodemodel.INode
import org.vclipse.base.VClipseStrings

class IDocValueConverter extends DefaultTerminalConverters {
	// uses own Strings implementation to avoid \\u conversion of unicode characters
	// see https://bugs.eclipse.org/bugs/show_bug.cgi?id=289613 for this issue
	@ValueConverter(rule="STRING") override IValueConverter<String> STRING() {
		return new AbstractNullSafeConverter<String>() {
			override protected String internalToValue(String string, INode node) throws ValueConverterException {
				return VClipseStrings.convertFromJavaString(string.substring(1, string.length() - 1))
			}

			override protected String internalToString(String value) {
				return Character.valueOf('"').charValue + VClipseStrings.convertToJavaString(value) +
					Character.valueOf('"').charValue
			}
		}
	}

}
