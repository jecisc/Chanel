Extension { #name : #ClassDescription }

{ #category : #'*Chanel' }
ClassDescription >> removeDuplicatedMethodsFromTrait [
	self localMethods
		do: [ :method | self traitComposition compiledMethodAt: method selector ifPresent: [ :m | m ast = method ast ifTrue: [ method removeMethod ] ] ].

	self class localMethods
		do: [ :method | self traitComposition classComposition compiledMethodAt: method selector ifPresent: [ :m | m ast = method ast ifTrue: [ method removeMethod ] ] ]
]
