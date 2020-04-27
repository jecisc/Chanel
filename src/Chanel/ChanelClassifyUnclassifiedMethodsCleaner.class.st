"
Description
--------------------

I am a cleaner that tries to categorize via the method categorizer of the system unclassified methods.
"
Class {
	#name : #ChanelClassifyUnclassifiedMethodsCleaner,
	#superclass : #ChanelAbstractCleaner,
	#category : #Chanel
}

{ #category : #accessing }
ChanelClassifyUnclassifiedMethodsCleaner class >> priority [
	^ 10000
]

{ #category : #cleaning }
ChanelClassifyUnclassifiedMethodsCleaner >> clean [
	self configuration definedClasses iterator
		| [ :class | { class . class class }  ] flatCollectIt
		| [ :class | class uncategorizedSelectors collect: [ :selector | class >> selector ] ] flatCollectIt
		| [ :method | MethodClassifier classify: method ] doIt
		| [ :method | method protocol ~= #'as yet unclassified' ] selectIt
		> [ :method |  ('Method ' , method printString , ' was categorized in ' , method protocol) record ] doIt
]
