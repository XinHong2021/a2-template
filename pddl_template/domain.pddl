(define (domain Dangeon)

    (:requirements
        :typing
        :negative-preconditions
        :disjunctive-preconditions
    )

    (:types
        swords cells
    )

    (:predicates
        ;Hero's cell location
        (at-hero ?loc - cells)
        
        ;Sword cell location
        (at-sword ?s - swords ?loc - cells)
        
        ;Indicates if a cell location has a monster
        (has-monster ?loc - cells)
        
        ;Indicates if a cell location has a trap
        (has-trap ?loc - cells)
        
        ;Indicates if a chell or sword has been destroyed
        (is-destroyed ?obj)
        
        ;connects cells
        (connected ?from ?to - cells)
        
        ;Hero's hand is free
        (arm-free)
        
        ;Hero's holding a sword
        (holding ?s - swords)
    
        ;It becomes true when a trap is disarmed
        (trap-disarmed ?loc)
        
    )

    ;Hero can move if the
    ;    - hero is at current location
    ;    - cells are connected, 
    ;    - there is no trap in current loc, and 
    ;    - destination does not have a trap/monster/has-been-destroyed
    ;Effects move the hero, and destroy the original cell. No need to destroy the sword.
    (:action move
        :parameters (?from ?to - cells)
        :precondition (and 
            (connected ?from ?to)
            (at-hero ?from)
            (not (has-trap ?to))
            (not (has-monster ?to))
            (not (is-destroyed ?to))
            (or ; no trap or disarm a trap can leave 
                (not (has-trap ?from))
                (trap-disarmed ?from)
            )              
        )
        :effect (and 
            (at-hero ?to)
            (is-destroyed ?from)
            (not (at-hero ?from))                
        )
    )
    
    ;When this action is executed, the hero gets into a location with a trap
    ;   - hero is at current location
    ;   - cells are connected
    ;   - there is a trap in current loc
    ;   - loc is not destroyed 
    ;   - Hero's hand is free
    ;   - Hero is not from a loc with trap or trap-disarmed
    (:action move-to-trap
        :parameters (?from ?to - cells)
        :precondition (and
            (connected ?from ?to)
            (at-hero ?from)
            (has-trap ?to)
            (not (has-monster ?to))
            (not (is-destroyed ?to))
            (arm-free)
            (or
                (not (has-trap ?from))
                (trap-disarmed ?from)
            )                
        )
        :effect (and 
            (at-hero ?to)
            (is-destroyed ?from)
            (not (at-hero ?from))                
        )
    )

    ;When this action is executed, the hero gets into a location with a monster
    ;   - holding a sword
    (:action move-to-monster
        :parameters (?from ?to - cells ?s - swords)
        :precondition (and 
            (connected ?from ?to)
            (at-hero ?from)
            (has-monster ?to)
            (holding ?s)
            (not (is-destroyed ?to))
            (or
                (not (has-trap ?from))
                (trap-disarmed ?from)
            )                
        )
        :effect (and 
            (at-hero ?to)
            (is-destroyed ?from)
            (not (at-hero ?from))                 
        )
    )
    
    ;Hero picks a sword if he's in the same location
    ;   - sword in the loc
    ;   - hero's arm is free
    ;Effects the sword is not in the loc and arm is not free 
    (:action pick-sword
        :parameters (?loc - cells ?s - swords)
        :precondition (and 
            (at-hero ?loc)    
            (at-sword ?s ?loc)
            (arm-free)                
        )
        :effect (and
            (holding ?s)
            (not (at-sword ?s ?loc))
            (not (arm-free))                
        )
    )
    
    ;Hero destroys his sword. 
    ;   - the loc doesn't have a trap or monster
    ;Effects arm-free and not holding a sword
    (:action destroy-sword
        :parameters (?loc - cells ?s - swords)
        :precondition (and 
            (at-hero ?loc)    
            (holding ?s)
            (not (has-trap ?loc))
            (not (has-monster ?loc))                
        )
        :effect (and
            (arm-free)
            (not (holding ?s))                
        )
    )
    
    ;Hero disarms the trap with his free arm
    ;   assumption: trap's material still alive 
    ;   - only when hero's loc has a trap and arm-free
    (:action disarm-trap
        :parameters (?loc - cells)
        :precondition (and 
            (at-hero ?loc)    
            (has-trap ?loc)
            (arm-free)                
        )
        :effect (and
            (trap-disarmed ?loc)                
        )
    )
    
)