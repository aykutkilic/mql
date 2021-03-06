/*
 * generated by Xtext
 */
package org.eclipse.xtext.mqrepl.ui;

import org.eclipse.xtext.ui.guice.AbstractGuiceAwareExecutableExtensionFactory;
import org.osgi.framework.Bundle;

import com.google.inject.Injector;

import org.eclipse.xtext.mqrepl.ui.internal.ModelQueryLanguageActivator;

/**
 * This class was generated. Customizations should only happen in a newly
 * introduced subclass. 
 */
public class ModelQueryLanguageExecutableExtensionFactory extends AbstractGuiceAwareExecutableExtensionFactory {

	@Override
	protected Bundle getBundle() {
		return ModelQueryLanguageActivator.getInstance().getBundle();
	}
	
	@Override
	protected Injector getInjector() {
		return ModelQueryLanguageActivator.getInstance().getInjector(ModelQueryLanguageActivator.ORG_ECLIPSE_XTEXT_MQREPL_MODELQUERYLANGUAGE);
	}
	
}
