"
Description
--------------------

I am a cleaner doing multiple cleanings in protocols. 

**I'll ensure that some methods are in the right protocol.**

For example #initialize should be in #initialization.

Find more in `self methodsInSpecificProtocolMap` and `self testMethodsInSpecificProtocolMap`.

**I'll update some protocols to follow convensions.**

For example I'll update initialize-release to initialize. Find more in `self protocolsToCleanMap`.

**I'll ensure tests are in a protocl starting with ""test""**
"
Class {
	#name : #ChanelProtocolsCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelProtocolsCleaner class >> methodsInSpecificProtocolMap [
	^ Dictionary new
		at: #initialize put: #initialization;
		at: #clone put: #copying;
		at: #copy put: #copying;
		at: #deepCopy put: #copying;
		at: #postCopy put: #copying;
		at: #veryDeepCopy put: #copying;
		at: #shallowCopy put: #copying;
		at: #= put: #comparing;
		at: #hash put: #comparing;
		at: #finalize put: #finalization;
		at: #finalizeValues put: #finalization;
		at: #isAbstract put: #testing;
		yourself
]

{ #category : #accessing }
ChanelProtocolsCleaner class >> priority [
	^ 2000
]

{ #category : #accessing }
ChanelProtocolsCleaner class >> protocolsToCleanMap [
	^ Dictionary new
		at: #(#'instance-creation') put: #'instance creation';
		at: #(#remove #removal) put: #removing;
		at: #(#'initialize-release') put: #initialization;
		at: #(#utils #utility) put: #utilities;
		at: #(#'filein/out' #'fileIn/Out' #'fileIn/out' #'filein/Out') put: #'file in/out';
		yourself
]

{ #category : #accessing }
ChanelProtocolsCleaner class >> testMethodsInSpecificProtocolMap [
	^ Dictionary new
		at: #setUp put: #running;
		at: #tearDown put: #running;
		yourself
]

{ #category : #cleaning }
ChanelProtocolsCleaner >> clean [
	| methods protocolsMap |
	methods := self configuration localMethodsWithoutExtensions.

	self cleanCloseProtocolsOf: methods.

	self ensureTestMethodsAreInRightProtocol.

	protocolsMap := self methodsInSpecificProtocolMap.
	methods do: [ :method | protocolsMap at: method selector ifPresent: [ :protocol | method protocol = protocol ifFalse: [ method protocol: protocol ] ] ].

	protocolsMap := self testMethodsInSpecificProtocolMap.
	methods
		select: [ :method | method methodClass isTestCase ]
		thenDo: [ :method | protocolsMap at: method selector ifPresent: [ :protocol | method protocol = protocol ifFalse: [ method protocol: protocol ] ] ]
]

{ #category : #cleaning }
ChanelProtocolsCleaner >> cleanCloseProtocolsOf: methods [
	self protocolsToCleanMap keysAndValuesDo: [ :olds :new | methods do: [ :meth | (olds includes: meth protocol) ifTrue: [ meth protocol: new ] ] ]
]

{ #category : #cleaning }
ChanelProtocolsCleaner >> ensureTestMethodsAreInRightProtocol [
	(self configuration definedTestCases flatCollect: #localMethods)
		select: [ :method | method isExtension not and: [ (method selector beginsWith: 'test') and: [ (method protocol beginsWith: 'test') not ] ] ]
		thenDo: [ :method | method protocol = #tests ifFalse: [ method protocol: #tests ] ]
]

{ #category : #accessing }
ChanelProtocolsCleaner >> methodsInSpecificProtocolMap [
	^ self class methodsInSpecificProtocolMap
]

{ #category : #accessing }
ChanelProtocolsCleaner >> protocolsToCleanMap [
	^ self class protocolsToCleanMap
]

{ #category : #accessing }
ChanelProtocolsCleaner >> testMethodsInSpecificProtocolMap [
	^ self class testMethodsInSpecificProtocolMap
]
