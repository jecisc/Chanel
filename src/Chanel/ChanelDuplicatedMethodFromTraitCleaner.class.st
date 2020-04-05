"
Description
--------------------

If methods present on traits are duplicated on classes, I remove the duplicated version.
"
Class {
	#name : #ChanelDuplicatedMethodFromTraitCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelDuplicatedMethodFromTraitCleaner class >> priority [
	^ 9000
]

{ #category : #cleaning }
ChanelDuplicatedMethodFromTraitCleaner >> clean [
	self configuration definedClasses
		select: [ :class | class isTrait not and: [ class hasTraitComposition ] ]
		thenDo: [ :class | 
			class localMethods
				do:
					[ :method | (class traitComposition compiledMethodAt: method selector ifAbsent: [ nil ]) ifNotNil: [ :m | m ast = method ast ifTrue: [ method removeFromSystem ] ] ] ]
]
