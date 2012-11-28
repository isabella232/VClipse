/*******************************************************************************
 * Copyright (c) 2012 webXcerpt Software GmbH.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * 
 * Contributors:
 *    webXcerpt Software GmbH - initial creator
 ******************************************************************************/
package org.vclipse.vcml.utils

import org.eclipse.emf.ecore.resource.Resource
import org.vclipse.vcml.vcml.BillOfMaterial
import org.vclipse.vcml.vcml.Characteristic
import org.vclipse.vcml.vcml.CharacteristicType
import org.vclipse.vcml.vcml.Material
import org.vclipse.vcml.vcml.NumericType
import org.vclipse.vcml.vcml.VcmlFactory
import org.vclipse.vcml.vcml.VcmlPackage

import static org.vclipse.vcml.utils.CreateVcmlObjects.*
import static org.vclipse.vcml.utils.VCMLObjectUtils.*
import org.vclipse.vcml.conversion.VCMLValueConverter
import com.google.inject.Inject
import org.vclipse.vcml.vcml.BOMItem
import org.vclipse.vcml.vcml.SelectionCondition
import org.vclipse.vcml.vcml.ConfigurationProfileEntry
import java.util.Map
import com.google.common.collect.Maps

class CreateVcmlObjects extends VCMLObjectUtils {
	
	protected static VcmlFactory VCML_FACTORY = VcmlFactory::eINSTANCE
	protected static VcmlPackage VCML_PACKAGE = VcmlPackage::eINSTANCE
	
	@Inject
	private VCMLValueConverter valueConverter
	
	private Map<String, String> name2Prefix
	
	new() {
		name2Prefix = Maps::newHashMap
	}
	
	def addPrefixMapping(String name, String prefix) {
		name2Prefix.put(name, prefix)
	}
	
	def clear() {
		name2Prefix.clear
	}
	
	def org.vclipse.vcml.vcml.Class newConfigurableClass(String name, String description) {
		newClass("(300)" + name, description)   
	}
	
	def Material create it : VcmlFactory::eINSTANCE.createMaterial newMaterial(String name, String description, String type) {
		it.name = getNameWithPrefix(name)
		it.description = mkSimpleDescription(description)
		it.type = getExtendedIDString(type)
	}
	
	def org.vclipse.vcml.vcml.Class create it : VcmlFactory::eINSTANCE.createClass newClass(String name, String description) {
		it.name = name
		it.description = mkSimpleDescription(description)
	}
	
	def org.vclipse.vcml.vcml.Classification create it : VcmlFactory::eINSTANCE.createClassification newClassification(org.vclipse.vcml.vcml.Class class_) {
		it.cls = class_
	}
	
	def BillOfMaterial create it : VcmlFactory::eINSTANCE.createBillOfMaterial newBom(Material material, String description) {
		it.name = getNameWithPrefix(material.name)
		it.material = material
		it.description = mkSimpleDescription(description)
	}
	 
	def BOMItem create it : VcmlFactory::eINSTANCE.createBOMItem newBOMItem(int number, Material material) {
		it.material = material
		it.itemnumber = number
	}
	
	def BOMItem create it : VcmlFactory::eINSTANCE.createBOMItem newBOMItem(int number, Material material, SelectionCondition condition, Iterable<ConfigurationProfileEntry> entries) {
		val newBomItem = newBOMItem(number, material)
		newBomItem.selectionCondition = condition
		newBomItem.entries.addAll(entries)
	}
	
	def Characteristic create it : VcmlFactory::eINSTANCE.createCharacteristic newNumericCharacteristic(String name, String description) {
		it.name = getNameWithPrefix(name)
		it.description = mkSimpleDescription(description)
		it.type = newNumericTypeInstance
	}
	 
	def Characteristic create it : VcmlFactory::eINSTANCE.createCharacteristic newSymbolicCharacteristic(String name, String description) {
		it.name = getNameWithPrefix(name)
		it.description = mkSimpleDescription(description)
		it.type = newSymbolicTypeInstance
	}

	def CharacteristicType newSymbolicTypeInstance() {
		val symbolicType = VCML_FACTORY.createSymbolicType
		symbolicType.numberOfChars = 30
		symbolicType.caseSensitive = true
		symbolicType
	}
	
	def NumericType newNumericTypeInstance() {
		val numericType = VCML_FACTORY.createNumericType
		numericType.numberOfChars = 15
		numericType.decimalPlaces = 3
		numericType.negativeValuesAllowed = true
		numericType
	}
	
	def genVCNamePrefix(Resource resource) {
		resource.URI.trimFileExtension.lastSegment + "_"
	}
	
	def getExtendedIDString(String type) {
		valueConverter.EXTENDED_ID.toString(type);
	}
	
	def private getNameWithPrefix(String name) {
		if(name2Prefix.containsKey(name)) {
			return name2Prefix.get(name) + name  
		}
		name
	}
}