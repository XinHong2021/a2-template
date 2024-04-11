(define (domain DangeonP4)

    (:requirements
        :typing
        :negative-preconditions
        :disjunctive-preconditions
        :universal-preconditions
    )

    (:types
        swords cells heroes turns
    )

    (:predicates
        ;Hero's cell location
        (at-hero ?loc - cells ?hero - heroes)
        
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
        (arm-free ?hero - heroes)
        
        ;Hero's holding a sword
        (holding ?s - swords ?hero - heroes)
    
        ;It becomes true when a trap is disarmed
        (trap-disarmed ?loc)
        
        ;Key cell location
        (at-key ?loc - cells)
        
        ;Hero's holding a key
        (holding-key ?hero - heroes)
        
        ;Indicates if a cell location has a lock
        (has-locked ?loc - cells)
        
        (hero-turn ?hero - heroes ?turn - turns)
        
        (cur-turn ?turn - turns)
        
        (next-turn ?turn1 ?turn2 - turns)
        
        (hero-goal ?loc - cells ?hero - heroes)
        
        (is-goal ?hero - heroes)
        
    )

    ;Hero can move if the
    ;    - hero is at current location
    ;    - cells are connected, 
    ;    - there is no trap in current loc, and 
    ;    - destination does not have a trap/monster/has-been-destroyed
    ;Effects move the hero, and destroy the original cell. No need to destroy the sword.
    (:action move
        :parameters (?from ?to - cells ?hero - heroes ?turn1 ?turn2 - turns)
        :precondition (and 
            (connected ?from ?to)
            (at-hero ?from ?hero)
            (not (has-trap ?to))
            (not (has-monster ?to))
            (not (has-locked ?to))
            (not (is-destroyed ?to))
            (or
                (not (has-trap ?from))
                (trap-disarmed ?from)
            )
            (hero-turn ?hero ?turn1)
            (cur-turn ?turn1)
            (next-turn ?turn1 ?turn2)
            (not(is-goal ?hero))
        )
        :effect (and 
            (at-hero ?to ?hero)
            (is-destroyed ?from)
            (not (at-hero ?from ?hero))
            (hero-turn ?hero ?turn2)
            (not (hero-turn ?hero ?turn1))
        )
    )
    
    ;When this action is executed, the hero gets into a location with a trap
    (:action move-to-trap
        :parameters (?from ?to - cells ?hero - heroes ?turn1 ?turn2 - turns)
        :precondition (and 
            (connected ?from ?to)
            (at-hero ?from ?hero)
            (has-trap ?to)
            (arm-free ?hero)
            (not (is-destroyed ?to))
            (or
                (not (has-trap ?from))
                (trap-disarmed ?from)
            )         
            (hero-turn ?hero ?turn1)             
            (cur-turn ?turn1)             
            (next-turn ?turn1 ?turn2)
            (not(is-goal ?hero))
        )
        :effect (and 
            (at-hero ?to ?hero)
            (is-destroyed ?from)
            (not (at-hero ?from ?hero))
            (hero-turn ?hero ?turn2)   
            (not (hero-turn ?hero ?turn1))
        )
    )

    ;When this action is executed, the hero gets into a location with a monster
    (:action move-to-monster
        :parameters (?from ?to - cells ?s - swords ?hero - heroes ?turn1 ?turn2 - turns)
        :precondition (and 
            (connected ?from ?to)
            (at-hero ?from ?hero)
            (has-monster ?to)
            (holding ?s ?hero)
            (not (is-destroyed ?to))
            (or
                (not (has-trap ?from))
                (trap-disarmed ?from)
            )
            (hero-turn ?hero ?turn1)             
            (cur-turn ?turn1)            
            (next-turn ?turn1 ?turn2)
            (not(is-goal ?hero))
        )
        :effect (and 
            (at-hero ?to ?hero)
            (is-destroyed ?from)
            (not (at-hero ?from ?hero))
            (hero-turn ?hero ?turn2)   
            (not (hero-turn ?hero ?turn1))
        )
    )
    
    ;When this action is executed, the hero gets into a locked location
    (:action move-to-locked
        :parameters (?from ?to - cells ?hero - heroes ?turn1 ?turn2 - turns)
        :precondition (and 
            (connected ?from ?to)
            (at-hero ?from ?hero)
            (has-locked ?to)
            (holding-key ?hero)
            (not (is-destroyed ?to))
            (or
                (not (has-trap ?from))
                (trap-disarmed ?from)
            )
            (hero-turn ?hero ?turn1)        
            (cur-turn ?turn1)        
            (next-turn ?turn1 ?turn2)
            (not(is-goal ?hero))
        )
        :effect (and 
            (at-hero ?to ?hero)
            (is-destroyed ?from)
            (not (at-hero ?from ?hero))
            (hero-turn ?hero ?turn2)     
            (not (hero-turn ?hero ?turn1))
        )
    )
    
    ;Hero picks a sword if he's in the same location
    (:action pick-sword
        :parameters (?loc - cells ?s - swords ?hero - heroes ?turn1 ?turn2 - turns)
        :precondition (and 
            (at-hero ?loc ?hero)    
            (at-sword ?s ?loc)
            (arm-free ?hero)
            (hero-turn ?hero ?turn1)         
            (cur-turn ?turn1)            
            (next-turn ?turn1 ?turn2)
            (not(is-goal ?hero))
        )
        :effect (and
            (holding ?s ?hero)
            (not (at-sword ?s ?loc))
            (not (arm-free ?hero))        
            (hero-turn ?hero ?turn2) 
            (not (hero-turn ?hero ?turn1))
        )
    )
    
    ;Hero picks a key if he's in the same location
    (:action pick-key
        :parameters (?loc - cells ?hero - heroes ?turn1 ?turn2 - turns)
        :precondition (and 
            (at-hero ?loc ?hero)    
            (at-key ?loc)
            (arm-free ?hero)
            (hero-turn ?hero ?turn1)         
            (cur-turn ?turn1)       
            (next-turn ?turn1 ?turn2)
            (not(is-goal ?hero))
        )
        :effect (and
            (holding-key ?hero)
            (not (at-key ?loc))
            (not (arm-free ?hero))        
            (hero-turn ?hero ?turn2) 
            (not (hero-turn ?hero ?turn1))
        )
    )
    
    ;Hero destroys his sword. 
    (:action destroy-sword
        :parameters (?loc - cells ?s - swords ?hero - heroes ?turn1 ?turn2 - turns)
        :precondition (and 
            (at-hero ?loc ?hero)    
            (holding ?s ?hero)
            (not (has-trap ?loc))
            (not (has-monster ?loc))
            (hero-turn ?hero ?turn1)       
            (cur-turn ?turn1)          
            (next-turn ?turn1 ?turn2)
            (not(is-goal ?hero))
        )
        :effect (and
            (arm-free ?hero)
            (not (holding ?s ?hero))          
            (hero-turn ?hero ?turn2)
            (not (hero-turn ?hero ?turn1))
        )
    )
    
    ;Hero destroys his key. 
    (:action destroy-key
        :parameters (?loc - cells ?hero - heroes ?turn1 ?turn2 - turns)
        :precondition (and 
            (at-hero ?loc ?hero)    
            (holding-key ?hero)
            (not (has-trap ?loc))
            (hero-turn ?hero ?turn1)     
            (cur-turn ?turn1)        
            (next-turn ?turn1 ?turn2)
            (not(is-goal ?hero))
        )
        :effect (and
            (arm-free ?hero)
            (not (holding-key ?hero))          
            (hero-turn ?hero ?turn2)
            (not (hero-turn ?hero ?turn1))
        )
    )
    
    ;Hero disarms the trap with his free arm
    (:action disarm-trap
        :parameters (?loc - cells ?hero - heroes ?turn1 ?turn2 - turns)
        :precondition (and 
            (at-hero ?loc ?hero)    
            (has-trap ?loc)
            (arm-free ?hero)     
            (hero-turn ?hero ?turn1)    
            (cur-turn ?turn1)          
            (next-turn ?turn1 ?turn2)
            (not(is-goal ?hero))
        )
        :effect (and
            (trap-disarmed ?loc)         
            (hero-turn ?hero ?turn2)
            (not (hero-turn ?hero ?turn1))
        )
    )
    
    ;Hero shared his sword to another hero. 
    (:action share-sword
        :parameters (?loc - cells ?s - swords ?from ?to - heroes ?turn1 ?turn2 - turns)
        :precondition (and 
            (at-hero ?loc ?from)
            (at-hero ?loc ?to) 
            (holding ?s ?from)
            (arm-free ?to)
            (not (is-goal ?to))
            (not (has-trap ?loc))
            (not (has-monster ?loc))
            (hero-turn ?from ?turn1)      
            (cur-turn ?turn1)          
            (next-turn ?turn1 ?turn2)
            (not(is-goal ?from))
        )
        :effect (and
            (arm-free ?from)
            (not (holding ?s ?from))
            (holding ?s ?to)
            (not (arm-free ?to))  
            (hero-turn ?from ?turn2)
            (not (hero-turn ?from ?turn1))
        )
    )
    
    ;Hero shared his key to another hero. 
    (:action share-key
        :parameters (?loc - cells ?from ?to - heroes ?turn1 ?turn2 - turns)
        :precondition (and 
            (at-hero ?loc ?from)
            (at-hero ?loc ?to) 
            (holding-key ?from)
            (arm-free ?to)
            (not (is-goal ?to))
            (not (has-trap ?loc))
            (hero-turn ?from ?turn1)  
            (cur-turn ?turn1)      
            (next-turn ?turn1 ?turn2)
            (not(is-goal ?from))
        )
        :effect (and
            (arm-free ?from)
            (not (holding-key ?from))
            (holding-key ?to)
            (not (arm-free ?to))  
            (hero-turn ?from ?turn2)
            (not (hero-turn ?from ?turn1))
        )
    )
    
    (:action reach-goal
        :parameters (?loc - cells ?hero - heroes)
        :precondition (and 
            (at-hero ?loc ?hero)
            (hero-goal ?loc ?hero)
            (not(is-goal ?hero))
        )
        :effect (and
            (is-goal ?hero)
        )
    )
    
    (:action new-turn
        :parameters (?turn1 ?turn2 - turns)
        :precondition (and 
            (forall (?hero - heroes)
                (or 
                    (hero-turn ?hero ?turn2)
                    (is-goal ?hero)
                )
            )
            (next-turn ?turn1 ?turn2)
            (cur-turn ?turn1) 
        )
        :effect (and
            (cur-turn ?turn2) 
            (not (cur-turn ?turn1))
        )
    )
    
)