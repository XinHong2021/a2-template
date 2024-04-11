;It's recommended to install the misc-pddl-generators plugin 
;and then use Network generator to create the graph
(define (problem p3-dangeon)
  (:domain Dangeon)
  (:objects
        cell1-1 cell1-2 cell1-3 cell1-4 cell1-5 
        cell2-1 cell2-2 cell2-3 cell2-4 cell2-5 
        cell3-1 cell3-2 cell3-3 cell3-4 cell3-5 
        cell4-1 cell4-2 cell4-3 cell4-4 cell4-5 - cells
        sword1 sword2 sword3 sword4 - swords
  )
  (:init
  
    ;Initial Hero Location
    (at-hero cell4-5)
    
    ;He starts with a free arm
    (arm-free)
    
    ;Initial location of the swords
    (at-sword sword1 cell1-5)
    (at-sword sword2 cell2-3)
    (at-sword sword3 cell3-1)
    (at-sword sword4 cell4-3)
    
    ;Initial location of Monsters
    (has-monster cell1-3)
    (has-monster cell1-4)
    (has-monster cell2-2)
    (has-monster cell3-2)
    (has-monster cell3-4)
    (has-monster cell4-2)
    (has-monster cell4-4)
    
    ;Initial lcocation of Traps
    (has-trap cell1-2)
    (has-trap cell2-1)
    (has-trap cell2-4)
    (has-trap cell2-5)
    (has-trap cell3-3)
    (has-trap cell4-1)
    
    ;Graph Connectivity
    (connected cell1-1 cell2-1)
    (connected cell1-1 cell1-2)
    
    (connected cell1-2 cell1-1)
    (connected cell1-2 cell2-2)
    (connected cell1-2 cell1-3)
    
    (connected cell1-3 cell1-2)
    (connected cell1-3 cell2-3)
    (connected cell1-3 cell1-4)
    
    (connected cell1-4 cell1-3)
    (connected cell1-4 cell2-4)
    (connected cell1-4 cell1-5)
    
    (connected cell1-5 cell1-4)
    (connected cell1-5 cell2-5)
    
    
    
    (connected cell2-1 cell1-1)
    (connected cell2-1 cell2-2)
    (connected cell2-1 cell3-1)
    
    (connected cell2-2 cell1-2)
    (connected cell2-2 cell2-1)
    (connected cell2-2 cell3-2)
    (connected cell2-2 cell2-3)
    
    (connected cell2-3 cell1-3)
    (connected cell2-3 cell2-2)
    (connected cell2-3 cell3-3)
    (connected cell2-3 cell2-4)
    
    (connected cell2-4 cell3-4)
    (connected cell2-4 cell2-5)
    (connected cell2-4 cell1-4)
    (connected cell2-4 cell2-3)
    
    (connected cell2-5 cell3-5)
    (connected cell2-5 cell1-5)
    (connected cell2-5 cell2-4)
    
    
    
    (connected cell3-1 cell4-1)
    (connected cell3-1 cell3-2)
    (connected cell3-1 cell2-1)
    
    (connected cell3-2 cell4-2)
    (connected cell3-2 cell3-3)
    (connected cell3-2 cell2-2)
    (connected cell3-2 cell3-1)
    
    (connected cell3-3 cell4-3)
    (connected cell3-3 cell3-4)
    (connected cell3-3 cell2-3)
    (connected cell3-3 cell3-2)
    
    (connected cell3-4 cell4-4)
    (connected cell3-4 cell3-5)
    (connected cell3-4 cell2-4)
    (connected cell3-4 cell3-3)
    
    (connected cell3-5 cell4-5)
    (connected cell3-5 cell2-5)
    (connected cell3-5 cell3-4)
    
    
    
    (connected cell4-1 cell4-2)
    (connected cell4-1 cell3-1)
    
    (connected cell4-2 cell4-3)
    (connected cell4-2 cell3-2)
    (connected cell4-2 cell4-1)
    
    (connected cell4-3 cell4-4)
    (connected cell4-3 cell3-3)
    (connected cell4-3 cell4-2)
    
    (connected cell4-4 cell4-5)
    (connected cell4-4 cell3-4)
    (connected cell4-4 cell4-3)
    
    (connected cell4-5 cell3-5)
    (connected cell4-5 cell4-4)
    
  )
  (:goal (and
            ;Hero's Goal Location
            (at-hero cell1-1)
  ))
  
)
