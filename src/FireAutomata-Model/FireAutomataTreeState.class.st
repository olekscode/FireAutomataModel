Class {
	#name : #FireAutomataTreeState,
	#superclass : #FireAutomataCellState,
	#category : #'FireAutomata-Model'
}

{ #category : #accessing }
FireAutomataTreeState >> color [

	^ Color green
]

{ #category : #testing }
FireAutomataTreeState >> isTree [

	^ true
]

{ #category : #'instance creation' }
FireAutomataTreeState >> newState [

	^ (cell neighbourhood anySatisfy: [ :neighbourCell | neighbourCell state isFire ])
		ifTrue: [ FireAutomataFireState forCell: cell ]
		ifFalse: [ ^ self ].
]
