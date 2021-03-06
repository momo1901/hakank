/*

  Mr Greenguest puzzle (fancy dress) in ECLiPSe.

  Problem (and LPL) code in
 
  http://diuflx71.unifr.ch/lpl/GetModel?name=/demo/demo2
 
  """
  (** Mr. Greenfan wants to give a dress party where the male guests
   * must wear green dresses. The following rules are given:
   * 1 If someone wears a green tie he has to wear a green shirt.
   * 2 A guest may only wear green socks and a green shirt 
   *   if he wears a green tie or a green hat.
   * 3 A guest wearing a green shirt or a green hat or who does
   *   not wear green socks must wear a green tie.
   * 4 A guest who is not dressed according to rules 1-3 must
   *   pay a $11 entrance fee.
   * Mr Greenguest wants to participate but owns only a green shirt 
   * (otherwise he would have to pay one for $9). He could buy 
   * a green tie for $10, a green hat (used) for $2 and green socks
   * for $12.
   * What is the cheapest solution for Mr Greenguest to participate?
   *)
  """

  Compare with the following models:
  * MiniZinc: http://www.hakank.org/minizinc/fancy.mzn
  * SICStus Prolog: http://www.hakank.org/sicstus/fancy.pl


  Model created by Hakan Kjellerstrand, hakank@bonetmail.com
  See also my ECLiPSe page: http://www.hakank.org/eclipse/

*/

:-lib(ic).
%:-lib(ic_global).
:-lib(ic_search).
:-lib(branch_and_bound).
%:-lib(listut).
%:-lib(propia).

go :-
        LD = [T,H,R,S,N],
        LD :: 0..1,

        Cost :: 0..10000,

        % This is a straight translation from the LPL 
        % (as well as MiniZinc) code
        ( ((T #=1) => (R #=1)) or N#=1),
        ( ((S #=1 or R#=1) => (T#=1 or H#=1)) or N#=1),
        ( ((R#=1 or H#=1 or neg(S#=1)) => T#=1) or N#=1 ),
        Cost #= 10*T + 2*H + 12*S + 11*N,

        term_variables([LD,Cost],Vars),
        minimize(search(Vars,0,first_fail,indomain_min,complete,[]),Cost),

        write(t:T),nl,
        write(h:H),nl,
        write(r:R),nl,
        write(s:S),nl,
        write(n:N),nl,
        write(cost:Cost),nl.
        
