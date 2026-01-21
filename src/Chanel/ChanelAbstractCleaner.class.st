"
Description
--------------------

I am an abstract class to define the basice behavior of a cleaner. 

Each of my subclasses represents a kind of cleaning to apply on the project to clean.

I am configured with an instance of Chanel to get the elements to clean.

You can find the full list of cleaners running `ChanelAbstractCleaner cleaners`.

Public API and Key Messages
--------------------

- #clean 		Method executed to launch the specific cleaning of a cleaner.
	 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	configuration:		<aChanel>		An instance of Chanel representing the configuration of the cleaning.

"
Class {
	#name : 'ChanelAbstractCleaner',
	#superclass : 'Object',
	#instVars : [
		'configuration'
	],
	#category : 'Chanel',
	#package : 'Chanel'
}

{ #category : 'instance creation' }
ChanelAbstractCleaner class >> cleaners [
	^ self allSubclasses reject: #isAbstract
]

{ #category : 'accessing' }
ChanelAbstractCleaner class >> configuration: aChanel [
	^ self new
		configuration: aChanel;
		yourself
]

{ #category : 'testing' }
ChanelAbstractCleaner class >> isAbstract [
	^ self = ChanelAbstractCleaner
]

{ #category : 'testing' }
ChanelAbstractCleaner class >> isAvailableForPharo: anInteger [
	^ true
]

{ #category : 'accessing' }
ChanelAbstractCleaner class >> model [
  self flag: #pharo10.

  "This is because in P9 and before AITopologicalSorting class>>#sort:followingIncomingProperty: was returning nodes and now is returning the elements. Thus we keep that for compatibility until P10 is the latest version supported."^self
]

{ #category : 'accessing' }
ChanelAbstractCleaner class >> requirements [
	"Returns the list of cleaners that should run before this cleaner"

	^ #()
]

{ #category : 'cleaning' }
ChanelAbstractCleaner >> clean [
	self subclassResponsibility
]

{ #category : 'accessing' }
ChanelAbstractCleaner >> configuration [
	^ configuration
]

{ #category : 'accessing' }
ChanelAbstractCleaner >> configuration: anObject [
	configuration := anObject
]

{ #category : 'accessing' }
ChanelAbstractCleaner >> minimalPharoVersion [
	^ self configuration minimalPharoVersion
]
