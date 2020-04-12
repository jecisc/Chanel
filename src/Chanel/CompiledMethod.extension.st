Extension { #name : #CompiledMethod }

{ #category : #'*Chanel' }
CompiledMethod >> ensureProtocol: aSymbol [
	self protocol = aSymbol ifTrue: [ ^ self ].
	
	self protocol: aSymbol
]

{ #category : #'*Chanel' }
CompiledMethod >> hasPragma [
	^ self pragmas isNotEmpty
]

{ #category : #'*Chanel' }
CompiledMethod >> isInstanceSide [
	^ self methodClass isInstanceSide
]
