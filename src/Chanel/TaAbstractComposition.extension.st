Extension { #name : 'TaAbstractComposition' }

{ #category : '*Chanel' }
TaAbstractComposition >> compiledMethodAt: aSelector ifPresent: aValuable [
	^ aValuable value: (self compiledMethodAt: aSelector ifAbsent: [ ^ self ])
]
