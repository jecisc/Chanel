"
A ChanelAbstractCleanerTest is a test class for testing the behavior of ChanelAbstractCleaner
"
Class {
	#name : #ChanelAbstractCleanerTest,
	#superclass : #TestCase,
	#instVars : [
		'previousFormater',
		'package',
		'class',
		'extensionPackage'
	],
	#category : #'Chanel-Tests'
}

{ #category : #accessing }
ChanelAbstractCleanerTest >> actualClass [
	^ self class environment at: (self class name withoutSuffix: 'Test') asSymbol
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> assert: original isRewrittenAs: expected [
	class ifNil: [ self error: 'To use this method you need to setup the class variable' ].

	class
		compile:
			('{1}
  {2}' format: {self selector . original}).

	self runCleaner.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . expected})
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> createClassNamed: aSymbol [
	^ self createSubclassOf: Object named: aSymbol
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> createSubclassOf: aClass named: aSymbol [
	^ aClass
		subclass: aSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		package: package name
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> createTestCaseNamed: aSymbol [
	^ self createSubclassOf: TestCase named: aSymbol
]

{ #category : #helpers }
ChanelAbstractCleanerTest >> createTraitNamed: aSymbol [
	^ Trait named: aSymbol uses: {} package: package name
]

{ #category : #running }
ChanelAbstractCleanerTest >> extensionProtocol [
	^ '*' , extensionPackage name
]

{ #category : #running }
ChanelAbstractCleanerTest >> runCleaner [
	(self actualClass configuration: (Chanel new packages: {package})) clean
]

{ #category : #running }
ChanelAbstractCleanerTest >> setUp [
	super setUp.

	package := RPackageOrganizer default createPackageNamed: 'Package-Test-For-Chanel'.
	extensionPackage := RPackageOrganizer default createPackageNamed: 'ExtensionPackage-Test-For-Chanel'.

	"We only save the formatter if it is not the one used in the tests.
	The reason is that, while debugging a test, if it fails and is rerun, the set up is runned twice and the formatter used in tests will be saved in `previousFormatter`.
	With this guard, we avoid this case."
	RBProgramNode formatterClass = RBSimpleFormatter ifTrue: [ ^ self ].

	previousFormater := RBProgramNode formatterClass.
	RBProgramNode formatterClass: RBSimpleFormatter 
]

{ #category : #running }
ChanelAbstractCleanerTest >> tearDown [
	"I do not use the #package variable because sometime the tear down fail and I want to relaunch one test to clean the system."

	previousFormater ifNotNil: [ :formatter | RBProgramNode formatterClass: formatter ].
	('Package-Test-For-Chanel' asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem.
	('ExtensionPackage-Test-For-Chanel' asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem.
	super tearDown
]
