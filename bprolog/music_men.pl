/*

  Music men puzzle in B-Prolog.

  """
  Three friends like different kinds of music.  From the clues given
  below, can you identify them, say how old each is, and work out
  his musical preference?

  Clues: 
  1.      Rob is older than Queen, who likes classical music.
  2.      The pop-music fan, who is not Prince, is not 24.
  3.      Leon, who is not King, is 25.
  4.      Mark's musical preference is not jazz.
  """

  Knowledge: "this is what we know of the world."
  Names           : Leon, Mark, Rob.
  Surnames        : King, Prince, Queen.
  Ages            : 24, 25, 26.
  Music           : Classical, Jazz, Pop.


  Solution:
    Leon Prince, 25, jazz.
    Mark Queen, 24, classical.
    Rob King, 26, pop.

  Model created by Hakan Kjellerstrand, hakank@gmail.com
  See also my B-Prolog page: http://www.hakank.org/bprolog/

*/




go :-
        music_men([Age,Names,Surnames,Music]),
        NamesS = ['King','Prince','Queen'],
        SurnamesS = ['Leon','Mark','Rob'],
        MusicS = ['classical','jazz','pop'],
        get_sol(Names,NamesS,NamesSol),
        get_sol(Surnames,SurnamesS,SurnamesSol),
        get_sol(Music,MusicS,MusicSol),
        foreach((A,N,S,M) in (Age,NamesSol,SurnamesSol,MusicSol),
                format("~w ~w, ~d, ~w\n", [S,N,A,M])
               ),
        nl.


go2 :-
        findall([age:Age,names:Names,surnames:Surnames,music:Music],
                music_men([Age,Names,Surnames,Music]),L),
        write(L),nl.


go3 :-
        music_men([[Age24, Age25, Age26],
                   [King, Prince, Queen],
                   [Leon, Mark, Rob],
                   [Classical, Jazz, Pop]]),
        write([age24=Age24, age25=Age25, age26=Age26]),nl,
        write([king=King, prince=Prince, queen=Queen]),nl,
        write([leon=Leon, mark=Mark, rob=Rob]),nl,
        write([classical=Classical, jazz=Jazz, pop=Pop]),nl.


% lookup the solution given the age list
get_sol(List,Lookup,Sol) :-
        Sol @= [Val : L in List, [Ix,Val], 
                (Ix is L - 23, nth(Ix,Lookup,Val))].
                

music_men([Age,Names,Surnames,Music]) :-

        Age      = [Age24, Age25, Age26],
        Names    = [King, Prince, Queen],
        Surnames = [Leon, Mark, Rob],
        Music    = [Classical, Jazz, Pop],

        Age      = [24,25,26],
        Names    :: 24..26,
        Surnames :: 24..26,
        Music    :: 24..26,

        alldifferent(Age),
        alldifferent(Names),
        alldifferent(Surnames),
        alldifferent(Music),

        % Age
        Age24 #= 24,
        Age25 #= 25,
        Age26 #= 26,

        % Rob is older than Queen, who likes classical music.
        Rob #> Queen,
        Queen #= Classical,

        % The pop-music fan, who is not Prince, is not 24.
        Pop #\= Prince,
        Pop #\= Age24,

        % Leon, who is not King, is 25.
        Leon #\= King,
        Leon #= Age25,

        %  Mark's musical preference is not jazz.
        Mark #\= Jazz,

        term_variables([Names,Surnames,Music],Vars),

        labeling([], Vars).

