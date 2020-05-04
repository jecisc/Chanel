Class {
	#name : #ChanelCleanersOrderTest,
	#superclass : #ChanelAbstractCleanerTest,
	#category : #'Chanel-Tests'
}

{ #category : #running }
ChanelCleanersOrderTest >> setUp [
	super setUp.
	class := self createDefaultClass
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeEmptyConditionals [
	"The alias cleaner needs to run before the empty conditionals cleaner."

	class
		compile:
			('{1}
  {2}' format: {self selector . '#() notEmpty ifTrue: [ 1 ]'}).

	Chanel perfume: {package} using: {ChanelEmptyConditionalSimplifierCleaner . ChanelMethodAliasesCleaner}.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '#() ifNotEmpty: [ 1 ]'})
]

{ #category : #tests }
ChanelCleanersOrderTest >> testAliasBeforeNilConditionals [
	"The alias cleaner needs to run before the nil conditionals cleaner."

	class
		compile:
			('{1}
  {2}' format: {self selector . '10 notNil ifTrue: [ 1 ]'}).

	Chanel perfume: {package} using: {ChanelNilConditionalSimplifierCleaner . ChanelMethodAliasesCleaner}.

	self
		assert: (class >> self selector) sourceCode
		equals:
			('{1}
  {2}' format: {self selector . '10 ifNotNil: [ 1 ]'})
]

{ #category : #tests }
ChanelCleanersOrderTest >> testUnreadTemporariesBeforeUselessASTNodes [
	"The cleaner removing the useless AST nodes need to run after the cleaner removing unread temporaries because it will remove more nodes that way."

	class
		compile:
			'testMethod
  | test |
  test := #toto.
  ^#one'.

	Chanel perfume: {package} using: {ChanelRemoveUnusedNodesFromASTCleaner . ChanelUnreadTemporaryCleaner}.

	self
		assert: (class >> #testMethod) sourceCode
		equals:
			'testMethod
  ^#one'
]
