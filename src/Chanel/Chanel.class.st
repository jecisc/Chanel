"
packages := ((IceRepository registry select: [ :e | e name includesSubstring: 'Moose' ]) flatCollect: [ :e | e workingCopy packageNames collect: [:s | s asPackageIfAbsent: [ nil ] ]]) reject: #isNil.

Chanel perfume: packages


I am in charge of cleaning multiple things in packages of a project. 

1) Tests equality
================================

A first thing I'll clean is equality. For example I'll replace those cases:


x assert: y = z 					==> x assert: y equals: z

x deny: y = z 						==> x deny: y equals: z

x assert: y == z 					==> x assert: y identicalTo: z

x deny: y == z 						==> x deny: y identicalTo: z

x assert: y = true 				==> x assert: y

x deny y = true 					==> x deny: y

x assert: y = false 				==> x deny: y

x deny: y = false 					==> x assert: y

x assert: y equals: true 		==> x assert: y

x deny y equals: true 			==> x deny: y

x assert: y equals: false 		==> x deny: y

x deny: y equals: false 			==> x assert: y

2) Clean protocols
================================

I do multiple cleanings in protocols. 

* I'll ensure that some methods are in the right protocol. For example #initialize should be in #initialization. Find more in `self methodsInSpecificProtocolMap` and `self testMethodsInSpecificProtocolMap`.
* I'll update some protocols to follow convensions. For example I'll update initialize-release to initialize. Find more in `self protocolsToCleanMap`.

3) Conditional simplifications
================================

I simplify conditionals. For example I'll rewrite:

x isNil ifTrue: y 							==> x ifNil: y

x isNil ifFalse: y 						==> x ifNotNil: y

x isNotNil ifTrue: y 						==> x ifNotNil: y

x isNotNil ifFalse: y 					==> x ifNil: y

x isNil ifTrue: y ifFalse: z 			==> x ifNil: y ifNotNil: z

x isNil ifFalse: y ifTrue: z 			==> x ifNil: z ifNotNil: y

x isNotNil ifTrue: y ifFalse: z 		==> x ifNil: z ifNotNil: y

x isNotNil ifFalse: y ifTrue: z 		==> x ifNil: y ifNotNil: z

4) Test case names
================================

Will rename each test case ending with ""Tests"" te end with ""Test"" since this is ""a XXTestCase"".

5) Ensure right super are call
================================

- Ensure #setUp in TestCases always begins by `super setUp` (move it if not the first messand sent)
- Ensure #tearDown in TestCases always ends by `super tearDown` (move it if not the last messand sent)
- Ensure #initialize on instance side always has `super initialize`

6) Remove nil assignments in initialization
================================

Will remove all nil assignations in initialize methods because most of the time they are not needed. Be careful, in some cases, they are. 

7) Remove methods only calling super
================================

Remove each methods only doing a super call. Does not remove methods with pragmas.

8) Remove unread temporaries
================================

Remove all temporaries that are defined but not read.

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

