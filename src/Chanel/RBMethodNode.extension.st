Extension { #name : 'RBMethodNode' }

{ #category : '*Chanel' }
RBMethodNode >> allTemporaries [
	^ self allSequenceNodes flatCollect: #temporaries
]

{ #category : '*Chanel' }
RBMethodNode >> install [

	| newCode |
	('Updating: ' , self compiledMethod printString) record.
	newCode := self formattedCode.

	"We reset the old AST once we saved the new source code in order to avoid others to manipulate a wrong AST."
	ASTCache reset.
	^ self methodClass compile: newCode
]
