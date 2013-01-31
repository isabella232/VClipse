/*******************************************************************************
 * Copyright (c) 2010 - 2013 webXcerpt Software GmbH.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *  
 * Contributors:
 *     	webXcerpt Software GmbH - initial creator
 * 		www.webxcerpt.com
 ******************************************************************************/
package org.vclipse.idoc2jcoidoc.internal;

import org.eclipse.jface.preference.FieldEditorPreferencePage;
import org.eclipse.jface.preference.IPreferenceStore;
import org.eclipse.jface.preference.StringFieldEditor;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.IWorkbenchPreferencePage;
import org.vclipse.idoc2jcoidoc.IUiConstants;

import com.google.inject.Inject;

/**
 * 
 */
public final class IDoc2JCoIDocPreferencePage extends FieldEditorPreferencePage implements IWorkbenchPreferencePage {

	/**
	 * 
	 */
	private final IPreferenceStore preferenceStore;
	
	/**
	 * @param preferenceStore
	 */
	@Inject
	public IDoc2JCoIDocPreferencePage(IPreferenceStore preferenceStore) {
		super(GRID);
		this.preferenceStore = preferenceStore;
	}
	
	/**
	 * @see org.eclipse.ui.IWorkbenchPreferencePage#init(org.eclipse.ui.IWorkbench)
	 */
	@Override
	public void init(final IWorkbench workbench) {
		setPreferenceStore(preferenceStore);
	}

	/**
	 * @see org.eclipse.jface.preference.FieldEditorPreferencePage#createFieldEditors()
	 */
	@Override
	protected void createFieldEditors() {
		addField(new StringFieldEditor(IUiConstants.PARTNER_TYPE, "Partner type: ", getFieldEditorParent()));
		addField(new StringFieldEditor(IUiConstants.PARTNER_NUMBER, "Partner number: ", getFieldEditorParent()));
		addField(new StringFieldEditor(IUiConstants.RFC_FOR_UPS_NUMBERS, "RFC to retrieve new UPS numbers: ", getFieldEditorParent()));
		addField(new StringFieldEditor(IUiConstants.RFC_FOR_IDOC_NUMBERS, "RFC to retrieve new IDoc numbers: ", getFieldEditorParent()));
	}
}
