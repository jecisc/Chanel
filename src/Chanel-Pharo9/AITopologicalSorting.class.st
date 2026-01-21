Class {
	#name : 'AITopologicalSorting',
	#superclass : 'MalTopologicalSorting',
	#category : 'Chanel-Pharo9',
	#package : 'Chanel-Pharo9'
}

{ #category : 'running' }
AITopologicalSorting >> run [
	^ super run reverse
]
