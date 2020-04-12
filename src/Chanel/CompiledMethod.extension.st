Extension { #name : #CompiledMethod }

{ #category : #'*Chanel' }
CompiledMethod >> ensureProtocol: aSymbol [
	self protocol = aSymbol ifTrue: [ ^ self ].
	
	self protocol: aSymbol
]
