/*
* generated by Xtext
*/
package org.vclipse.tests.constraint;

import org.eclipse.xtext.junit4.IInjectorProvider;

import com.google.inject.Injector;

public class ConstraintUiInjectorProvider implements IInjectorProvider {
	
	public Injector getInjector() {
		return org.vclipse.constraint.ui.internal.ConstraintActivator.getInstance().getInjector("org.vclipse.constraint.Constraint");
	}
	
}
