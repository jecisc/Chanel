"
packages := ((IceRepository registry select: [ :e | e name includesSubstring: 'Moose' ]) flatCollect: [ :e | e workingCopy packageNames collect: [:s | s asPackageIfAbsent: [ nil ] ]]) reject: #isNil.

Chanel perfume: packages


I am in charge of cleaning multiple things in packages of a project. 

For more information, check the class comments of all subclasses of ChanelAbstractCleaner.

7) Remove methods only calling super
================================

Remove each methods only doing a super call. Does not remove methods with pragmas.


9) Remove duplicated methods from traits 
================================

If methods present on traits are duplicated on classes, we remove the duplicated version.
"
Class {
	#name : #Chanel,
	#superclass : #Object,
	#instVars : [
		'packages'
	],
	#category : #Chanel
}

{ #category : #cleaning }
Chanel class >> perfume: aCollectionOfPackages [
	^ self new
		packages: aCollectionOfPackages;
		clean
]

{ #category : #cleaning }
Chanel >> clean [
	(ChanelAbstractCleaner cleanersFor: self) do: #clean.
	self
		removeMethodsOnlyCallingSuper;
		removeDuplicatedMethodsFromTrait
]

{ #category : #accessing }
Chanel >> definedClasses [
	^ packages flatCollect: #definedClasses
]

{ #category : #accessing }
Chanel >> definedTestCases [
	^ self definedClasses select: #isTestCase
]

{ #category : #accessing }
Chanel >> localMethods [
	^ (packages flatCollect: #methods) reject: #isFromTrait
]

{ #category : #accessing }
Chanel >> localMethodsWithoutExtensions [
	^ self localMethods reject: #isExtension
]

{ #category : #accessing }
Chanel >> packages: anObject [
	packages := anObject
]

{ #category : #simplification }
Chanel >> removeDuplicatedMethodsFromTrait [
	self definedClasses
		select: [ :class | class isTrait not and: [ class hasTraitComposition ] ]
		thenDo: [ :class | 
			class localMethods
				do:
					[ :method | (class traitComposition compiledMethodAt: method selector ifAbsent: [ nil ])
										ifNotNil: [ :m | m ast = method ast ifTrue: [ method removeFromSystem ] ] ] ]
]

{ #category : #simplification }
Chanel >> removeMethodsOnlyCallingSuper [
	| matcher |
	matcher := RBParseTreeSearcher justSendsSuper.
	self localMethods
		do: [ :method | (method pragmas isEmpty and: [ matcher executeMethod: method ast initialAnswer: false ]) ifTrue: [ method removeFromSystem ] ]
]
