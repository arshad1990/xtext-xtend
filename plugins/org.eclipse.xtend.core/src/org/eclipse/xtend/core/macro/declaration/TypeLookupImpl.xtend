package org.eclipse.xtend.core.macro.declaration

import org.eclipse.xtend.lib.macro.declaration.MutableAnnotationTypeDeclaration
import org.eclipse.xtend.lib.macro.services.TypeLookup
import org.eclipse.xtext.common.types.JvmDeclaredType
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration
import org.eclipse.xtend.lib.macro.declaration.MutableEnumerationTypeDeclaration
import org.eclipse.xtend.lib.macro.declaration.MutableInterfaceDeclaration

class TypeLookupImpl implements TypeLookup {
	
	extension CompilationUnitImpl compilationUnit
	
	new (CompilationUnitImpl compilationUnit) {
		this.compilationUnit = compilationUnit
	}
	
	override findAnnotationType(String qualifiedName) {
		val type = findType(qualifiedName)
		return switch type {
			MutableAnnotationTypeDeclaration : type
		}
	}
	
	override findClass(String qualifiedName) {
		val type = findType(qualifiedName)
		return switch type {
			MutableClassDeclaration : type
		}
	}
	
	override findEnumerationType(String qualifiedName) {
		val type = findType(qualifiedName)
		return switch type {
			MutableEnumerationTypeDeclaration : type
		}
	}
	
	override findInterface(String qualifiedName) {
		val type = findType(qualifiedName)
		return switch type {
			MutableInterfaceDeclaration : type
		}
	}
	
	private def findType(String qualifiedName) {
		val result = recursiveFindType(qualifiedName, compilationUnit.xtendFile.eResource.contents.filter(typeof(JvmDeclaredType)))
		return if (result != null) {
			compilationUnit.toType(result)
		}
	}
	
	private def JvmDeclaredType recursiveFindType(String qualifiedName, Iterable<? extends JvmDeclaredType> typeDeclarations) {
		val char dot = '.'
		for (type : typeDeclarations) {
			val name = type.getQualifiedName('.')
			if (qualifiedName == name) {
				return type
			}
			if (qualifiedName.startsWith(name) && qualifiedName.charAt(name.length) == dot) {
				return recursiveFindType(qualifiedName, type.members.filter(typeof(JvmDeclaredType)))
			}
		}
		return null
	}
	
	override findTypeGlobally(Class<? extends Object> clazz) {
		findTypeGlobally(clazz.canonicalName)
	}
	
	override findTypeGlobally(String typeName) {
		findType(typeName) ?: {
			val result = compilationUnit.typeReferences.findDeclaredType(typeName, compilationUnit.xtendFile)
			if (result == null)
				null
			else compilationUnit.toType(result)
		} 
	}
	
}