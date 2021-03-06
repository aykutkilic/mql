package org.eclipse.xtext.mqrepl.jvmmodel

import com.google.inject.Inject
import com.google.inject.Injector
import org.eclipse.core.resources.IProject
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.xtext.common.types.util.TypeReferences
import org.eclipse.xtext.mqrepl.IModelQueryConstants
import org.eclipse.xtext.mqrepl.modelQueryLanguage.Model
import org.eclipse.xtext.resource.IResourceDescriptions
import org.eclipse.xtext.xbase.jvmmodel.IJvmDeclaredTypeAcceptor
import org.eclipse.xtext.xbase.jvmmodel.JvmTypesBuilder

class ModelQueryLanguageJvmModelInferrer extends ModelQueryLanguageJvmModelInferrerBase {

	@Inject extension JvmTypesBuilder
	
	@Inject extension TypeReferences


   	def dispatch void infer(Model model, IJvmDeclaredTypeAcceptor acceptor, boolean isPrelinkingPhase) {
   		acceptor.accept(
   			model.toClass(IModelQueryConstants::INFERRED_CLASS_NAME)
   		).initializeLater [
   				members += model.toField(IModelQueryConstants::INDEX, typeof(IResourceDescriptions).getTypeForName(model))
   				members += model.toField(IModelQueryConstants::PROJECT, typeof(IProject).getTypeForName(model))
   				members += model.toField(IModelQueryConstants::RESOURCESET, typeof(ResourceSet).getTypeForName(model))
   				members += model.toField(IModelQueryConstants::INJECTOR, typeof(Injector).getTypeForName(model))
   				members += model.toMethod("main", Void::TYPE.getTypeForName(model)) [
   					body = model.body
   					exceptions += typeof(Exception).getTypeForName(model)
   				]
   				for (op : model.methods) {
   					members += op.toMethod(op.name, op.type ?: inferredType) [
							for (p : op.parameters) {
								parameters += p.toParameter(p.name, p.parameterType)
							}
							copyAndFixTypeParameters(op.typeParameters, it)
							body = op.body
						]
   				}
   			]
   		
   		
   	}
}
