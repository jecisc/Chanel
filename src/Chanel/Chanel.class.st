"
Description
--------------------

I am in charge of cleaning multiple things in packages of a project. 

For more information, check the class comments of all subclasses of ChanelAbstractCleaner.

Examples
--------------------

	
	packages := ((IceRepository registry select: [ :e | e name includesSubstring: 'Moose' ])
						flatCollect: [ :e | e workingCopy packageNames collect: [:s | s asPackageIfAbsent: [ nil ] ]]) reject: #isNil.

	Chanel perfume: packages
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	packages:		<aCollection>		List of packages to clean.

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
	| cleaners |
	cleaners := ChanelAbstractCleaner cleanersFor: self.

	UIManager default displayProgress: 'Running Chanel' from: 1 to: cleaners size during: [ :bar | 
		cleaners
			doWithIndex: [ :cleaner :index |
				bar
					value: index;
					title: '(' , index asString , '/' , cleaners size asString , ') Running ' , cleaner printString.
				cleaner clean ] ]
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
