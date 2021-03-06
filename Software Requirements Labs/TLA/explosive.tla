---------------------------- MODULE explosive ----------------------------
EXTENDS Integers, Sequences, TLC
CONSTANTS ID, N
ASSUME N > 0
VARIABLES
taken_id,
explosives,
xbound,
ybound,
spaces,
larger
vars == <<taken_id, explosives, xbound, ybound, spaces, larger>>
UNIT == 0 .. N
UNIT_RECORD == [x : UNIT, y : UNIT]
POSITION == {r \in UNIT_RECORD : r.x < N /\ r.y < N}
DIMENSION == {r \in UNIT_RECORD : r.x > 0 /\ r.y > 0}
EXPLOSIVE == [p: POSITION, d: DIMENSION]
TypeOk ==
/\ taken_id \subseteq ID
/\ explosives \in [taken_id -> EXPLOSIVE]
/\ xbound \in Int
/\ ybound \in Int
/\ spaces \subseteq POSITION
/\ larger \subseteq taken_id
Init ==
/\ taken_id = {}
/\ explosives = << >>
/\ xbound = 0
/\ ybound = 0
/\ spaces = {}
/\ larger = {}
IdOk == taken_id = DOMAIN explosives
NoOverlap ==
/\ \A i \in taken_id: \A j \in taken_id \ {i}:
\/ explosives[i].p.x >= explosives[j].p.x + explosives[j].d.x
\/ explosives[i].p.y >= explosives[j].p.y + explosives[j].d.y
\/ explosives[j].p.x >= explosives[i].p.x + explosives[i].d.x
\/ explosives[j].p.y >= explosives[i].p.y + explosives[i].d.y
NoOutside ==
\A id \in taken_id :
/\ explosives[id].p.x + explosives[id].d.x <= xbound
/\ explosives[id].p.y + explosives[id].d.y <= ybound
/\ explosives[id].p.x >= 0
/\ explosives[id].p.y >= 0
new_store(xdim, ydim) ==
/\ taken_id = {}
/\ N >= xdim
/\ xdim > 0
/\ N >= ydim
/\ xdim > 0
/\ xbound’ = xdim
/\ ybound’ = ydim
/\ UNCHANGED explosives
/\ UNCHANGED taken_id
/\ UNCHANGED spaces
/\ UNCHANGED larger
/\ Print(<<"new_store",xdim,ydim>>, TRUE)
put(id,dim,pos) ==
/\ id \in ID
/\ id \notin taken_id
/\ pos.x >= 0
/\ pos.y >= 0
/\ dim.x > 0
/\ dim.y > 0
/\ (pos.x + dim.x) <= xbound
/\ (pos.y + dim.y) <= ybound
/\ \A ide \in taken_id:
\/ pos.x >= explosives[ide].p.x + explosives[ide].d.x
\/ pos.y >= explosives[ide].p.y + explosives[ide].d.y
\/ pos.x + dim.x <= explosives[ide].p.x
\/ pos.y + dim.y <= explosives[ide].p.y
/\ taken_id’ = taken_id \union {id}
/\ explosives’ = explosives @@ id:>[p |-> pos, d |-> dim]
/\ UNCHANGED xbound
/\ UNCHANGED ybound
/\ UNCHANGED spaces
/\ UNCHANGED larger
/\ Print(<<"put",id,dim,pos>>, TRUE)
remove(id) ==
/\ xbound > 0
/\ ybound > 0
/\ id \in taken_id
/\ explosives’ = [x \in DOMAIN explosives \ {id} |-> explosives[x]]
/\ taken_id’ = taken_id \ {id}
/\ UNCHANGED xbound
/\ UNCHANGED ybound
/\ UNCHANGED spaces
/\ UNCHANGED larger
/\ Print(<<"remove",id>>, TRUE)
suggest(s) ==
/\ xbound > 0
/\ ybound > 0
/\ s \in DIMENSION
/\ s.x =< xbound
/\ s.y =< ybound
/\ spaces’ = {}
/\ \A i \in 0 .. xbound, j \in 0 .. ybound, id \in taken_id:
/\ \/ i >= explosives[id].p.x + explosives[id].d.x
\/ j >= explosives[id].p.y + explosives[id].d.y
\/ i + s.x <= explosives[id].p.x
\/ j + s.y <= explosives[id].p.y
/\ spaces’ = spaces \union {<<i,j>>}
/\ UNCHANGED xbound
/\ UNCHANGED ybound
/\ UNCHANGED explosives
/\ UNCHANGED taken_id
/\ UNCHANGED larger
/\ Print(<<"suggest",s>>, TRUE)
large_explosives(xdim,ydim) ==
/\ xbound >= xdim
/\ xdim > 0
/\ ybound >= ydim
/\ xdim > 0
/\ larger’ = {}
/\ \A i \in 0 .. xbound, j \in 0 .. ybound, id \in taken_id:
/\ /\ i <= explosives[id].d.x
/\ j <= explosives[id].d.y
/\ larger’ = larger \union {id}
/\ UNCHANGED xbound
/\ UNCHANGED ybound
/\ UNCHANGED explosives
/\ UNCHANGED taken_id
/\ UNCHANGED spaces
/\ Print(<<"large_explosives",xdim,ydim>>, TRUE)
Next ==
\/ \E r \in DIMENSION: new_store(r.x,r.y)
\/ \E id \in ID, d \in DIMENSION, p \in POSITION: put(id,d,p)
\/ \E id \in ID: remove(id)
\/ \E r \in DIMENSION: suggest(r)
\/ \E r \in DIMENSION: large_explosives(r.x,r.y)
Spec ==
/\ Init
/\ [][Next]_vars
====
