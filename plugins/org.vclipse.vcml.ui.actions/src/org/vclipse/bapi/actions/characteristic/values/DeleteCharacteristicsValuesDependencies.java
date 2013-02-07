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
package org.vclipse.bapi.actions.characteristic.values;

import java.util.Map;

import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.SubMonitor;
import org.vclipse.bapi.actions.BAPIException;
import org.vclipse.bapi.actions.IBAPIActionRunnerExtension;
import org.vclipse.bapi.actions.JCoFunctionPerformer;
import org.vclipse.bapi.actions.handler.BAPIActionHandler;
import org.vclipse.vcml.vcml.Characteristic;
import org.vclipse.vcml.vcml.VCObject;
import org.vclipse.vcml.vcml.VcmlModel;

import com.google.inject.Inject;

/**
 *
 */
public class DeleteCharacteristicsValuesDependencies extends BAPIActionHandler implements IBAPIActionRunnerExtension<Characteristic>  {

	@Inject
	private CreateChangeCharacteristicsValuesDependencies createChangeValuesDependencies;
	
	@Inject
	private JCoFunctionPerformer functionPerformer;
	
	public void run(Characteristic cstic, VcmlModel vcmlModel, IProgressMonitor monitor, Map<String, VCObject> seenObjects) throws Exception {
		if(monitor.isCanceled()) {
			monitor.done();
			throw new BAPIException("Action \"Delete dependencies\" for a characteristic was canceled by the user.");
		}
		IProgressMonitor submonitor = SubMonitor.convert(monitor, "Delete dependencies for cstic " + cstic.getName(), IProgressMonitor.UNKNOWN);
		functionPerformer.beginTransaction();
		functionPerformer.CAMA_CHAR_VAL_DEL_DEP(cstic, monitor, vcmlModel.getOptions(), cstic.getOptions());
		functionPerformer.endTransaction();
		submonitor.done();
	}

	public boolean enabled(Characteristic cstic) {
		return createChangeValuesDependencies.enabled(cstic);
	}
}