{ #category : #protocols }
Chanel class >> methodsInSpecificProtocolMap [
	| protocolsMap |
	protocolsMap := Dictionary new.
	protocolsMap
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
		at: #isAbstract put: #testing.
	^ protocolsMap
]

{ #category : #cleaning }
Chanel class >> perfume: aCollectionOfPackages [
	^ self new
		packages: aCollectionOfPackages;
		clean
]

{ #category : #protocols }
Chanel class >> protocolsToCleanMap [
	| protocolsMap |
	protocolsMap := Dictionary new.
	protocolsMap
		at: #(#'instance-creation') put: #'instance creation';
		at: #(#remove #removal) put: #removing;
		at: #(#'initialize-release') put: #initialization;
		at: #(#utils #utility) put: #utilities;
		at: #(#'filein/out' #'fileIn/Out' #'fileIn/out' #'filein/Out') put: #'file in/out'.
	^ protocolsMap
]

{ #category : #protocols }
Chanel class >> testMethodsInSpecificProtocolMap [
	| protocolsMap |
	protocolsMap := Dictionary new.
	protocolsMap
		at: #setUp put: #running;
		at: #tearDown put: #running.
	^ protocolsMap
]

{ #category : #cleaning }
Chanel >> clean [
	self
		cleanEqualityTest;
		simplifyConditions;
		cleanProtocols;
		ensureTestCasesEndsWithTestInsteadOfTests;
		ensureRightSuperIsCall;
		removeNilAssignmentsInInitialize;
		removeUnreadTemporaries;
		removeMethodsOnlyCallingSuper;
		removeDuplicatedMethodsFromTrait
]

{ #category : #protocols }
Chanel >> cleanCloseProtocols [
	| methods |
	methods := self localMethodsWithoutExtensions.
	self protocolsToCleanMap keysAndValuesDo: [ :olds :new | methods do: [ :meth | (olds includes: meth protocol) ifTrue: [ meth protocol: new ] ] ]
]

{ #category : #equality }
Chanel >> cleanEqualityTest [
	| r |
	r := RBParseTreeRewriter new
		replace: '`@receiver assert: `@arg = `@arg2' with: '`@receiver assert: `@arg equals: `@arg2';
		replace: '`@receiver deny: `@arg = `@arg2' with: '`@receiver deny: `@arg equals: `@arg2';
		replace: '`@receiver assert: `@arg == `@arg2' with: '`@receiver assert: `@arg identicalTo: `@arg2';
		replace: '`@receiver deny: `@arg == `@arg2' with: '`@receiver deny: `@arg identicalTo: `@arg2';
		replace: '`@receiver assert: `@arg = true' with: '`@receiver assert: `@arg';
		replace: '`@receiver deny: `@arg = true' with: '`@receiver deny: `@arg';
		replace: '`@receiver assert: `@arg = false' with: '`@receiver deny: `@arg';
		replace: '`@receiver deny: `@arg = false' with: '`@receiver assert: `@arg';
		replace: '`@receiver assert: `@arg equals: true' with: '`@receiver assert: `@arg';
		replace: '`@receiver deny: `@arg equals: true' with: '`@receiver deny: `@arg';
		replace: '`@receiver assert: `@arg equals: false' with: '`@receiver deny: `@arg';
		replace: '`@receiver deny: `@arg equals: false' with: '`@receiver assert: `@arg';
		yourself.

	self rewriteMethodsOf: self definedTestCases matching: [ :m | m selector beginsWith: 'test' ] with: r
]

{ #category : #protocols }
Chanel >> cleanProtocols [
	| methods protocolsMap |
	methods := self localMethodsWithoutExtensions.

	self cleanCloseProtocols.

	self ensureTestMethodsAreInRightProtocol.

	protocolsMap := self methodsInSpecificProtocolMap.
	methods do: [ :method | protocolsMap at: method selector ifPresent: [ :protocol | method protocol = protocol ifFalse: [ method protocol: protocol ] ] ].

	protocolsMap := self testMethodsInSpecificProtocolMap.
	methods
		select: [ :method | method class isTestCase ]
		thenDo: [ :method | protocolsMap at: method selector ifPresent: [ :protocol | method protocol = protocol ifFalse: [ method protocol: protocol ] ] ]
]

{ #category : #accessing }
Chanel >> definedClasses [
	^ packages flatCollect: #definedClasses
]

{ #category : #accessing }
Chanel >> definedTestCases [
	^ self definedClasses select: #isTestCase
]

{ #category : #rightSuper }
Chanel >> ensureRightSuperIsCall [
	| methods |
	methods := self localMethods.
	self
		ensureSuperSetUpForMethods: methods;
		ensureSuperTearDownForMethods: methods;
		ensureSuperInitializeForMethods: methods
]

{ #category : #rightSuper }
Chanel >> ensureSuperInitializeForMethods: methods [
	methods
		select: [ :method | 
			method methodClass isInstanceSide
				and: [ method selector = #initialize
						and: [ method ast sendNodes
								ifNotEmpty: [ :nodes | (nodes anySatisfy: [ :node | node isSuperSend and: [ node selector = #initialize ] ]) not ]
								ifEmpty: [ false ] ] ] ]
		thenDo: [ :method | 
			| ast |
			ast := method ast.
			ast body addNodeFirst: (RBMessageNode receiver: (RBVariableNode named: #super) selector: #initialize).
			method methodClass compile: ast formattedCode ]
]

{ #category : #rightSuper }
Chanel >> ensureSuperSetUpForMethods: methods [
	methods
		select: [ :method | 
			method methodClass isTestCase
				and: [ method selector = #setUp and: [ (method ast sendNodes ifNotEmpty: [ :nodes | nodes first isSuperSend and: [ nodes first selector = #setUp ] ]) not ] ] ]
		thenDo: [ :method | 
			| ast |
			ast := method ast.
			ast sendNodes select: [ :each | each isSuperSend and: [ each selector = #setUp ] ] thenDo: #removeFromTree.
			ast body addNodeFirst: (RBMessageNode receiver: (RBVariableNode named: #super) selector: #setUp).
			method methodClass compile: ast formattedCode ]
]

{ #category : #rightSuper }
Chanel >> ensureSuperTearDownForMethods: methods [
	methods
		select: [ :method | 
			method methodClass isTestCase
				and: [ method selector = #tearDown
						and: [ (method ast sendNodes ifNotEmpty: [ :nodes | nodes last isSuperSend and: [ nodes last selector = #tearDown ] ] ifEmpty: [ true ]) not ] ] ]
		thenDo: [ :method | 
			| ast |
			ast := method ast.
			ast sendNodes select: [ :each | each isSuperSend and: [ each selector = #tearDown ] ] thenDo: #removeFromTree.
			ast body addNodeLast: (RBMessageNode receiver: (RBVariableNode named: #super) selector: #tearDown).
			method methodClass compile: ast formattedCode ]
]

{ #category : #'class names' }
Chanel >> ensureTestCasesEndsWithTestInsteadOfTests [
	self definedTestCases
		do: [ :class | (class name endsWith: 'Tests') ifTrue: [ (RBRenameClassRefactoring rename: class to: (class name withoutSuffix: 'Tests') , 'Test') execute ] ]
]

{ #category : #protocols }
Chanel >> ensureTestMethodsAreInRightProtocol [
	(self definedTestCases flatCollect: #localMethods)
		select: [ :method | method isExtension not and: [ (method selector beginsWith: 'test') and: [ (method protocol beginsWith: 'test') not ] ] ]
		thenDo: [ :method1 | method1 protocol = #tests ifFalse: [ method1 protocol: #tests ] ]
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
Chanel >> methodsInSpecificProtocolMap [
	^ self class methodsInSpecificProtocolMap
]

{ #category : #accessing }
Chanel >> packages: anObject [
	packages := anObject
]

{ #category : #accessing }
Chanel >> protocolsToCleanMap [
	^ self class protocolsToCleanMap
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

{ #category : #simplification }
Chanel >> removeNilAssignmentsInInitialize [
	(self localMethods select: [ :method | method selector = #initialize ])
		do: [ :method | 
			| ast |
			ast := method ast.
			(ast assignmentNodes select: [ :assignment | assignment value value isNil ])
				ifNotEmpty: [ :nilAssignmentNode | 
					nilAssignmentNode do: #removeFromTree.
					method methodClass compile: ast formattedCode ] ]
]

{ #category : #simplification }
Chanel >> removeUnreadTemporaries [
	self localMethods
		do: [ :method | 
			| ast |
			ast := method ast.
			(ast allSequenceNodes flatCollect: [ :sequence | sequence temporaries select: #isReadAtLeastOnce ])
				ifNotEmpty: [ :temporariesToRemove | 
					temporariesToRemove
						do: [ :temp | 
							temp declaringScope
								nodesDo: [ :node | (node isTemp and: [ node name = temp name ]) ifTrue: [ node parent replaceWith: node parent value ] ];
								removeTemporaryNamed: temp name ].
					method methodClass compile: ast formattedCode ] ]
]

{ #category : #execution }
Chanel >> rewriteMethodsOf: classes matching: aBlock with: rewriter [
	classes
		do: [ :class | 
			class localMethods
				select: aBlock
				thenDo: [ :m | 
					| n |
					n := m parseTree.
					(rewriter executeTree: n) ifTrue: [ class compile: n formattedCode ] ] ]
		displayingProgress: [ :c | c printString ]
]

{ #category : #execution }
Chanel >> rewriteMethodsOf: classes with: rewriter [
	self rewriteMethodsOf: classes matching: [ :method | true ] with: rewriter
]

{ #category : #simplification }
Chanel >> simplifyConditions [
	| r |
	r := RBParseTreeRewriter new
		replace: '`@receiver isNil ifTrue: `@arg' with: '`@receiver ifNil: `@arg';
		replace: '`@receiver isNil ifFalse: `@arg' with: '`@receiver ifNotNil: `@arg';
		replace: '`@receiver isNotNil ifTrue: `@arg' with: '`@receiver ifNotNil: `@arg';
		replace: '`@receiver isNotNil ifFalse: `@arg' with: '`@receiver ifNil: `@arg';
		replace: '`@receiver isNil ifTrue: `@arg ifFalse: `@arg2' with: '`@receiver ifNil: `@arg ifNotNil: `@arg2';
		replace: '`@receiver isNil ifFalse: `@arg ifTrue: `@arg2' with: '`@receiver ifNil: `@arg2 ifNotNil: `@arg';
		replace: '`@receiver isNotNil ifTrue: `@arg ifFalse: `@arg2' with: '`@receiver ifNil: `@arg2 ifNotNil: `@arg';
		replace: '`@receiver isNotNil ifFalse: `@arg ifTrue: `@arg2' with: '`@receiver ifNil: `@arg ifNotNil: `@arg2';
		yourself.

	self rewriteMethodsOf: self definedClasses with: r
]

{ #category : #accessing }
Chanel >> testMethodsInSpecificProtocolMap [
	^ self class testMethodsInSpecificProtocolMap
]
