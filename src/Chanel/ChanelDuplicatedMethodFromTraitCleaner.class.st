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

{ #category : #cleaning }
ChanelDuplicatedMethodFromTraitCleaner >> clean [
	self configuration definedClasses iterator
		| #hasTraitComposition selectIt
		> #removeDuplicatedMethodsFromTrait doIt
]
