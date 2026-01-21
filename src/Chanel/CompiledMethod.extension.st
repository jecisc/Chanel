Extension { #name : 'CompiledMethod' }

{ #category : '*Chanel' }
CompiledMethod >> ensureProtocol: aSymbol [
	self protocolName = aSymbol ifTrue: [ ^ self ].

	('Updating protocol of: ' , self printString , ' from ' , self protocolName , ' to ' , aSymbol) record.
	self protocol: aSymbol
]

{ #category : '*Chanel' }
CompiledMethod >> hasMessages [
	^ self ast hasMessages
]

{ #category : '*Chanel' }
CompiledMethod >> hasPragma [
	^ self pragmas isNotEmpty
]

{ #category : '*Chanel' }
CompiledMethod >> installAST [
	"In Chanel we update some ASTs. This method install the updated AST."

	"In case the update of ast introduce a direct call to self, we do not take the risk to update the AST to not introduce an infinite loop.
	Instead we discard the AST cache."
	(self ast sendNodes anySatisfy: [ :message | message isSelfSendTo: self selector ]) ifTrue: [ ^ ASTCache reset ].

	self ast install
]

{ #category : '*Chanel' }
CompiledMethod >> isInstanceSide [
	^ self methodClass isInstanceSide
]

{ #category : '*Chanel' }
CompiledMethod >> removeMethod [
	('Removing: ' , self printString) record.
	self removeFromSystem
]
