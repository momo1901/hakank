/*

  Bus scheduling in B-Prolog.

  Problem from Taha "Introduction to Operations Research", page 58.
  Scheduling of buses during a day.

  This is a slightly more general model than Taha's.


  Model created by Hakan Kjellerstrand, hakank@gmail.com
  See also my B-Prolog page: http://www.hakank.org/bprolog/

*/


go :-
        % number of time slots
        TimeSlots = 6,
        
        % demand: minimum number of buses at time t
        Demands = [8, 10, 7, 12, 4, 4],      
        MaxNum = sum(Demands),
        
        % result: how many buses start the schedule at time slot t?
        length(X, TimeSlots),
        X :: 0..MaxNum,

        % the objective to minimize: the total number of buses
        NumBuses #= sum(X),

        % meet the demands for this and the next time slot
        foreach(I in 1..TimeSlots-1,
              X[I]+X[I+1] #>= Demands[I]
        ),

        % demand "around the clock"
        X[TimeSlots] + X[1] #= Demands[TimeSlots],

        % search for minimum number of buses satisfying the constraints
        minof(labeling(X), NumBuses),

        writeln([NumBuses, X]).
