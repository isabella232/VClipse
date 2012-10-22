package org.vclipse.vcml.ui.refactoring;

import java.util.Set;

import org.eclipse.emf.ecore.EClass;
import org.vclipse.refactoring.core.DefaultPreviewEObjectComputer;
import org.vclipse.vcml.vcml.VcmlPackage;

import com.google.common.collect.Sets;

public class PreviewEntityComputer extends DefaultPreviewEObjectComputer {

	protected static final VcmlPackage VCML_PACKAGE = VcmlPackage.eINSTANCE;

	@Override
	public Set<EClass> getTypes() {
		return Sets.newHashSet(VCML_PACKAGE.getVCObject());
	}
}
