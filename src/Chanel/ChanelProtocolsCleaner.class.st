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
	#classVars : [
		'MethodsInSpecificProtocolMaps',
		'ProtocolsToCleanMap',
		'TestMethodsInSpecificProtocolMaps'
	],
	#category : #Chanel
}

{ #category : #accessing }
ChanelProtocolsCleaner class >> methodsInSpecificProtocolMap [
	^ MethodsInSpecificProtocolMaps
		ifNil: [ MethodsInSpecificProtocolMaps := Dictionary new
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
				yourself ]
]

{ #category : #accessing }
ChanelProtocolsCleaner class >> priority [
	^ 2000
]

{ #category : #accessing }
ChanelProtocolsCleaner class >> protocolsToCleanMap [
	^ ProtocolsToCleanMap
		ifNil: [ ProtocolsToCleanMap := Dictionary new
				at: #(#'instance-creation') put: #'instance creation';
				at: #(#remove #removal) put: #removing;
				at: #(#'initialize-release') put: #initialization;
				at: #(#utils #utility) put: #utilities;
				at: #(#'filein/out' #'fileIn/Out' #'fileIn/out' #'filein/Out') put: #'file in/out';
				yourself ]
]

{ #category : #accessing }
ChanelProtocolsCleaner class >> testMethodsInSpecificProtocolMap [
	^ TestMethodsInSpecificProtocolMaps
		ifNil: [ TestMethodsInSpecificProtocolMaps := Dictionary new
				at: #setUp put: #running;
				at: #tearDown put: #running;
				yourself ]
]

{ #category : #cleaning }
ChanelProtocolsCleaner >> clean [
	| methods |
	methods := self configuration localMethodsWithoutExtensions.

	self cleanCloseProtocolsOf: methods.

	self ensureTestMethodsAreInRightProtocol: methods.

	methods do: [ :method | self methodsInSpecificProtocolMap at: method selector ifPresent: [ :protocol | method ensureProtocol: protocol ] ].

	methods
		select: [ :method | method methodClass isTestCase ]
		thenDo: [ :method | self testMethodsInSpecificProtocolMap at: method selector ifPresent: [ :protocol | method ensureProtocol: protocol ] ]
]

{ #category : #cleaning }
ChanelProtocolsCleaner >> cleanCloseProtocolsOf: methods [
	self protocolsToCleanMap
		keysAndValuesDo: [ :olds :new | 
			methods
				select: [ :meth | olds includes: meth protocol ]
				thenDo: [ :meth | meth protocol: new ] ]
]

{ #category : #cleaning }
ChanelProtocolsCleaner >> ensureTestMethodsAreInRightProtocol: methods [
	methods iterator
		| #isTestMethod selectIt
		| [ :method | method protocol beginsWith: 'test' ] rejectIt
		| [ :method | method ensureProtocol: #tests ] doIt
		> Execute
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
