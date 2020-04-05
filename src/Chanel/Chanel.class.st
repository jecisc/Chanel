"
packages := ((IceRepository registry select: [ :e | e name includesSubstring: 'Moose' ]) flatCollect: [ :e | e workingCopy packageNames collect: [:s | s asPackageIfAbsent: [ nil ] ]]) reject: #isNil.

Chanel perfume: packages


I am in charge of cleaning multiple things in packages of a project. 

For more information, check the class comments of all subclasses of ChanelAbstractCleaner.


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
		ensureRightSuperIsCall;
		removeNilAssignmentsInInitialize;
		removeUnreadTemporaries;
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
