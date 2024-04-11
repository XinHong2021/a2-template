;It's recommended to install the misc-pddl-generators plugin 
;and then use Network generator to create the graph
(define (problem p4-dangeon)
  (:domain DangeonP4)
  (:objects
        cell1 cell2 cell3 cell4 cell5 cell6 cell7 cell8 cell9 cell10 cell11 cell12 - cells
        sword1 sword2 - swords
        hero1 hero2 - heroes
        turn1 turn2 -turns
  )
  (:init
  
    ;Initial Hero Location
    (at-hero cell7 hero1)
    (at-hero cell7 hero2)
    
    ;He starts with a free arm
    (arm-free hero1)
    (arm-free hero2)
    
    ;Initial location of the swords
    (at-sword sword1 cell10)
    (at-sword sword2 cell6)
    
    ;Initial location of Monsters
    (has-monster cell4)
    (has-monster cell5)
    
    ;Initial lcocation of Traps
    (has-trap cell11)
    (has-trap cell12)
    
    ;Initial lcocation of locked
    (has-locked cell2)
    (has-locked cell8)
    
    ;Initial lcocation of Traps
    (at-key cell3)
    
    ; P4
    (hero-goal cell1 hero1)
    (hero-goal cell9 hero2)
    
    (hero-turn hero1 turn1)
    (hero-turn hero2 turn1)
    
    (cur-turn turn1)
    
    (next-turn turn1 turn2)
    (next-turn turn2 turn1)
    
    ;Graph Connectivity
    (connected cell1 cell2)
    (connected cell1 cell8)

    (connected cell2 cell1)
    (connected cell2 cell3)
    (connected cell2 cell9)
    
    (connected cell3 cell2)
    (connected cell3 cell4)
    (connected cell3 cell8)
    (connected cell3 cell10)
    
    (connected cell4 cell3)
    (connected cell4 cell5)
    (connected cell4 cell9)
    (connected cell4 cell11)
    
    (connected cell5 cell4)
    (connected cell5 cell6)
    (connected cell5 cell10)
    (connected cell5 cell12)
    
    (connected cell6 cell5)
    (connected cell6 cell7)
    (connected cell6 cell11)
    
    (connected cell7 cell6)
    (connected cell7 cell12)
    
    (connected cell8 cell1)
    (connected cell8 cell3)
    (connected cell8 cell9)
    
    (connected cell9 cell2)
    (connected cell9 cell4)
    (connected cell9 cell8)
    (connected cell9 cell10)
    
    (connected cell10 cell3)
    (connected cell10 cell5)
    (connected cell10 cell9)
    (connected cell10 cell11)
    
    (connected cell11 cell4)
    (connected cell11 cell6)
    (connected cell11 cell10)
    (connected cell11 cell12)
    
    (connected cell12 cell5)
    (connected cell12 cell7)
    (connected cell12 cell11)
    
  )
  (:goal (and
        ;Hero's Goal Location
        (is-goal hero1)
        (is-goal hero2)
  ))
  
)
