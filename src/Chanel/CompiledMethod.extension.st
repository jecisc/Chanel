Extension { #name : #CompiledMethod }

{ #category : #'*Chanel' }
CompiledMethod >> ensureProtocol: aSymbol [
	self protocol = aSymbol ifTrue: [ ^ self ].

	('Updating protocol of: ' , self printString , ' from ' , self protocol , ' to ' , aSymbol) record.
	self protocol: aSymbol
]

{ #category : #'*Chanel' }
CompiledMethod >> hasMessages [
	^ self ast hasMessages
]

{ #category : #'*Chanel' }
CompiledMethod >> hasPragma [
	^ self pragmas isNotEmpty
]

{ #category : #'*Chanel' }
CompiledMethod >> installAST [
	"In Chanel we update some ASTs. This method install the updated AST."

	self ast install
]

{ #category : #'*Chanel' }
CompiledMethod >> isInstanceSide [
	^ self methodClass isInstanceSide
]

{ #category : #'*Chanel' }
CompiledMethod >> removeMethod [
	('Removing: ' , self printString) record.
	self removeFromSystem
]
